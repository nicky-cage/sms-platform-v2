<?php

declare(strict_types=1);

namespace App\Http\Api\Controllers;

use App\Common\{Utils};
use App\Http\Api\Common\BasePay;
use App\Model\{MerchantApp};
use Hyperf\HttpServer\Annotation\{Controller, GetMapping, RequestMapping};
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\View\RenderInterface;
use Psr\Http\Message\ResponseInterface;

#[Controller(prefix: "/v1")]
class MessagesController extends BaseController
{

    const RETURN_TYPE_JSON = 1;
    const RETURN_TYPE_CONTENT = 2;

    // -- 测试环境 -- 
    // q2m7zCZYWc4IkVb1vaoiWzdYuGxhVL5g
    // 348193

    /**
     * 查询订单信息
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @return array
     */
    #[RequestMapping(path: "info", methods: "get, post")]
    public function info(RequestInterface $request, RenderInterface $render): array
    {
        $postedData = $request->all(); // 提交数据
        if (!isset($postedData['app_id']) || !is_numeric($postedData['app_id'])) { // 必须提供商户编号
            return self::error($request, $render, '缺少商户编号');
        }
        if (!isset($postedData['sign'])) { // 缺少签名
            return self::jsonErr('缺少下单签名');
        }
        if (!isset($postedData['order_number'])) { // 发起方订单号码
            return self::error($request, $render, '缺少订单编号信息');
        }
        if (!isset($postedData['time']) || !is_numeric($postedData['time'])) { // 提交时间
            return self::jsonErr('缺少下单时间信息时间');
        }
        $time = $postedData['time'];
        if (!is_numeric($time) || $time < time() - 300) { // 必须在10秒内处理
            return self::jsonErr('订单时间不对或者下单超时');
        }

        // 检测签名相关
        $appId = $postedData['app_id'];
        $merchantApp = MerchantApp::query()->find($appId);
        if (!$merchantApp) {
            return self::jsonErr('商户相关信息检测失败');
        }

        return self::jsonOk();
    }

    /**
     * @param RequestInterface $request
     * @param RenderInterface $render
     * @param string $message
     * @return ResponseInterface
     */
    protected static function error(RequestInterface $request, RenderInterface $render, string $message = '程序执行发生错误'): ResponseInterface
    {
        return self::render($request, $render, [
            'message' => $message,
        ], 'error');
    }

    /**
     * 查询账户余额
     * @param RequestInterface $request
     * @return array
     */
    #[GetMapping(path: "balance")]
    public function balance(RequestInterface $request): array
    {
        // ------------------ 数据检测 ---------------------------------- //
        $postedData = $request->all(); // 提交数据
        if (!isset($postedData['app_id']) || !is_numeric($postedData['app_id'])) { // 必须提供商户编号
            return self::jsonErr('缺少商户编号');
        }
        if (!isset($postedData['sign'])) { // 缺少签名
            return self::jsonErr('缺少下单签名');
        }
        if (!isset($postedData['time'])) { // 提交时间
            return self::jsonErr('缺少下单时间信息时间');
        }
        $time = $postedData['time'];
        if (!is_numeric($time) || $time < time() - 300) { // 必须在10秒内处理
            return self::jsonErr('订单时间不对或者下单超时');
        }

        // ------------------ 数据处理 ---------------------------------- //
        // $postedData['client_ip'] = $clientIP; // 设置来源IP
        return self::jsonOk();
    }

    /**
     * 发送短信息
     * @param RequestInterface $request
     * @return array
     */
    #[RequestMapping(path: "send_message", methods: "get, post")]
    public function sendMessage(RequestInterface $request): array
    {
        // ------------------ 数据检测 ---------------------------------- //
        $postedData = $request->all(); // 提交数据
        if (!isset($postedData['app_id']) || !is_numeric($postedData['app_id'])) { // 必须提供商户编号
            return self::jsonErr('缺少商户编号');
        }
        if (!isset($postedData['sign'])) { // 缺少签名
            return self::jsonErr('缺少下单签名');
        }
        if (!isset($postedData['time'])) { // 提交时间
            return self::jsonErr('缺少下单时间信息时间');
        }
        $time = $postedData['time'];
        if (!is_numeric($time) || $time < time() - 300) { // 必须在10秒内处理
            return self::jsonErr('订单时间不对或者下单超时');
        }

        // ------------------ 数据处理 ---------------------------------- //
        // $clientIP = Utils::clientIP($request);
        // $postedData['client_ip'] = $clientIP; // 设置来源IP
        // $result = (object)BasePay::balance($postedData); // 如果出现错误, 则直接输出错误信息
        // if ($result->code != 0) { // 如果没有错误
        //     return self::jsonErr($result->message);
        // }

        return self::jsonOk();
    }

    /**
     * 发送短信校验码
     * @param RequestInterface $request
     * @return array
     */
    #[RequestMapping(path: "send_verify", methods: "get, post")]
    public function send_verify(RequestInterface $request): array
    {
        // ------------------ 数据检测 ---------------------------------- //
        $postedData = $request->all(); // 提交数据
        if (!isset($postedData['app_id']) || !is_numeric($postedData['app_id'])) { // 必须提供商户编号
            return self::jsonErr('缺少商户编号');
        }
        if (!isset($postedData['sign'])) { // 缺少签名
            return self::jsonErr('缺少下单签名');
        }
        if (!isset($postedData['time'])) { // 提交时间
            return self::jsonErr('缺少下单时间信息时间');
        }
        $time = $postedData['time'];
        if (!is_numeric($time) || $time < time() - 300) { // 必须在10秒内处理
            return self::jsonErr('订单时间不对或者下单超时');
        }

        // ------------------ 数据处理 ---------------------------------- //
        // $clientIP = Utils::clientIP($request);
        // $postedData['client_ip'] = $clientIP; // 设置来源IP
        return self::jsonOk();
    }
}
