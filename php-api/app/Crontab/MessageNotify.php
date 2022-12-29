<?php

declare(strict_types=1);

namespace App\Crontab;

use App\Model\Message;
use Hyperf\Crontab\Annotation\Crontab;
use Hyperf\DbConnection\Db;

#[Crontab(rule: "*\/2 * * * * *", name: "MessageNotify", callback: "execute", memo: "短信异步通知", enable: true)]
class MessageNotify
{
    public function execute()
    {
        $cond = [
            ['state', '=', 1],
            ['notify_confirmed', '=', 0],
            ['notify_failure', '<', 10],
            ['created', '>', time() - 86400 * 3],
        ];
        $rows = Message::query()->where($cond)->orderBy('id', 'desc')->limit(500)->get();
        foreach ($rows as $row) {
            $row->notify();
        }
    }
}
