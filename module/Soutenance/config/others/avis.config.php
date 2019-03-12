<?php

namespace Soutenance;

use Soutenance\Assertion\AvisSoutenanceAssertion;
use Soutenance\Assertion\AvisSoutenanceAssertionFactory;
use Soutenance\Controller\Avis\AvisController;
use Soutenance\Controller\Avis\AvisControllerFactory;
use Soutenance\Controller\SoutenanceController;
use Soutenance\Form\Avis\AvisForm;
use Soutenance\Form\Avis\AvisFormFactory;
use Soutenance\Form\Avis\AvisHydrator;
use Soutenance\Provider\Privilege\AvisSoutenancePrivileges;
use Soutenance\Service\Avis\AvisService;
use Soutenance\Service\Avis\AvisServiceFactory;
use UnicaenAuth\Guard\PrivilegeController;
use UnicaenAuth\Provider\Rule\PrivilegeRuleProvider;
use Zend\Mvc\Router\Http\Literal;
use Zend\Mvc\Router\Http\Segment;

return array(
    'bjyauthorize'    => [
        'resource_providers' => [
            'BjyAuthorize\Provider\Resource\Config' => [
                'Acteur' => [],
            ],
        ],
        'rule_providers'     => [
            PrivilegeRuleProvider::class => [
                'allow' => [
                    [
                        'privileges' => [
                            AvisSoutenancePrivileges::AVIS_VISUALISER,
                            AvisSoutenancePrivileges::AVIS_MODIFIER,
                            AvisSoutenancePrivileges::AVIS_ANNULER,
                        ],
                        'resources'  => ['Acteur'],
                        'assertion' => AvisSoutenanceAssertion::class,
                    ],
                ],
            ],
        ],
        'guards' => [
            PrivilegeController::class => [
                [
                    'controller' => AvisController::class,
                    'action'     => [
                        'index',
                        'afficher',
                    ],
                    'privileges' => AvisSoutenancePrivileges::AVIS_VISUALISER,
                ],
                [
                    'controller' => AvisController::class,
                    'action'     => [
                        'annuler',
                    ],
                    'privileges' => AvisSoutenancePrivileges::AVIS_ANNULER,
                ],
            ],
        ],
    ],

    'router' => [
        'routes' => [
            'soutenance' => [
                'type' => Segment::class,
                'may_terminate' => true,
                'options' => [
                    'route'    => '/soutenance[/:these]',
                    'defaults' => [
                        'controller' => SoutenanceController::class,
                        'action'     => 'index',
                    ],
                ],
                'child_routes' => [
                    'avis-soutenance' => [
                        'type' => Segment::class,
                        'may_terminate' => true,
                        'options' => [
                            'route'    => '/avis-soutenance/:rapporteur',
                            'defaults' => [
                                'controller' => AvisController::class,
                                'action'     => 'index',
                            ],
                        ],
                        'child_routes' => [
                            'afficher' => [
                                'type' => Literal::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/afficher',
                                    'defaults' => [
                                        'controller' => AvisController::class,
                                        'action'     => 'afficher',
                                    ],
                                ],
                            ],
                            'annuler' => [
                                'type' => Literal::class,
                                'may_terminate' => true,
                                'options' => [
                                    'route'    => '/annuler',
                                    'defaults' => [
                                        'controller' => AvisController::class,
                                        'action'     => 'annuler',
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
            //service
            AvisService::class => AvisServiceFactory::class,
            AvisSoutenanceAssertion::class => AvisSoutenanceAssertionFactory::class,

        ],
    ],
    'controllers' => [
        'factories' => [
            AvisController::class => AvisControllerFactory::class,
        ],
    ],

    'form_elements' => [
        'factories' => [
            AvisForm::class => AvisFormFactory::class,
        ],
    ],

    'hydrators' => [
        'invokables' => [
            AvisHydrator::class => AvisHydrator::class,
        ],
    ],
);