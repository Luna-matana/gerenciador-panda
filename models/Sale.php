<?php

namespace app\models;

use Yii;

/**
 * This is the model class for table "sales".
 *
 * @property int $id
 * @property int $paymentForm
 * @property string $description
 * @property float $value
 * @property int $request_id
 *
 * @property Request $request
 */
class Sale extends \yii\db\ActiveRecord
{
    /**
     * {@inheritdoc}
     */
    public static function tableName()
    {
        return 'sales';
    }

    /**
     * {@inheritdoc}
     */
    public function rules()
    {
        return [
            [['paymentForm', 'description', 'value', 'request_id'], 'required'],
            [['paymentForm', 'request_id'], 'integer'],
            [['value'], 'number'],
            [['description'], 'string', 'max' => 200],
            [['request_id'], 'exist', 'skipOnError' => true, 'targetClass' => Request::className(), 'targetAttribute' => ['request_id' => 'id']],
        ];
    }

    /**
     * {@inheritdoc}
     */
    public function attributeLabels()
    {
        return [
            'id' => 'ID',
            'paymentForm' => 'Payment Form',
            'description' => 'Description',
            'value' => 'Value',
            'request_id' => 'Request ID',
        ];
    }

    /**
     * Gets query for [[Request]].
     *
     * @return \yii\db\ActiveQuery
     */
    public function getRequest()
    {
        return $this->hasOne(Request::className(), ['id' => 'request_id']);
    }
}
