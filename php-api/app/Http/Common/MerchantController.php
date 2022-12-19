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
use App\Model\{MerchantLogin, Merchant};

abstract class MerchantController extends BackendController
{
    /**
     * 应用名称
     * @var string
     */
    protected static string $appName = 'merchants';
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
     * @return object
     */
    protected function getMerchant(): ?Merchant
    {
        return MerchantLogin::get($this->session);
    }
}
