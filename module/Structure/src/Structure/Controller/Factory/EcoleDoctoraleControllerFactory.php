<?php

namespace Structure\Controller\Factory;

use Structure\Controller\EcoleDoctoraleController;
use Structure\Form\EcoleDoctoraleForm;
use Application\Service\CoEncadrant\CoEncadrantService;
use Structure\Service\EcoleDoctorale\EcoleDoctoraleService;
use Structure\Service\Etablissement\EtablissementServiceLocateTrait;
use Individu\Service\IndividuService;
use Application\Service\Role\RoleService;
use Structure\Service\Structure\StructureService;
use Structure\Service\StructureDocument\StructureDocumentService;
use Application\SourceCodeStringHelper;
use Interop\Container\ContainerInterface;

class EcoleDoctoraleControllerFactory
{
    use EtablissementServiceLocateTrait;

    /**
     * Create service
     *
     * @param ContainerInterface $container
     * @return EcoleDoctoraleController
     */
    public function __invoke(ContainerInterface $container)
    {
        /** @var EcoleDoctoraleForm $form */
        $form = $container->get('FormElementManager')->get('EcoleDoctoraleForm');

        /**
         * @var CoEncadrantService $coEncadrantService
         * @var EcoleDoctoraleService $ecoleDoctoralService
         * @var IndividuService $individuService
         * @var RoleService $roleService
         * @var StructureService $structureService
         * @var StructureDocumentService $structureDocumentService
         */
        $coEncadrantService = $container->get(CoEncadrantService::class);
        $ecoleDoctoralService = $container->get('EcoleDoctoraleService');
        $structureService = $container->get(StructureService::class);
        $roleService = $container->get('RoleService');
        $structureDocumentService = $container->get(StructureDocumentService::class);

        $controller = new EcoleDoctoraleController();
        $controller->setCoEncadrantService($coEncadrantService);
        $controller->setEcoleDoctoraleService($ecoleDoctoralService);
        $controller->setRoleService($roleService);
        $controller->setStructureForm($form);
        $controller->setStructureService($structureService);
        $controller->setStructureDocumentService($structureDocumentService);

        /**
         * @var SourceCodeStringHelper $sourceCodeHelper
         */
        $sourceCodeHelper = $container->get(SourceCodeStringHelper::class);
        $controller->setSourceCodeStringHelper($sourceCodeHelper);

        return $controller;
    }
}