<?php

declare(strict_types=1);

namespace App\Http\Api\Controllers;

use Hyperf\Di\Annotation\Inject;
use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Contract\ResponseInterface;
use Psr\Container\ContainerInterface;
use App\Http\Common\FrontendController;
use App\Http\Common\BaseJsonTrait;
use App\Http\Common\BaseCommonTrait;

abstract class BaseController extends FrontendController
{
    /**
     * 应用名称
     * @var string
     */
    protected static string $appName = 'api';

    use BaseCommonTrait;
    use BaseJsonTrait;
}
