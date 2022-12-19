<?php

declare(strict_types=1);

namespace App\Http\Api\Controllers;

use Hyperf\HttpServer\Contract\RequestInterface;
use Hyperf\HttpServer\Annotation\{Controller, GetMapping};

#[Controller(prefix: "/index")]
class IndexController extends BaseController
{
    #[GetMapping(path: "test")]
    public function test(RequestInterface $request): array
    {
        return self::jsonOk();
    }
}
