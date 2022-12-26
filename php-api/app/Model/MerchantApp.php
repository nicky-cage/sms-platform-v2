<?php

declare(strict_types=1);

namespace App\Model;

use Hyperf\Utils\Str;

/**
 * @property int $id
 * @property int $merchant_id
 * @property string $merchant_name
 * @property string $name
 * @property string $app_key
 * @property int $state
 * @property stirng $allow_ip
 * @property int $pay_in
 * @property int $pay_out
 * @property string $remark
 * @property int $created
 * @property int $updated
 */
class MerchantApp extends Model
{
    const CREATED_AT = 'created';
    const UPDATED_AT = 'updated';
    protected ?string $table = 'merchant_apps';
    //public bool $timestamps = false;
    protected ?string $dateFormat = 'U';

    /**
     * @param array $data
     * @return bool
     */
    public static function beforeCreate(array &$data): bool
    {
        $data['app_key'] = strtoupper(Str::random(32));
        return parent::beforeCreate($data);
    }
    /**
     * @return array
     */
    public static function getRelatedAll(): array
    {
        $result = [];
        $rows = self::all();
        foreach ($rows as $r) {
            $result[$r->id] = $r->name;
        }
        return $result;
    }
}
