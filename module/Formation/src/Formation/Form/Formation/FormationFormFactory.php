<?php

namespace Formation\Form\Formation;

use Application\Service\Etablissement\EtablissementService;
use Application\Service\Structure\StructureService;
use Formation\Service\Module\ModuleService;
use Interop\Container\ContainerInterface;
use Laminas\View\Helper\Url;

class FormationFormFactory {

    /**
     * @param ContainerInterface $container
     * @return FormationForm
     */
    public function __invoke(ContainerInterface $container) : FormationForm
    {
        /**
         * @var EtablissementService $etablissementService
         * @var ModuleService $moduleService
         * @var StructureService $structureService
        **/
        $etablissementService = $container->get(EtablissementService::class);
        $moduleService = $container->get(ModuleService::class);
        $structureService = $container->get(StructureService::class);

        /** @var FormationHydrator $hydrator */
        $hydrator = $container->get('HydratorManager')->get(FormationHydrator::class);

        $form = new FormationForm();
        /** @var Url $urlManager */
        $pluginManager = $container->get('ViewHelperManager');
        $urlManager = $pluginManager->get('Url');
        /** @see AgentController::rechercherAction() */
        $urlResponsable =  $urlManager->__invoke('utilisateur/rechercher-individu', [], [], true);
        $form->setUrlResponsable($urlResponsable);
        $form->setEtablissementService($etablissementService);
        $form->setModuleService($moduleService);
        $form->setStructureService($structureService);
        $form->setHydrator($hydrator);
        return $form;
    }
}