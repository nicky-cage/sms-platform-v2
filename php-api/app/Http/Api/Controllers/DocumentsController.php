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

    #[RequestMapping(path: 'index', methods: 'GET, POST')]
    public function index(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/main');
    }

    #[RequestMapping(path: 'intro', methods: 'GET, POST')]
    public function intro(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/intro');
    }

    #[RequestMapping(path: 'api_intro', methods: 'GET, POST')]
    public function apiIntroduce(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/api_intro');
    }

    #[RequestMapping(path: 'error_codes', methods: 'GET, POST')]
    public function errorCodes(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/error_codes');
    }

    #[RequestMapping(path: 'sign', methods: 'GET, POST')]
    public function sign(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, [], 'docs/sign');
    }

    #[RequestMapping(path: 'send_message', methods: 'GET, POST')]
    public function recharge(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v2/send_message',
        ], self::getViewData($request)), 'docs/send_message');
    }

    #[RequestMapping(path: 'send_verify', methods: 'GET, POST')]
    public function withdraw(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v2/send_verify',
        ], self::getViewData($request)), 'docs/send_verify');
    }

    #[RequestMapping(path: 'message_query', methods: 'GET, POST')]
    public function messageQuery(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v2/message_query',
        ], self::getViewData($request)), 'docs/query');
    }

    #[RequestMapping(path: 'info', methods: 'GET, POST')]
    public function fee(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v2/info',
        ], self::getViewData($request)), 'docs/info');
    }

    #[RequestMapping(path: 'balance', methods: 'GET, POST')]
    public function balance(RequestInterface $request, RenderInterface $render): ResponseInterface
    {
        return self::render($request, $render, array_merge([
            'url' => self::getAPIDomain() . '/v2/balance',
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
            'app_id' => '100002',
            'app_key' => 'AHPLVWM78CTYW3EZMTRTLGDP3FFR2MOK',
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
