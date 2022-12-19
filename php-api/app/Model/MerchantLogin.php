<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\Di\Annotation\Inject;
use Hyperf\Redis\Redis;
use Hyperf\Contract\SessionInterface;

/**
 * @property int $id
 * @property string $name
 * @property int $parent_agent_id
 * @property string $parent_agent_name
 * @property string $parent_path
 * @property int $state
 * @property string $allow_ip
 * @property int $login_count
 * @property int $last_login
 * @property string $last_ip
 * @property string $current_ip
 * @property string $mail
 * @property string $phone
 */
class MerchantLogin extends Model
{

    const KEY = 'merchantinfo';

    /**
     * @var string
     */
    public string $name;
    /**
     * @var int
     */
    public int $login_count;
    /**
     * @var int
     */
    public int $last_login;
    /**
     * @var string
     */
    public string $last_ip;
    /**
     * @var string
     */
    public string $current_ip;
    /**
     * @Inject
     * @var Redis
     */
    #[Inject]
    protected Redis $redis;
    /**
     * @var string
     */
    private static string $cacheKey = 'login:merchant:';
    /**
     * @param int $adminId
     * @return string
     */
    public static function getCacheKey(int $merchantId): string
    {
        return self::$cacheKey . ':' . $merchantId;
    }
    /**
     * 保存到缓存
     * @param array $data
     */
    public function store(array $data)
    {
        $savedData = (object) [
            'id' => $data['id'],
            'name' => $data['name'],
            'login_count' => $data['login_count'],
            'last_login' => $data['last_login'],
            'last_ip' => $data['last_ip'],
            'current_ip' => $data['current_ip']
        ];
        $cacheKey = self::getCacheKey($data['id']);
        $this->redis->set($cacheKey, json_encode($savedData));
    }

    public static function set(SessionInterface $session,  Merchant $row)
    {
        $data = $row->toArray();
        $session->set(self::KEY, $data);
    }

    public static function get(SessionInterface $session): ?Merchant
    {
        $data =  $session->get(self::KEY);
        if (!$data) {
            return null;
        }
        $object = new Merchant();
        foreach ($data as $k => $v) {
            $object->$k = $v;
        }

        return $object;
    }
}
