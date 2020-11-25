<?php

namespace app\assets;
ini_set('display_errors',1);
ini_set('display_startup_erros',1);
error_reporting(E_ALL);
use yii\web\AssetBundle;

class PrincipalAsset extends AssetBundle
{
    public $basePath = '@webroot';
    public $baseUrl = '@web';

    public $css = [
        //'css/demo.css',
        'css/light-bootstrap-dashboard.css?v=2.0.0',
        //'css/bootstrap.min.css'
    ];
    public $js = [
        //'js/demo.js',
        'js/light-bootstrap-dashboard.js?v=2.0.0',
        'js/core/jquery.3.2.1.min.js',
        'js/core/popper.min.js',
        'js/core/bootstrap.min.js',
        'js/plugins/bootstrap-switch.js',
        'js/plugins/chartist.min.js',
    ];
    public $depends = [
        'yii\web\YiiAsset',
        'yii\bootstrap\BootstrapAsset',
    ];
}
