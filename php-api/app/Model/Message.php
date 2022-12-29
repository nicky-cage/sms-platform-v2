<?php

declare(strict_types=1);

namespace App\Model;

use App\Common\{Cache};
use Hyperf\Utils\Str;
use App\Common\{HttpClient, Utils};
use Hyperf\DbConnection\Db;

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
 * @property int $notify_confirmed
 * @property int $created
 * @property int $send_time
 * @property int $failure
 * @property int $sent_time
 * @property string $remark
 * @property string $sender_number
 */
class Message extends Model
{
    const QueueKey = 'message_list';
    const CREATED_AT = 'created';
    const UPDATED_AT = null;
    protected ?string $table = 'messages';
    protected ?string $dateFormat = 'U';

    // 写入缓存 - 短信发送队列
    public static function pushForSend(array $data)
    {
        $cacheKey = self::QueueKey . ':sends';
        $value = json_encode($data);
        $cache = Cache::get();
        $cache->lPush($cacheKey, $value);
    }

    // 回调错误处理
    public function notifyErr(string $remark)
    {
        Db::table('messages')->where(['id' => $this->id])->update([
            'notify_failure' => $this->notify_failure + 1,
            'remark' => $remark,
        ]);
    }

    // 向客户端发送异步通知
    public function notify()
    {
        if ($this->state != 1) {
            echo "只下发成功记录\n";
            return;
        }

        $notifyURL = $this->notify_url;
        if (!Str::startsWith($notifyURL, 'https://') || Str::startsWith($notifyURL, 'http://')) {
            $this->notifyErr("通知地址无效: ${notifyURL}");
            echo "[订单]通知地址无效: ", $notifyURL, "\n";
            return;
        }

        $app = Db::table('merchant_apps')->where(['id' => $this->app_id])->first();
        if (!$app) {
            $this->notifyErr('缺少应用信息:' . $this->app_id);
            echo "[订单]缺少应用信息 \n";
            return;
        }

        $data = [
            'order_number' => $this->order_number,
            'message_id' => $this->message_id,
            'app_id' => $this->app_id,
            'phone_prefix' => $this->phone_prefix,
            'phone' => $this->phone,
            'phone_full' => $this->phone_full,
            'template_id' => $this->template_id,
            'status' => 1,
            'send_time' => $this->send_time / (1000 * 1000),
            'sent_time' => $this->sent_time / (1000 * 1000),
        ];
        $signStr = Utils::getSign($data, $app->app_key);
        $data['sign'] = $signStr;

        echo "[订单]商户异步回调地址: ", $notifyURL, "\n";
        print_r(['[订单]回调' => $data]);

        $client = HttpClient::getClient();
        $content = $client->post($notifyURL, $data);
        if (!$content) {
            $this->notifyErr('商户返回内容为null');
            echo "[订单]商户返回数据错误: null \n";
            return;
        }

        echo "[订单]商户返回数据: $content \n";
        if (trim($content) == "SUCCESS") {
            Db::table('messages')->where(['id' => $this->id])->update([
                'notify_confirmed' => time(),
                'remark' => '发送通知成功',
            ]);
        } else {
            $this->notifyErr("商户返回内容有误: ${content}");
        }
    }
}
