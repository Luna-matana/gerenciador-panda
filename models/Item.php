<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "items".
 *
 * @property int $id
 * @property string $name
 * @property string $barCode
 * @property resource|null $image
 * @property float|null $value
 * @property int $lots_id
 *
 * @property ItemRequest[] $itemRequests
 * @property Request[] $requests
 * @property Lot $lots
 * @property Stock[] $stocks
 */
class Item extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'items';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['name', 'barCode', 'lots_id'], 'required'],
            [['image'], 'string'],
            [['value'], 'number'],
            [['lots_id'], 'integer'],
            [['name', 'barCode'], 'string', 'max' => 45],
            [['lots_id'], 'exist', 'skipOnError' => true, 'targetClass' => Lot::className(), 'targetAttribute' => ['lots_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'name' => 'Name',
            'barCode' => 'Bar Code',
            'image' => 'Image',
            'value' => 'Value',
            'lots_id' => 'Lots ID',
        ];
    }

    /**
     * Gets query for [[ItemRequests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getItemRequests()
    {
        return $this->hasMany(ItemRequest::className(), ['item_id' => 'id']);
    }

    /**
     * Gets query for [[Requests]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRequests()
    {
        return $this->hasMany(Request::className(), ['id' => 'request_id'])->viaTable('item_requests', ['item_id' => 'id']);
    }

    /**
     * Gets query for [[Lots]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getLots()
    {
        return $this->hasOne(Lot::className(), ['id' => 'lots_id']);
    }

    /**
     * Gets query for [[Stocks]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getStocks()
    {
        return $this->hasMany(Stock::className(), ['item_id' => 'id']);
    }
}
