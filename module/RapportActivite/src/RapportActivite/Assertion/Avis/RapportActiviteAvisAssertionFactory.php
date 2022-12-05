<?php

namespace RapportActivite\Assertion\Avis;

use Application\Assertion\AbstractAssertion;
use Psr\Container\ContainerInterface;
use RapportActivite\Service\Avis\RapportActiviteAvisService;
use RapportActivite\Service\RapportActiviteService;

class RapportActiviteAvisAssertionFactory
{
    /**
     * @throws \Psr\Container\ContainerExceptionInterface
     * @throws \Psr\Container\NotFoundExceptionInterface
     */
    public function __invoke(ContainerInterface $container): RapportActiviteAvisAssertion
    {
        $userContext = $container->get('UnicaenAuth\Service\UserContext');
        $rapportActiviteService = $container->get(RapportActiviteService::class);
        $rapportActiviteAvisService = $container->get(RapportActiviteAvisService::class);
        $messageCollector = $container->get('MessageCollector');

        /** @var  $assertion */
        $assertion = new RapportActiviteAvisAssertion();
        $assertion->setUserContextService($userContext);
        $assertion->setRapportActiviteService($rapportActiviteService);
        $assertion->setRapportActiviteAvisService($rapportActiviteAvisService);
        $assertion->setServiceMessageCollector($messageCollector);

        $this->injectCommons($assertion, $container);

        return $assertion;
    }

    /**
     * @throws \Psr\Container\NotFoundExceptionInterface
     * @throws \Psr\Container\ContainerExceptionInterface
     */
    protected function injectCommons(AbstractAssertion $assertion, ContainerInterface $container)
    {
        $authorizeService = $container->get('BjyAuthorize\Service\Authorize');
        $mvcEvent = $container->get('Application')->getMvcEvent();

        $assertion->setServiceAuthorize($authorizeService);
        $assertion->setMvcEvent($mvcEvent);
    }
}