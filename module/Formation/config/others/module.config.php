<?php

namespace Formation;

use Formation\Controller\ModuleController;
use Formation\Controller\ModuleControllerFactory;
use Formation\Form\Module\ModuleForm;
use Formation\Form\Module\ModuleFormFactory;
use Formation\Form\Module\ModuleHydrator;
use Formation\Form\Module\ModuleHydratorFactory;
use Formation\Provider\Privilege\IndexPrivileges;
use Formation\Service\Module\ModuleService;
use Formation\Service\Module\ModuleServiceFactory;
use UnicaenAuth\Guard\PrivilegeController;
use Zend\Router\Http\Literal;
use Zend\Router\Http\Segment;

return [
    'bjyauthorize' => [
        'guards' => [
            PrivilegeController::class => [
                [
                    'controller' => ModuleController::class,
                    'action' => [
                        'index',
                        'afficher',
                        'ajouter',
                        'modifier',
                        'historiser',
                        'restaurer',
                        'supprimer',
                    ],
                    'privileges' => [
                        IndexPrivileges::INDEX_AFFICHER,
                    ],
                ],
            ],
        ],
    ],

    'navigation' => [
        'default' => [
            'home' => [
                'pages' => [
                    'formation' => [
                        'pages' => [
                            'module' => [
                                'label'    => 'Modules',
                                'route'    => 'formation/module',
                                'resource' => PrivilegeController::getResourceId(ModuleController::class, 'index') ,
                                'order'    => 100,
                                'pages' => [
                                    'afficher' => [
                                        'label'    => "Affichage d'un module",
                                        'route'    => 'formation/module/afficher',
                                        'resource' => PrivilegeController::getResourceId(ModuleController::class, 'afficher') ,
                                        'order'    => 100,
                                        'visible' => false,
                                    ],
                                ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ],

    'router'          => [
        'routes' => [
            'formation' => [
                'child_routes' => [
                    'module' => [
                        'type'  => Literal::class,
                        'may_terminate' => true,
                        'options' => [
                            'route'    => '/module',
                            'defaults' => [
                                'controller' => ModuleController::class,
                                'action'     => 'index',
                            ],
                        ],
                        'child_routes' => [
                            'afficher' => [
                                'type'  => Segment::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/afficher/:module',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'afficher',
                                    ],
                                ],
                            ],
                            'ajouter' => [
                                'type'  => Literal::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/ajouter',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'ajouter',
                                    ],
                                ],
                            ],
                            'modifier' => [
                                'type'  => Segment::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/modifier/:module',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'modifier',
                                    ],
                                ],
                            ],
                            'historiser' => [
                                'type'  => Segment::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/historiser/:module',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'historiser',
                                    ],
                                ],
                            ],
                            'restaurer' => [
                                'type'  => Segment::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/restaurer/:module',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'restaurer',
                                    ],
                                ],
                            ],
                            'supprimer' => [
                                'type'  => Segment::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/supprimer/:module',
                                    'defaults' => [
                                        'controller' => ModuleController::class,
                                        'action'     => 'supprimer',
                                    ],
                                ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ],

    'service_manager' => [
        'factories' => [
            ModuleService::class => ModuleServiceFactory::class,
        ],
    ],
    'controllers'     => [
        'factories' => [
            ModuleController::class => ModuleControllerFactory::class,
        ],
    ],
    'form_elements' => [
        'factories' => [
            ModuleForm::class => ModuleFormFactory::class,
        ],
    ],
    'hydrators' => [
        'factories' => [
            ModuleHydrator::class => ModuleHydratorFactory::class,
        ],
    ]

];