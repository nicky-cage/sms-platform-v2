<?php

declare(strict_types=1);

namespace App\Common\Wallets;

class WithdrawRequest
{
    public string $wallet_receiver;
    public string $wallet_sender;
    public float $amount;
    public int $time;
    public int $coin_type;
}
