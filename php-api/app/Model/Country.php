<?php

declare(strict_types=1);

namespace App\Model;

/**
 * @property int $id
 * @property string $name
 * @property string $name_english
 * @property string $code
 * @property string $phone_prefix
 * @property float $timezone_offset
 * @property string $remark
 * @property int $is_support
 */
class Country extends Model
{
    const CREATED_AT = null;
    const UPDATED_AT = null;
    protected ?string $table = 'countries';
    //public bool $timestamps = false;
    protected ?string $dateFormat = 'U';
}
