<?php

$modules = [
    'Zend\Cache',
    'Zend\Filter',
    'Zend\Form',
    'Zend\Hydrator',
    'Zend\I18n',
    'Zend\InputFilter',
    'Zend\Log',
    'Zend\Mail',
    'Zend\Mvc\Console',
    'Zend\Mvc\I18n',
    'Zend\Mvc\Plugin\FilePrg',
    'Zend\Mvc\Plugin\FlashMessenger',
    'Zend\Mvc\Plugin\Identity',
    'Zend\Mvc\Plugin\Prg',
    'Zend\Navigation',
    'Zend\Paginator',
    'Zend\Router',
    'Zend\Session',
    'Zend\Validator',

    'DoctrineModule',
    'DoctrineORMModule',
    'ZfcUser',
    'BjyAuthorize' => 'BjyAuthorize',
    'UnicaenApp',
    'UnicaenAuth',
    'UnicaenAuthToken',
    'UnicaenLdap',
    'UnicaenDbImport',
    'UnicaenFaq',
    'Import',
    'Indicateur',
    'Retraitement',
    'Soutenance',
    'Formation',
    'Notification',
    'Information',
    'Doctorant',
//    'StepStar',
    'Application',
];

$moduleListenerOptions = [
    'config_glob_paths'    => [
        'config/autoload/{,*.}{global,local}.php',
    ],
    'module_paths' => [
        __DIR__ . '/../module',
        __DIR__ . '/../vendor',
    ],
];

return [
    'modules' => $modules,
    'module_listener_options' => $moduleListenerOptions,
];
