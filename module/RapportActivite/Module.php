<?php

namespace RapportActivite;

use Laminas\Config\Factory as ConfigFactory;
use Laminas\Mvc\ModuleRouteListener;
use Laminas\Mvc\MvcEvent;
use Laminas\Stdlib\Glob;
use RapportActivite\Event\Avis\RapportActiviteAvisEventListener;
use RapportActivite\Event\RapportActiviteEventListener;
use RapportActivite\Event\Validation\RapportActiviteValidationEventListener;

class Module
{
    /**
     * @throws \Psr\Container\ContainerExceptionInterface
     * @throws \Psr\Container\NotFoundExceptionInterface
     */
    public function onBootstrap(MvcEvent $e)
    {
        $eventManager = $e->getApplication()->getEventManager();
        $moduleRouteListener = new ModuleRouteListener();
        $moduleRouteListener->attach($eventManager);

        $container = $e->getApplication()->getServiceManager();

        /** @var \RapportActivite\Event\RapportActiviteEventListener $rapportActiviteListener */
        $rapportActiviteListener = $container->get(RapportActiviteEventListener::class);
        $rapportActiviteListener->attach($eventManager);

        /** @var \RapportActivite\Event\Avis\RapportActiviteAvisEventListener $rapportActiviteAvisListener */
        $rapportActiviteAvisListener = $container->get(RapportActiviteAvisEventListener::class);
        $rapportActiviteAvisListener->attach($eventManager);

        /** @var \RapportActivite\Event\Validation\RapportActiviteValidationEventListener $rapportActiviteValidationListener */
        $rapportActiviteValidationListener = $container->get(RapportActiviteValidationEventListener::class);
        $rapportActiviteValidationListener->attach($eventManager);
    }

    public function getConfig()
    {
        $paths = array_merge(
            [__DIR__ . '/config/module.config.php'],
            Glob::glob(__DIR__ . '/config/others/{,*.}{config}.php', Glob::GLOB_BRACE)
        );

        return ConfigFactory::fromFiles($paths);
    }

    public function getAutoloaderConfig(): array
    {
        return array(
            'Laminas\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,
                ),
            ),
        );
    }
}