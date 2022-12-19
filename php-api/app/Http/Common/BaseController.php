<?php

declare(strict_types=1);

namespace App\Http\Common;

use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\View\RenderInterface;
use Hyperf\Validation\Contract\ValidatorFactoryInterface;
use Psr\Http\Message\ResponseInterface;

abstract class BaseController
{
    use BaseCommonTrait;
    use BaseJsonTrait;

    /**
     * 应用名称
     * @var string
     */
    protected static string $appName = '';

    /**
     * @var array
     */
    protected static array $validations = [];

    /**
     * @var ValidatorFactoryInterface
     */
    #[Inject]
    protected ValidatorFactoryInterface $validationFactory;

    /**
     * 系统默认渲染方式
     *
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @param array $data
     * @param string $viewFile
     * @return ResponseInterface
     */
    protected static function render(RequestInterface $request, RenderInterface $render, array $data = [], string $viewFile = ''): ResponseInterface
    {
        $controller = $data['controller'] ?? self::getControllerName($request);
        if ($viewFile == '') {
            $action = self::getActionName($request);
            $viewFile = $controller . '/' . $action;
        }

        return $render->render(static::$appName . '/' . $viewFile, array_merge([
            'STATIC_URL' => '/static', // 静态文件
            'UPLOAD_URL' => '',
            'controller' => $controller,
        ], $data));
    }

    /**
     * 得到控制器名称
     * @return mixed|string
     */
    protected static function getControllerName(RequestInterface $request)
    {
        $path = trim($request->getPathInfo(), '/');
        $controller = 'index';
        $acInfo = explode('/', $path);
        if (!empty($acInfo[1])) {
            $controller = $acInfo[1];
        }
        return $controller;
    }

    /**
     * 得到方法名称
     * @return mixed|string
     */
    protected static function getActionName(RequestInterface $request)
    {
        $path = trim($request->getPathInfo(), '/');
        $action = 'index';
        $acInfo = explode('/', $path);
        if (!empty($acInfo[2])) {
            $action = $acInfo[2];
        }
        return $action;
    }

    /**
     * @param array $data
     * @param string $validationName
     * @return string
     */
    protected function validate(array $data, string $validationName): string
    {
        $validator = $this->validationFactory->make($data, static::$validations[$validationName]['rules'], static::$validations[$validationName]['messages']);
        if ($validator->fails()) {
            return $validator->errors()->first();
        }
        return '';
    }
}
