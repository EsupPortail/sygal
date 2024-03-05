<?php

namespace Admission\Service\Financement;

use Admission\Service\Verification\VerificationService;
use Application\Service\Role\RoleService;
use Application\Service\Source\SourceService;
use Application\Service\UserContextService;
use Application\SourceCodeStringHelper;
use Interop\Container\ContainerInterface;
use Psr\Container\ContainerExceptionInterface;
use Psr\Container\NotFoundExceptionInterface;

class FinancementServiceFactory {

    /**
     * @throws NotFoundExceptionInterface
     * @throws ContainerExceptionInterface
     */
    public function __invoke(ContainerInterface $container): FinancementService
    {
        $verificationService = $container->get(VerificationService::class);

        $service = new FinancementService();
        $service->setVerificationService($verificationService);
        return $service;
    }
}