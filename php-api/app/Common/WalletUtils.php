<?php

declare(strict_types=1);

namespace App\Common;

use App\Common\Wallets\WithdrawRequest;
use App\Model\WalletAccount;
use Hyperf\DbConnection\Db;

class WalletUtils
{
    const ENV_TEST = 'http://54.166.47.123:8088';
    const ENV_PROD = 'http://54.166.47.123:9088';
    const IS_TEST = true;

    public static function getDomain(bool $isTest = true): string
    {
        if (!$isTest) {  // 如果不是测试, 直接返回
            return self::ENV_PROD;
        }
        return self::IS_TEST ? self::ENV_TEST : self::ENV_PROD;
    }

    public static function withdraw(WithdrawRequest $query, bool $isTest = true): ?object
    {
        $url = self::getDomain($isTest) . '/private/withdraw';
        $params = [
            'wallet_receiver' => $query->wallet_receiver,
            'wallet_sender' => $query->wallet_sender,
            'amount' => $query->amount,
            'time' => $query->time,
            'coin_type' => $query->coin_type,
        ];

        print_r($params);
        $client = HttpClient::getClient();
        $content = $client->post($url, $params);

        print_r(['content' => $content]);

        if (!$content) {
            return null;
        }

        return json_decode($content);
    }

    // 刷新钱包余额
    public static function refreshAvailable(string $walletAddress, int $coinType, float &$outerAmount, bool $isTest = true): bool { 
        $where = [
            'wallet_address' => $walletAddress,
            'coin_type' => $coinType,
        ];

        $result = false;
        Db::transaction(function() use ($where, &$result, $walletAddress, &$outerAmount, $isTest) { 
            $walletAccount = WalletAccount::query()->where($where)->lockForUpdate()->first();
            if (!$walletAccount) {
                return;
            }

            $url = sprintf('%s/private/account_balance?address=%s&coin_type=%d', self::getDomain($isTest), $walletAddress, $walletAccount->coin_type);
            $content = @file_get_contents($url);
            echo "refresh - available = ", $content, "\n";
            if (!$content) {
                return;
            }
            $result = json_decode(trim($content));

            if (!isset($result->data)) {
                return;
            }

            $amount = $result->data->amount ?? '0.000000';
            $realAmount = floatval($amount);
            if ($amount == $walletAccount->balance && $walletAccount->available == $realAmount) { // 如果和现在的余额相等
                $outerAmount = $realAmount;
                $result = true;
                return;
            }

            $walletAccount->balance = $amount;
            $walletAccount->available = $realAmount; // 可用金额
            $walletAccount->total = $realAmount + $walletAccount->frozen; // 总的可用金额
            $walletAccount->updated = time();
            if ($walletAccount->save()) {
                $outerAmount = $realAmount;
                $result = true;
            }
        });

        return $result;
    }
}
