<?php

declare(strict_types=1);

namespace App\Model;

/**
 * @property int $id
 * @property int $merchant_id
 * @property int $country_id
 * @property int $channel_id
 * @property float $rate
 * @property int $created
 * @property int $updated
 */
class MerchantCountryRate extends Model
{
    const CREATED_AT = 'created';
    const UPDATED_AT = 'updated';
    protected ?string $table = 'merchant_country_rates';
    //public bool $timestamps = false;
    protected ?string $dateFormat = 'U';
}
