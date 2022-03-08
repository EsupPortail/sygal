<?php

return [
    'modules' => [
        'Laminas\Cache',
        'Laminas\Filter',
        'Laminas\Form',
        'Laminas\Hydrator',
        'Laminas\I18n',
        'Laminas\InputFilter',
        'Laminas\Log',
        'Laminas\Mail',
        'Laminas\Mvc\Console',
        'Laminas\Mvc\I18n',
        'Laminas\Mvc\Plugin\FilePrg',
        'Laminas\Mvc\Plugin\FlashMessenger',
        'Laminas\Mvc\Plugin\Identity',
        'Laminas\Mvc\Plugin\Prg',
        'Laminas\Navigation',
        'Laminas\Paginator',
        'Laminas\Router',
        'Laminas\Session',
        'Laminas\Validator',

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
        'UnicaenLivelog',
        'Import',
        'Indicateur',
        'Retraitement',
        'Soutenance',
        'Formation',
        'Notification',
        'Information',
        'Doctorant',
        //'StepStar',
        'Application',
    ],
    'module_listener_options' => [
        'config_glob_paths'    => [
            'config/autoload/{,*.}{global,local}.php',
        ],
        'module_paths' => [
            __DIR__ . '/../module',
            __DIR__ . '/../vendor',
        ],
        'config_cache_key' => 'application.config.cache',
        'config_cache_enabled' => true,
        'module_map_cache_key' => 'application.module.cache',
        'module_map_cache_enabled' => true,
        'cache_dir' => 'data/cache/',
    ],
];
