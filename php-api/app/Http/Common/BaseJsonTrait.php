<?php

declare(strict_types=1);

namespace App\Http\Common;

trait BaseJsonTrait
{

    /**
     * return json success
     * @return array
     */
    protected static function jsonOk(string $message = ""): array
    {
        return [
            'code' => 0,
            'message' => $message,
        ];
    }

    /**
     * @param string $message
     * @param int $code
     * @return array
     */
    protected static function jsonErr(string $message = '程序运行出现错误', int $code = 500): array
    {
        return [
            'code' => $code,
            'message' => $message,
        ];
    }

    /**
     * 默认返回带结果信息
     * @param array $data
     * @param string|object $message
     * @return array
     */
    protected static function jsonResult(array|object $data, string $message = ''): array
    {
        return [
            'code' => 0,
            'message' => $message,
            'data' => (is_array($data) ? (object) $data : $data),
        ];
    }
}
