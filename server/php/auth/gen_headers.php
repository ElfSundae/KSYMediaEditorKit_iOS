<?php
require('./vendor/autoload.php');
use Ksyun\Service\Ksvs;
include_once "setting.php";


$params = [
	'query' => [
		'Pkg' => $pkg,
	],
    'v4_credentials' => ['ak' => $ak, 'sk' => $sk],
];

$ins = Ksvs::getInstance();
$response = $ins->request('KSDKAuth', $params);


$container = $ins->container;

var_dump($container[0]['request']->getHeaders());

