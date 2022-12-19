<?php

declare(strict_types=1);

namespace App\Http\Api\Controllers;

use App\Common\Utils;
use App\Http\Api\Common\BasePay;
use App\Model\{Channel, ChannelPayment, MerchantApp, Order};
use Hyperf\HttpServer\Annotation\{Controller, GetMapping, RequestMapping};
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\View\RenderInterface;
use Psr\Http\Message\ResponseInterface;
use App\Constants\Consts;

#[Controller(prefix: '/docs')]
class DocumentsController extends BaseController
{
    const API_URL = '';
    const APP_ID = 100000; // 默认app_id
    const APP_KEY = 'Loq8nQWtDItGUsjgif7eEAtSP52ZzFYA'; // 默认app_key
    const ALLOW_IP = [
        '127.0.0.1',
        '61.9.110.68',
    ];

    #[RequestMapping(methods: 'GET, POST', path: 'index')]
    public function index(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/main');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'intro')]
    public function intro(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/intro');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'api_intro')]
    public function apiIntroduce(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/api_intro');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'error_codes')]
    public function errorCodes(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/error_codes');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'sign')]
    public function sign(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/sign');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'send_message')]
    public function recharge(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v1/send_message',
        ], self::getViewData($request)), 'docs/send_message');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'send_verify')]
    public function withdraw(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v1/send_verify',
        ], self::getViewData($request)), 'docs/send_verify');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'message_query')]
    public function messageQuery(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v1/message_query',
        ], self::getViewData($request)), 'docs/message_query');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'info')]
    public function fee(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v1/info',
        ], self::getViewData($request)), 'docs/info');
    }

    #[RequestMapping(methods: 'GET, POST', path: 'balance')]
    public function balance(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v1/balance',
        ], self::getViewData($request)), 'docs/balance');
    }

    //  得到api域名
    private static function getAPIDomain(): string
    {
        if (config('env_mode') == 'local') {
            return '';
        }
        return self::API_URL;
    }

    // 得到默认数据
    private static function getViewData(RequestInterface $request): array
    {
        $clientIP = Utils::clientIP($request);
        $remoteArr = [
            'app_id' => '348193',
            'app_key' => 'q2m7zCZYWc4IkVb1vaoiWzdYuGxhVL5g',
        ];
        if (in_array($clientIP, self::ALLOW_IP)) {
            if (config('env_mode') == 'local') {
                return [
                    'app_id' => self::APP_ID,
                    'app_key' => self::APP_KEY,
                ];
            }
            return $remoteArr;
        }

        return [
            'app_id' => '',
            'app_key' => '',
        ];
    }
}
