<?php

declare(strict_types=1);

namespace App\Http\Middlewares;

use App\Model\{MerchantLogin, OperationMerchantLog};
use Exception;
use Hyperf\Contract\SessionInterface;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Contract\ResponseInterface as HttpResponse;
use Hyperf\Logger\LoggerFactory;
use Hyperf\Utils\Str;
use Ip2Region;
use Psr\Container\ContainerInterface;
use Psr\Http\Message\{ResponseInterface, ServerRequestInterface};
use Psr\Http\Server\MiddlewareInterface;
use Psr\Http\Server\RequestHandlerInterface;
use Psr\Log\LoggerInterface;

class CheckMerchantLogin implements MiddlewareInterface
{

    const URL_PREFIX = '/agent';

    // 要跳过的路由
    const SKIP_LOGIN_URLS = [
        '/operation_logs/list',
        '/index/index',
        '/index/login',
        '/index/code',
        '/index/error',
        '/index/logout',
    ];
    const SKIP_LOG_URLS = [
        '/operation_logs/list',
        '/index/index',
        '/index/code',
        '/index/error',
    ];

    /**
     * @var RequestInterface
     */
    protected RequestInterface $request;
    /**
     * @var HttpResponse
     */
    protected HttpResponse $response;
    /**
     * @var ContainerInterface
     */
    protected ContainerInterface $container;
    /**
     * @var LoggerInterface
     */
    protected LoggerInterface $logger;
    /**
     * @var Ip2Region
     */
    protected Ip2Region $ip2region;
    /**
     * @var SessionInterface
     */
    private SessionInterface $session;

    /**
     * @param ContainerInterface $container
     * @param HttpResponse $response
     * @param RequestInterface $request
     * @param LoggerFactory $loggerFactory
     * @param SessionInterface $session
     * @param Ip2Region $ip2region
     */
    public function __construct(
        ContainerInterface $container,
        HttpResponse       $response,
        RequestInterface   $request,
        LoggerFactory      $loggerFactory,
        SessionInterface   $session,
        Ip2Region          $ip2region
    ) {
        $this->logger = $loggerFactory->get('log', 'default');
        $this->container = $container;
        $this->response = $response;
        $this->request = $request;
        $this->session = $session;
        $this->ip2region = $ip2region;
    }

    /**
     * @param ServerRequestInterface $request
     * @param RequestHandlerInterface $handler
     * @return ResponseInterface
     * @throws Exception
     */
    public function process(ServerRequestInterface $request, RequestHandlerInterface $handler): ResponseInterface
    {
        // 检测不需要登录的url
        $path = $request->getUri()->getPath();
        if (!Str::startsWith($path, self::URL_PREFIX)) {
            return $handler->handle($request);
        }
        $requestPath = str_replace(self::URL_PREFIX, '', $path);
        if (in_array($requestPath, self::SKIP_LOGIN_URLS)) { // 如果在这些里面,则跳过
            return $handler->handle($request);
        }

        $login = MerchantLogin::get($this->session);
        if (!$login) {
            return $this->response->redirect('/index/error?message=商户尚未登录系统');
        }

        $requestPath = $request->getUri()->getPath();
        if (!in_array($requestPath, self::SKIP_LOG_URLS)) { // 如果不在跳过的范围之内
            $requestIP = $this->request->getServerParams()['remote_addr'] ?? ''; // 来源ip
            $data = [
                'query' => $request->getQueryParams(),
                'server' => $request->getServerParams(),
                'header' => $request->getHeaders(),
                'body' => $request->getBody(),
                'cookie' => $request->getCookieParams(),
                'attributes' => $request->getAttributes(),
            ];
            OperationMerchantLog::query()->insert([
                'merchant_id' => $login->id, // 管理员名称
                'merchant_name' => $login->name,
                'remark' => json_encode($data), // 参数
                'method' => $request->getMethod(), // 方法
                'url' => $requestPath, // url
                'operate_ip' => $requestIP, // 来源ip
                'operate_area' => $this->ip2region->binarySearch($requestIP)['region'] ?? '未知', // 区域
                'created' => time(), //
            ]);
        }
        return $handler->handle($request);
    }
}
