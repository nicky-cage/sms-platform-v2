<?php

declare(strict_types=1);

namespace App\Model;

/**
 * @property int $id
 * @property int $merchant_id
 * @property string $merchant_name
 * @property string $remark
 * @property string $method
 * @property string $url
 * @property string $operate_ip
 * @property string $operate_area
 * @property int $created
 */
class OperationMerchantLog extends Model
{
    const CREATED_AT = 'created';
    protected ?string $table = 'operation_merchant_logs';
    protected ?string $dateFormat = 'U';
}
