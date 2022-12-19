<?php

declare(strict_types=1);

namespace App\Constants;

use Hyperf\Constants\AbstractConstants;

class Consts extends AbstractConstants
{

    const PAYMENT_TYPES = [
        0 => '银行转账 (离线)',
        1 => '在线网银',
        2 => '支付宝支付',
        3 => '微信支付',
        4 => 'QQ 钱包',
        5 => '快捷支付',
        6 => '京东支付',
        7 => '银联扫码',
        8 => '虚拟货币',
        9 => '云闪付',
    ];

    /**
     * 货币类型
     */
    const COIN_TYPES = [
        10 => 'ETH',
        11 => 'ERC20-USDT',
        50 => 'TRX',
        51 => 'TRC20-USDT',
    ];

    /**
     * 币链类型
     */
    const CHAIN_TYPES = [
        60 => 'Ethereum',
        195 => 'Tron'
    ];

    // 提款手续费
    const COIN_FEES = [
        10 => 0.0008,
        11 => 3.2,
        50 => 1,
        51 => 0.8,
    ];
}
