<?php

namespace Application\Service\Notification;

use Application\Service\Role\RoleService;
use Application\Service\Variable\VariableService;
use Individu\Service\IndividuService;
use Interop\Container\ContainerInterface;
use Laminas\View\Helper\Url as UrlHelper;
use Structure\Service\EcoleDoctorale\EcoleDoctoraleService;
use Structure\Service\UniteRecherche\UniteRechercheService;

/**
 * @author Unicaen
 */
class NotifierServiceFactory extends \Notification\Service\NotifierServiceFactory
{
    protected string $notifierServiceClass = NotifierService::class;

    /**
     * @throws \Psr\Container\ContainerExceptionInterface
     * @throws \Psr\Container\NotFoundExceptionInterface
     */
    public function __invoke(ContainerInterface $container): NotifierService
    {
        /** @var NotifierService $service */
        $service = parent::__invoke($container);

        /**
         * @var VariableService         $variableService
         * @var EcoleDoctoraleService   $ecoleDoctoraleService
         * @var UniteRechercheService   $uniteRechercheService
         * @var IndividuService         $individuService
         * @var RoleService             $roleService
         */
        $variableService = $container->get('VariableService');
        $ecoleDoctoraleService = $container->get('EcoleDoctoraleService');
        $uniteRechercheService = $container->get('UniteRechercheService');
        $individuService = $container->get(IndividuService::class);
        $roleService = $container->get('RoleService');

        /** @var UrlHelper $urlHelper */
        $urlHelper = $container->get('ViewHelperManager')->get('Url');

        $service->setVariableService($variableService);
        $service->setEcoleDoctoraleService($ecoleDoctoraleService);
        $service->setUniteRechercheService($uniteRechercheService);
        $service->setUrlHelper($urlHelper);
        $service->setIndividuService($individuService);
        $service->setRoleService($roleService);

        return $service;
    }
}
