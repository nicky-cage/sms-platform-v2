<?php

declare(strict_types=1);

namespace App\Http\Common;

use App\Model\Model;
use Exception;
use Hyperf\Contract\SessionInterface;
use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Annotation\{GetMapping, PostMapping};
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\Redis\Redis;
use Hyperf\View\RenderInterface;
use Psr\Http\Message\ResponseInterface;

abstract class BackendController extends BaseController
{
    use BaseCommonTrait;
    use BaseJsonTrait;

    /**
     * 应用名称
     * @var string
     */
    protected static string $appName = '';
    /**
     * @var string
     */
    protected static string $modelName = '';
    /**
     * 禁止使用的操作
     * @var array
     */
    protected static array $disabledOperations = [];
    /**
     * @var array
     */
    protected static array $mappedCacheClasses = [];
    /**
     * @var array|string[]
     */
    protected static array $ignoreFields = ['file'];
    #[Inject(lazy: true)]
    protected Model $model;
    /**
     * @var SessionInterface
     */
    #[Inject]
    protected SessionInterface $session;
    /**
     *
     */
    #[Inject]
    protected Redis $redis;

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @return ResponseInterface
     */
    #[GetMapping(path: 'list')]
    public function list(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        if (in_array('list', static::$disabledOperations)) {
            return self::error($request, $render, '禁止操作: list');
        }
        $modelClass = static::$modelName;
        return $this->listAction($request, $render, new $modelClass());
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @param string $message
     * @return ResponseInterface
     */
    protected static function error(RequestInterface $request, RenderInterface $render, string $message = '出错了'): ResponseInterface
    {
        $viewFile = 'index/error';
        return self::render($request, $render, [
            'message' => $message,
        ], $viewFile);
    }

    /**
     * 后台默认首页
     * @param RenderInterface $render
     * @param RequestInterface $request
     * @param Model $model
     * @param array $data
     * @param array $conditions 条件: ['where' => '', 'order_by' => '', ]
     * @return ResponseInterface
     */
    protected function listAction(RequestInterface $request, RenderInterface $render, Model $model, array $data = [], array $conditions = []): ResponseInterface
    {
        $cond = $this->getQueryCond($request); // 查询条件
        $where = $this->getProcessedCond($cond, $request);

        $orderBy = $this->getOrderBy($request); // orderBy
        $orderSort = $this->getOrderSort($request); // orderSort
        if (isset($conditions['where'])) {
            foreach ($conditions['where'] as $r) {
                $where[] = $r;
            }
        }
        $currentCond = $this->getQueryCurrent($request);
        $where = array_merge($where, $currentCond);
        $pager = $data['pager'] ?? $model::where($where)->orderBy($orderBy, $orderSort)->paginate(15); // 如果已存在, 则使用已有分页
        $controller = self::getControllerName($request);
        $viewFile = (function () use ($request, $controller) {
            $actionName = self::getActionName($request);
            $isDefault = $actionName == 'list';
            $action = self::isAjax($request) ? '_' . ($isDefault ? '' : 'list_') . $actionName : $actionName;
            return $controller . '/' . $action;
        })();
        $this->getViewFile($request) != '' ? $viewFile = $this->getViewFile($request) : $viewFile;
        $total = $data['total'] ?? $pager->total();
        $rows = $pager->items();

        $listData = $this->listAfter($request, $rows);
        $this->processRows($rows);
        $viewData = array_merge([
            'controller' => $controller,
            'rows' => $rows,
            'total' => $total,
        ], $data, $listData);
        return self::render($request, $render, $viewData, $viewFile);
    }

    /**
     * 获取查询条件
     * @param RequestInterface $request
     * @return array
     */
    protected function getQueryCond(RequestInterface $request): array
    {
        return [];
    }

    /**
     * @param array $cond
     * @param RequestInterface $request
     * @return array
     */
    protected function getProcessedCond(array $cond, RequestInterface $request): array
    {
        $where = [];
        $params = $request->all();

        // 完全匹配
        if (isset($cond['='])) {
            if (is_array($cond['='])) {
                $arr = $cond['=']; // ['post field name' => 'table field name']
                foreach ($arr as $k => $v) {
                    if (isset($params[$k])) {
                        $where[] = [$v, '=', $params[$k]];
                    }
                }
            }
            if (is_string($cond['='])) {
                $fields = explode(',', $cond['=']);
                foreach ($fields as $field) {
                    $real_field = trim($field);
                    if (isset($params[$real_field])) {
                        $where[] = [$real_field, '=', $params[$real_field]];
                    }
                }
            }
        }

        // 模糊匹配
        if (isset($cond['%'])) {
            if (is_array($cond['%'])) {
                $arr = $cond['%']; // ['post field name' => 'table field name']
                foreach ($arr as $k => $v) {
                    if (isset($params[$k])) {
                        $where[] = [$v, 'LIKE', '%' . $params[$k] . '%'];
                    }
                }
            }
            if (is_string($cond['%'])) {
                $fields = explode(',', $cond['%']);
                foreach ($fields as $field) {
                    $real_field = trim($field);
                    if (isset($params[$real_field])) {
                        $where[] = [$real_field, 'LIKE', '%' . $params[$real_field] . '%'];
                    }
                }
            }
        }

        if (isset($cond['between'])) {
            $rArr = explode(',', $cond['between']);
            foreach ($rArr as $r) {
                $field = trim($r);
                if ($field == '') {
                    continue;
                }

                // -- 先判断是否是数字字字段
                $field_start = $field . '_start';
                $field_end = $field . '_end';
                $value_start = trim($params[$field_start] ?? '');
                $value_end = trim($params[$field_end] ?? '');
                if ($value_start || $value_end) {
                    if ($value_start) {
                        $where[] = [$field, '>=', $value_start];
                    }
                    if ($value_end) {  // 说明是数字范围字段
                        $where[] = [$field, '<=', $value_end];
                    }
                    continue;
                }

                // -- 再判断是否是时间区间
                $request_field = 'between_' . $field;
                // 这是时间字段
                $val = explode(' - ', $params[$request_field] ?? '');
                if (count($val) != 2) {
                    continue;
                }
                $value_start = trim($val[0]);
                $value_end = ($val[1]);
                // 需要检测是否是日期
                $is_datetime = ($field == 'created' || $field == 'create_time') && preg_match('/\d{4}\-\d{2}\-\d{2}/', $value_start);
                $where[] = [$field, '>=', $is_datetime ? strtotime($value_start) : $value_start];
                $where[] = [$field, '<=', $is_datetime ? strtotime($value_end) : $value_end];
            }
        }

        return $where ?? $cond;
    }

    /**
     * @param RequestInterface $request
     * @return string
     */
    protected function getOrderBy(RequestInterface $request): string
    {
        return 'id';
    }

    /**
     * @param RequestInterface $request
     * @return string
     */
    protected function getOrderSort(RequestInterface $request): string
    {
        return 'DESC';
    }

    /**
     * @param RequestInterface $request
     * @return array
     */
    protected function getQueryCurrent(RequestInterface $request): array
    {
        return [];
    }

    /**指定视图返回文件
     * @param RequestInterface $request
     * @return string
     *
     */
    protected function getViewFile(RequestInterface $request): string
    {
        return '';
    }

    /**
     * @param RequestInterface $request
     * @param array $data
     * @return array
     */
    protected function listAfter(RequestInterface $request, array $data = []): array
    {
        return [];
    }

    /**
     * @param array $rows
     * @return void
     */
    protected function processRows(array &$rows)
    {
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @return mixed
     */
    #[GetMapping(path: 'create')]
    public function create(RequestInterface $request, RenderInterface $render)
    {
        if (in_array('create', static::$disabledOperations)) {
            return self::error($request, $render, '禁止操作: create');
        }
        $modelClass = static::$modelName;
        return $this->createAction($request, $render, new $modelClass());
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @param Model $model
     * @param array $data
     * @return mixed
     */
    protected function createAction(RequestInterface $request, RenderInterface $render, Model $model, array $data = []): ResponseInterface
    {
        $controller = self::getControllerName($request);
        $viewFile = $controller . '/edit';
        return $this->editAction($request, $render, $model, array_merge([
            'controller' => $controller,
            'r' => $model,
        ], $data), $viewFile);
    }

    /**
     * @param RenderInterface $render
     * @param RequestInterface $request
     * @param Model $model
     * @param array $data
     * @param string $viewFile
     * @return mixed
     */
    protected function editAction(RequestInterface $request, RenderInterface $render, Model $model, array $data = [], string $viewFile = ''): ResponseInterface
    {
        if (!$viewFile) {
            $viewFile = self::getControllerName($request) . '/edit';
        }
        $viewData = array_merge($this->editAfter($request, $data), $data);
        return self::render($request, $render, $viewData, $viewFile);
    }

    /**
     * @param RequestInterface $request
     * @param array $data
     * @return array
     */
    protected function editAfter(RequestInterface $request, array $data = []): array
    {
        return [];
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @return ResponseInterface
     */
    #[GetMapping(path: 'update')]
    public function update(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        if (in_array('update', static::$disabledOperations)) {
            return self::error($request, $render, '禁止操作: update');
        }
        $className = static::$modelName;
        return $this->updateAction($request, $render, new $className());
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @param Model $model
     * @param array $data
     * @return mixed
     */
    protected function updateAction(RequestInterface $request, RenderInterface $render, Model $model, array $data = []): ResponseInterface
    {
        $id = $request->query('id'); // 记录编号
        if (!$id || !is_numeric($id)) {
            return self::error($request, $render, '编号有误');
        }

        $row = $model::query()->where(['id' => $id])->first(); // 当前记录
        $controller = self::getControllerName($request);
        $viewFile = $controller . '/edit';
        return $this->editAction($request, $render, $model, array_merge([
            'controller' => $controller,
            'r' => $row,
        ], $data), $viewFile);
    }

    /**
     * @param RequestInterface $request
     * @return array
     */
    #[PostMapping(path: 'save')]
    public function save(RequestInterface $request): array
    {
        $className = static::$modelName;
        return $this->saveAction($request, new $className());
    }

    /**
     * save the row
     */
    protected function saveAction(RequestInterface $request, Model $model): array
    {
        $data = array_map(function ($v) {
            return trim($v);
        }, $request->post());
        $isCreate = true;
        $id = 0;
        if (isset($data['id'])) {
            $id = intval($data['id']);
            if ($id == 0) {
                unset($data['id']);
            } else {
                $isCreate = false;
            }
        }
        foreach ($data as $field => $val) {
            if (in_array($field, static::$ignoreFields)) {
                unset($data[$field]);
            }
        }

        // -- 如果添加记录
        if ($isCreate) {
            if (isset(static::$validations) && (isset(static::$validations['save'])) || isset(static::$validations['create'])) {
                $validationData = static::$validations['create'] ?? static::$validations['save'];
                $validationName = isset(static::$validations['create']) ? 'create' : 'save';
                $err = $this->validate($validationData, $validationName);
                if ($err != '') {
                    return self::jsonErr($err);
                }
            }
            if (!$this->createBefore($data)) {
                return self::jsonErr('创建记录或者校验出错');
            }
            if (!$this->saveBefore($request, $data)) {
                return self::jsonErr('保存创建记录或者校验出错');
            }
            foreach ($data as $field => $value) {
                $model->$field = $value;
            }
            if (!$model->save()) {
                return self::jsonErr('保存数据发生错误');
            }
            $data['id'] = $model->id;
            static::clearCache(); // 清理存
            $this->saveAfter($request, $data, '添加'); // 保存之后处理操作
            return self::jsonOK();
        }

        // -- 如果修改记录
        if (isset(static::$validations) && (isset(static::$validations['save'])) || isset(static::$validations['update'])) {
            $validationData = static::$validations['update'] ?? static::$validations['save'];
            $validationName = isset(static::$validations['update']) ? 'update' : 'save';
            $err = $this->validate($validationData, $validationName);
            if ($err != '') {
                return self::jsonErr($err);
            }
        }
        if (!$this->updateBefore($data)) {
            return self::jsonErr('修改记录或者校验失败');
        }
        if (!$this->saveBefore($request, $data)) {
            return self::jsonErr('保存修改记录或者校验出错');
        }
        if ($model::query()->where('id', $id)->update($data)) { // 修改
            static::clearCache(); // 清理缓存
            $this->saveAfter($request, $data, '修改'); // 保存处理操作
            return self::jsonOK();
        }

        return self::jsonErr('保存数据失败');
    }

    /**
     * @param array $data
     * @return bool
     */
    protected function createBefore(array &$data): bool
    {
        return true;
    }

    /**
     * @return void
     */
    protected static function clearCache()
    {
        foreach (static::$mappedCacheClasses as $className) {
            $className::clear();
        }
    }

    /**
     * 
     */
    protected function saveBefore(RequestInterface $request, array &$data): bool
    {
        return true;
    }

    /**
     * @param RequestInterface $request
     * @param array $data
     * @param string $action
     * @return void
     */
    protected function saveAfter(RequestInterface $request, array $data, string $action)
    {
    }

    /**
     * @param array $data
     * @return bool
     */
    protected function updateBefore(array &$data): bool
    {
        return true;
    }

    /**
     * 删除记录信息
     * @param RequestInterface $request
     * @return array
     */
    #[GetMapping(path: 'delete')]
    public function delete(RequestInterface $request): array
    {
        $id = $request->query('id'); // 记录编号
        if (!$id || !is_numeric($id)) {
            return self::jsonErr('获取记录编号失败');
        }

        $class = static::$modelName;
        $row = $class::query()->where(['id' => $id])->first();
        if (!$row) {
            return self::jsonErr('获取记录信息失败');
        }
        try {
            if ($row->delete()) {
                static::clearCache();
                $this->deleteAfter($request, $row);
                return self::jsonOk();
            }
            return self::jsonErr('删除记录失败');
        } catch (Exception $err) {
            return self::jsonErr('删除记录失败: ' . $err->getMessage());
        }
    }

    /**
     * @param RequestInterface $request
     * @param Model $row
     * @return void
     */
    protected function deleteAfter(RequestInterface $request, Model $row)
    {
    }

    /**
     * @param RequestInterface $request
     * @return array
     */
    #[GetMapping(path: 'state')]
    public function state(RequestInterface $request): array
    {
        $id = $request->query('id'); // 记录编号
        if (!$id || !is_numeric($id)) {
            return self::jsonErr('获取记录编号失败');
        }

        $field = $request->query('name', 'state');
        $toField = 'to_' . $field;
        $toState = intval($request->query($toField, '0')); // 要更改到的状态
        if (!is_numeric($toState)) {
            return self::jsonErr('状态获取失败');
        }

        // 得到记录信息
        $class = static::$modelName;
        $row = $class::query()->where(['id' => $id])->first();
        if (!$row) {
            return self::jsonErr('获取记录信息失败');
        }
        if (!isset($row->$field)) {
            return self::jsonErr('获取记录状态失败');
        }
        if ($row->$field == $toState) {
            return self::jsonErr('状态处理失败');
        }
        $row->$field = $toState;
        if (!$row->save()) {
            return self::jsonErr('状态修改失败');
        }

        static::clearCache();
        $this->stateAfter($request, $row, $toState);
        return self::jsonOK();
    }

    /**
     * @param RequestInterface $request
     * @param Model $row
     * @param int $toState
     * @return void
     */
    protected function stateAfter(RequestInterface $request, Model $row, int $toState)
    {
    }
}
