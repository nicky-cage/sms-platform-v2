<?php

declare(strict_types=1);

namespace App\Common;

use Hyperf\Utils\ApplicationContext;
use Hyperf\Redis\Redis;
use App\Model\Model;
use Hyperf\Utils\Coroutine;

class Cache
{
    /**
     * @var ?Redis
     */
    private static ?Redis $cache = null;

    /**
     * 返回redis客户端, 为了方便使用编辑器的代码提示,不再继续简化
     * @return Redis
     */
    public static function get(): Redis
    {
        if (!self::$cache) {
            $container = ApplicationContext::getContainer();
            self::$cache = $container->get(Redis::class);
        }
        return self::$cache;
    }

    /**
     * 得到类缓存
     * @param string $modelName
     * @param int $id
     * @param int $timeout
     * @return Model|NULL
     */
    public static function getModelById(string $modelName, int $id, int $timeout = 86400): Model
    {
        $key = last(explode('\\', $modelName)) . '_' . $id;
        $cache = self::get();
        $value = $cache->get($key);
        $now = time();
        if ($value) {
            $row = unserialize($value);
            if ($row->cached_time_by_redis > $now - $timeout) {
                return $row;
            }
        }

        $record = $modelName
            ::query()
            ->where('id', $id)
            ->select();
        $row = $record->toArray();
        $row->cached_time_by_redis = $now;
        $cache->set($key, serialize($row));
        return $row;
    }

    // 锁定
    public static function lock(string $key)
    {
        $redis = self::get();
        $redis->incr('lock:' . $key);
    }

    // 锁定
    public static function lockBy(string $key, int $timeout = 3)
    {
        $redis = self::get();
        $cacheKey = 'lock:' . $key;
        $redis->set($cacheKey, '1');
        Coroutine::create(function () use ($redis, $cacheKey, $timeout) {
            Coroutine::sleep($timeout);
            $redis->del($cacheKey);
        });
        // $redis->expire($cacheKey, $timeout);
    }

    // 翻译锁
    public static function lockRelease(string $key)
    {
        $redis = self::get();
        $redis->del('lock:' . $key);
    }

    // 是否已经锁住
    public static function locked(string $key): bool
    {
        $redis = self::get();
        return $redis->get('lock:' . $key) >= 1;
    }
}
