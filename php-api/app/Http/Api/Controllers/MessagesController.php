<?php

declare(strict_types=1);

namespace App\Http\Api\Controllers;

use App\Common\{Utils};
use App\Http\Api\Common\BasePay;
use App\Model\{MerchantApp, MerchantAccount, Message, Country, MessageTemplate, Merchant};
use Hyperf\HttpServer\Annotation\{Controller, GetMapping, RequestMapping};
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\View\RenderInterface;
use Psr\Http\Message\ResponseInterface;

#[Controller(prefix: "/v2")]
class MessagesController extends BaseController
{

    const RETURN_TYPE_JSON = 1;
    const RETURN_TYPE_CONTENT = 2;
    const SEND_TYPE_MESSAGE = 1;
    const SEND_TYPE_CODE = 2;

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
        $postedData = $request->all(); // 提交数据
        $returnData = [];
        $errMsg = self::saveMessage($postedData, self::SEND_TYPE_MESSAGE, $returnData, $request);
        if ($errMsg) {
            return self::jsonErr($errMsg);
        }

        return self::jsonResult($returnData);
    }

    /**
     * 发送短信校验码
     * @param RequestInterface $request
     * @return array
     */
    #[RequestMapping(path: "send_verify", methods: "get, post")]
    public function send_verify(RequestInterface $request): array
    {
        $postedData = $request->all(); // 提交数据
        $returnData = [];
        $errMsg = self::saveMessage($postedData, self::SEND_TYPE_CODE ,$returnData, $request);
        if ($errMsg) {
            return self::jsonErr($errMsg);
        }

        return self::jsonResult($returnData);
    }

    /**
     * 检测签名相关
     * @param array $data
     * @param string $errMsg
     * @return MerchantApp|null
     */
    private static function checkSign(array $data, string &$errMsg): ?Merchantapp {
        $appId = intval($data['app_id']);
        $merchantApp = MerchantApp::query()->find($appId);
        if (!$merchantApp) {
            $errMsg =  '商户相关信息检测失败';
            return null;
        }

        $appKey = $merchantApp->app_key;
        $sign = trim($data['sign']);
        ksort($data);
        $signStr = '';
        foreach ($data as $key => $value) {
            if ($key == 'sign' || $value == '') {
                continue;
            }
            $signStr .= "${key}=${value}&";
        }
        $signStr .= "key=${appKey}";
        if ($sign != md5($signStr)) {
            $errMsg = '签名验证失败';
            return null;
        }

        return $merchantApp;
    }

    /**
     * 保存信息到数据库当中
     * @param array $postedData
     * @param int $type
     * @param array $returnData
     * @param RequestInterface $request
     * @return string|null
     */
    private static function saveMessage(array $postedData, int $type, array &$returnData, RequestInterface $request): ?string {
        // ------------------ 数据检测 ---------------------------------- //
        if (!isset($postedData['app_id']) || !is_numeric($postedData['app_id'])) { // 必须提供商户编号
            return '缺少商户编号';
        }
        if (!isset($postedData['sign'])) { // 缺少签名
            return '缺少下单签名';
        }
        if (!isset($postedData['receiver_number']) || !is_numeric($postedData['receiver_number'])) { // 缺少接收号码
            return '缺少接收手机号码或者手机号码有误';
        }

        $isVerify = $type == self::SEND_TYPE_CODE; // 是否是发送验证码
        if ($isVerify && (!isset($postedData['code']) || !is_numeric($postedData['code']))) { // 缺少验证码
            return '缺少验证号码或者验证号码有误';
        }
        if ($isVerify && (!isset($postedData['template_id']) || !is_numeric($postedData['template_id']))) { // 模板id
            return '缺少模板ID或者模板有误';
        }
        if (!$isVerify && !isset($postedData['content'])) { // 缺少短信内容 - 如果不是短信验证码, 必须输入短信内容
            return '缺少短信内容';
        }

        $errMsg = '';
        $merchantApp = self::checkSign($postedData, $errMsg);
        if (!$merchantApp) {
            return $errMsg;
        }
        $allowIPList = array_map(function($r) {
            return trim($r);
            }, explode(',', $merchantApp->allow_ip ?? ''));
        $clientIP = Utils::clientIP($request);
        if (!in_array($clientIP, $allowIPList)) {
            return 'IP未经授权:'. $clientIP;
        }

        $merchant = Merchant::query()->where([
            'id' => $merchantApp->merchant_id,
        ])->first();
        if (!$merchant) {
            return '无法获取商户信息';
        }
        if (!$merchant->country_list) {
            return '无法获取商户配置国家信息';
        }
        $countryList = json_decode($merchant->country_list);
        $countryRow = $countryList[0] ?? null;
        if (!$countryRow || !isset($countryRow->country_id)) {
            return '无法获取商户配置国家相关信息';
        }

        // 检测账号余额
        $merchantAcc = MerchantAccount::query()->where([
            'merchant_id' => $merchant->id,
        ])->first();
        if (!$merchantAcc) {
            return '无法获取商户账户信息';
        }
        if ($merchantAcc->remain < 1) {
            return '商户可用余额不足';
        }

        $country = Country::query()->where([
            'id' => $countryRow->country_id,
            'is_support' => 1,
        ])->first();
        if (!$country) {
            return '缺少可发送国家信息';
        }

        $templateID = 0;
        $content = trim($postedData['content'] ?? '');
        if ($isVerify) {
            $tpl = MessageTemplate::query()->where([
                // 'app_id' => $merchantApp->id,
                'merchant_id' => $merchantApp->merchant_id,
                'id' => intval($postedData['template_id']),
            ])->first();
            if (!$tpl) {
                return '短信发送渠道有误';
            }
            $templateID = $tpl->id;
            $content = str_replace('${code}', trim($postedData['code']), $tpl->content);
        }

        $channelID = $merchant->channel_list ?? 0;
        $orderNumber = Utils::getOrderNumber('NP');
        $phoneFull = '+'. $country->phone_prefix. ' '. $postedData['receiver_number'];
        $savingData = [
            'merchant_id' => $merchantApp->merchant_id,
            'merchant_name' => $merchantApp->merchant_name,
            'app_id' => $merchantApp->id,
            'channel_id' => $channelID,
            'app_name' => $merchantApp->name,
            'order_number' => $orderNumber,
            'country_id' => $country->id,
            'phone' => $postedData['receiver_number'],
            'phone_prefix' => $country->phone_prefix,
            'phone_full' => $phoneFull,
            'created' => time(),
            'template_id' => $templateID,
            'content' => $content,
            'notify_url' => trim($postedData['notify_url'] ?? ''),
        ];
        (new Message())->insert($savingData);
        DB::table('merchant_accounts')->where([
            'id' => $merchantAcc->id,
            'merchant_d' => $merchant->id,
        ])->update([
            'remain' => $merchantAcc->remain - 1,
            'frozen' => $merchantAcc->frozen + 1,
        ]);
        Message::pushForSend($savingData);

        $returnData = [
            'order_number' => $orderNumber,
        ];
        $returnData['sign'] = Utils::getSign($returnData, $merchantApp->app_key);
        return null;
    }
}
