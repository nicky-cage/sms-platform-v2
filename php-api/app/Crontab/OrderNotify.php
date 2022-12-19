<?php

declare(strict_types=1);

namespace App\Crontab;

use App\Model\Order;
use Hyperf\Crontab\Annotation\Crontab;
use Hyperf\DbConnection\Db;

#[Crontab(rule: "*\/2 * * * * *", name: "OrderNotify", callback: "execute", memo: "订单异步通知", enable: true)]
class OrderNotify
{
    public function execute()
    {
        $cond = [
            ['state', '=', 1],
            ['downstream_confirmed', '=', 0],
            ['downstream_notify_count', '<', 10],
        ];
        $rows = Order::query()->where($cond)->get();
        foreach ($rows as $row) {
            $row->notify();
        }
    }
}
