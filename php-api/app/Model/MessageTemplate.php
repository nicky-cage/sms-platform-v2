<?php

declare(strict_types=1);

namespace App\Model;

/**
 * @property int $id
 * @property int $merchant_id
 * @property string $merchant_name
 * @property int $app_id
 * @property string $app_name
 * @property string $name
 * @property int $type
 * @property string $content
 * @property int $created
 * @property int $updated
 * @property string $remark
 */
class MessageTemplate extends Model
{
    const CREATED_AT = 'created';
    const UPDATED_AT = 'updated';
    protected ?string $table = 'message_templates';
    //public bool $timestamps = false;
    protected ?string $dateFormat = 'U';
}

