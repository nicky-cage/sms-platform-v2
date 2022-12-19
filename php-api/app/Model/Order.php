<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\Utils\Str;
use Hyperf\DbConnection\Db;
use App\Common\{HttpClient, Utils};


/**
 * @property int $id
 * @property int $merchant_id
 * @property string $merchant_name
 * @property string $order_number
 * @property float $amount
 * @property float $amount_paid
 * @property int $state
 * @property float $cost_ms
 * @property int $terminal_type
 * @property string $ip
 * @property string $area
 * @property string $trade_number
 * @property string $remark
 * @property int $created
 * @property int $updated
 * @property int $finished
 * @property int $app_id
 * @property int $coin_type
 * @property int $chain_index
 * @property int $app_id
 * @property int $upstream_confirmed
 * @property int $downstream_confirmed
 * @property int $downstream_notified
 * @property int $downstream_notify_count
 * @property string $return_url
 * @property string $pay_data
 * @property string $submit_data
 * @property string platform_rate
 * @property string rate
 * @property int parent_id
 * @property string parent_rate
 * @property string path
 * @property string $notify_url
 */
class Order extends Model
{

    const STATUS_PENDING = 0;   // 待支付
    const STATUS_FINISHED = 1;  // 已完成
    const STATUS_FAILURE = 2;  // 失败
    const STATUS_CANCELED = 3;   // 已删除
    const STATUS_DENY = 4;     // 交易关闭
    const STATUS_OTHER = 9;     // 交易关闭

    const CREATED_AT = 'created';
    const UPDATED_AT = 'updated';

    /**
     * 订单状态
     */
    const STATUS_TYPES = [
        0 => '待支付',  //
        1 => '已完成',  // 成功
        2 => '失败',    //
        3 => '已取消',  //
        4 => '已拒绝',    //
        9 => '其他状态', //
    ];
    protected ?string $table = 'orders';
    protected ?string $dateFormat = 'U';

    // 是否成功
    public function isFinished(): bool
    {
        return $this->state == self::STATUS_FINISHED;
    }

    // 回调错误处理
    public function notifyErr(string $remark) { 
        Db::table('orders')->where(['id' => $this->id])->update([
            'downstream_notified' => time(),
            'downstream_notify_count' => $this->downstream_notify_count + 1,
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
            $this->notifyErr('缺少应用信息:'. $this->app_id);
            echo "[订单]缺少应用信息 \n";
            return;
        }

        $data = [
            'trade_number' => $this->order_number,
            'tx' => $this->tx,
            'amount' => $this->amount,
            'address_from' => $this->address_from,
            'address_to' => $this->address_to,
            'coin_type' => $this->coin_type,
            'status' => 1,
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
            Db::table('orders')->where(['id' => $this->id])->update([
                'downstream_confirmed' => time(),
                'amount_paid' => $this->amount,
                'downstream_notify_count' => $this->downstream_notify_count + 1,
            ]);
        } else {
            $this->notifyErr("商户返回内容有误: ${content}");
        }
    }
}
