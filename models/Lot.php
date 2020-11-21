<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "lots".
 *
 * @property int $id
 * @property float $amount
 * @property float $purchaseValue
 * @property string $expiration
 * @property string $unity
 *
 * @property Item[] $items
 */
class Lot extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'lots';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['amount', 'purchaseValue', 'expiration', 'unity'], 'required'],
            [['amount', 'purchaseValue'], 'number'],
            [['expiration'], 'safe'],
            [['unity'], 'string', 'max' => 5],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'amount' => 'Amount',
            'purchaseValue' => 'Purchase Value',
            'expiration' => 'Expiration',
            'unity' => 'Unity',
        ];
    }

    /**
     * Gets query for [[Items]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getItems()
    {
        return $this->hasMany(Item::className(), ['lots_id' => 'id']);
    }
}
