<?php

declare(strict_types=1);

namespace App\Crontab;

use App\Model\Withdraw;
use Hyperf\Crontab\Annotation\Crontab;

#[Crontab(rule: "*\/2 * * * * *", name: "WithdrawNotify", callback: "execute", memo: "提现异步通知", enable: true)]
class WithdrawNotify
{
    public function execute()
    {
        $cond = [
            ['state', '=', 1],
            ['downstream_confirmed', '=', 0],
            ['downstream_notify_count', '<', 10],
        ];
        $rows = Withdraw::query()->where($cond)->get();
        foreach ($rows as $row) {
            $row->notify();
        }
    }
}
