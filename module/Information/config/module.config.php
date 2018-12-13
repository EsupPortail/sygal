<?php

use Application\Entity\Db\Repository\DefaultEntityRepository;
use Information\Controller\IndexController;
use Information\Controller\IndexControllerFactory;
use Information\Controller\InformationController;
use Information\Controller\InformationControllerFactory;
use Information\Form\InformationForm;
use Information\Form\InformationFormFactory;
use Information\Form\InformationHydrator;
use Information\Service\InformationService;
use Information\Service\InformationServiceFactory;
use Zend\Mvc\Router\Http\Literal;
use Zend\Mvc\Router\Http\Segment;
use Zend\Navigation\Service\NavigationAbstractServiceFactory;
use Doctrine\Common\Persistence\Mapping\Driver\MappingDriverChain;
use Doctrine\DBAL\Driver\OCI8\Driver as OCI8;
use Doctrine\ORM\Mapping\Driver\XmlDriver;

return [
    'doctrine'     => [
        /**
         * Génération du mapping à partir de la bdd, exemple :
         *   $ vendor/bin/doctrine-module orm:convert-mapping --namespace="Application\\Entity\\Db\\" --filter="Version" --from-database xml module/Application/src/Application/Entity/Db/Mapping
         *
         * Génération des classes d'entité, exemple :
         *   $ vendor/bin/doctrine-module orm:generate:entities --filter="Version" module/Application/src
         */
        'driver'     => [
            'orm_default'        => [
                'class'   => MappingDriverChain::class,
                'drivers' => [
                    'Information\Entity\Db' => 'orm_default_xml_driver',
                    'Information\Entity\Db\VSitu' => 'orm_default_xml_driver',
                ],
            ],
            'orm_default_xml_driver' => [
                'class' => XmlDriver::class,
                'cache' => 'array',
                'paths' => [
                    __DIR__ . '/../src/Information/Entity/Db/Mapping',
                ],
            ],
        ],
        'eventmanager'  => [
            'orm_default' => [
                'subscribers' => [
                    'UnicaenApp\HistoriqueListener',
                ],
            ],
        ],
        'connection'    => [
            'orm_default' => [
                'driver_class' => OCI8::class,
            ],
        ],
        'configuration' => [
            'orm_default' => [
                'default_repository_class_name' => DefaultEntityRepository::class,
            ]
        ],
        'cache' => [
            'memcached' => [
                'namespace' => 'Sygal_Doctrine',
                'instance'  => 'Sygal\Memcached',
            ],
        ],
    ],

    'bjyauthorize'    => [
        'guards' => [
            \UnicaenAuth\Guard\PrivilegeController::class => [
                [
                    'controller' => IndexController::class,
                    'roles' => [],
                ],
                [
                    'controller' => InformationController::class,
                    'action'     => [
                        'index',
                    ],
                ],
                [
                    'controller' => InformationController::class,
                    'action'     => [
                        'ajouter',
                        'supprimer',
                    ],
                ],
                [
                    'controller' => InformationController::class,
                    'action'     => [
                        'modifier',
                    ],
                ],
                [
                    'controller' => InformationController::class,
                    'action'     => [
                        'afficher',
                    ],
                    'roles' => [],
                ],
            ],
        ],
    ],
    'router' => [
        'routes' => [
            'information' => [
                'type'    => 'Literal',
                'options' => [
                    'route'    => '/information',
                    'defaults' => [
                        'controller' => IndexController::class,
                    ],
                ],
                'may_terminate' => true,
                'child_routes' => [
                    'doctorat' => [
                        'type'    => 'Literal',
                        'options' => [
                            'route'    => '/doctorat',
                            'defaults' => [
                                'action' => 'doctorat',
                            ],
                        ],
                    ],
                    'ecoles-doctorales' => [
                        'type'    => 'Literal',
                        'options' => [
                            'route'    => '/ecoles-doctorales',
                            'defaults' => [
                                'action' => 'ecoles-doctorales',
                            ],
                        ],
                    ],
                    'guide-these' => [
                        'type'    => 'Literal',
                        'options' => [
                            'route'    => '/guide-these',
                            'defaults' => [
                                'action' => 'guide-these',
                            ],
                        ],
                    ],
                ],
            ],
            'informations' => [
                'type'          => Literal::class,
                'options'       => [
                    'route'    => '/informations',
                    'defaults' => [
                        'controller'    => InformationController::class,
                        'action'        => 'index',
                    ],
                ],
                'may_terminate' => true,
                'child_routes'  => [
                    'afficher' => [
                        'type'          => Segment::class,
                        'options'       => [
                            'route'       => '/afficher/:id',
                            'defaults'    => [
                                'action' => 'afficher',
                            ],
                        ],
                    ],
                    'ajouter' => [
                        'type'          => Literal::class,
                        'options'       => [
                            'route'       => '/ajouter',
                            'defaults'    => [
                                'action' => 'ajouter',
                            ],
                        ],
                    ],
                    'supprimer' => [
                        'type'          => Segment::class,
                        'options'       => [
                            'route'       => '/supprimer/:id',
                            'defaults'    => [
                                'action' => 'supprimer',
                            ],
                        ],
                    ],
                    'modifier' => [
                        'type'          => Segment::class,
                        'options'       => [
                            'route'       => '/modifier/:id',
                            'defaults'    => [
                                'action' => 'modifier',
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ],
    'navigation'      => [
        'information' => [
            'accueil' => [
                'label' => 'Accueil',
                'route' => 'home',
                'pages' => [
                    'doctorat' => [
                        'label' => 'Le doctorat',
                        'route' => 'information/doctorat',
                        'title' => "Informations sur le doctorat et sa gestion"
                    ],
                    'ecoles-doctorales' => [
                        'label' => 'Les Ecoles Doctorales',
                        'route' => 'information/ecoles-doctorales',
                        'title' => "Informations sur les Ecoles Doctorales et le Collège des Ecoles doctorales"
                    ],
                    'guide-these' => [
                        'label' => 'Guide de la thèse',
                        'route' => 'information/guide-these',
                        'title' => "Informations sur le déroulement de la thèse et formulaires administratifs à l’intention du doctorant et de ses encadrants"
                    ],
                ],
            ],
        ],
    ],
    'service_manager' => [
        'abstract_factories' => [
            NavigationAbstractServiceFactory::class,
        ],
        'factories' => [
            InformationService::class => InformationServiceFactory::class,
        ],
    ],

    'controllers' => [
        'factories' => [
            IndexController::class => IndexControllerFactory::class,
            InformationController::class => InformationControllerFactory::class,
        ],
    ],
    'form_elements'   => [
        'factories' => [
            InformationForm::class => InformationFormFactory::class,
        ],
    ],
    'hydrators' => [
        'invokables' => [
            InformationHydrator::class => InformationHydrator::class
        ]
    ],
    'view_manager' => [
        'template_path_stack' => [
            __DIR__ . '/../view',
        ],
    ],
    'public_files' => [
        'inline_scripts'        => [
            '100_' => 'js/tinymce/js/tinymce/tinymce.js',
            '101_' => 'js/form_fiche.js',
        ],
    ]
];