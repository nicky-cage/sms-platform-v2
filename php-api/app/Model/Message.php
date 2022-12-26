<?php

declare(strict_types=1);

namespace App\Model;

use App\Common\{Cache};

/**
 * @property int $id
 * @property string $order_number
 * @property int $merchant_id
 * @property string $merchant_name
 * @property int $app_id
 * @property string $app_name
 * @property int $country_id
 * @property int $channel_id
 * @property string $phone_prefix
 * @property string $phone
 * @property string $phone_full
 * @property int $template_id
 * @property int $state
 * @property stirng $content
 * @property string $request_uri
 * @property string $request_result
 * @property string $message_id
 * @property string $notify_url
 * @property int $notify_failure
 * @property int $created
 * @property int $send_time
 * @property int $failure
 * @property int $sent_time
 * @property string $remark
 */
class Message extends Model
{

    const QueueKey = 'message_list';
    const CREATED_AT = 'created';
    const UPDATED_AT = null;
    protected ?string $table = 'messages';
    //public bool $timestamps = false;
    protected ?string $dateFormat = 'U';

    // 写入缓存 - 短信发送队列
    public static function pushForSend(array $data) {
        $cacheKey = self::QueueKey. ':sends';
        $value = json_encode($data);
        $cache = Cache::get();
        $cache->lPush($cacheKey, $value);
    }
}
