<?php

namespace Formation\Controller;

use Application\Service\AnneeUniv\AnneeUnivService;
use Formation\Service\Module\ModuleService;
use Formation\Service\Notification\FormationNotificationFactory;
use Formation\Service\Session\SessionService;
use Notification\Service\NotifierService;
use Psr\Container\ContainerExceptionInterface;
use Psr\Container\NotFoundExceptionInterface;
use Structure\Service\Etablissement\EtablissementService;
use Doctrine\ORM\EntityManager;
use Formation\Form\Formation\FormationForm;
use Formation\Service\Formation\FormationService;
use Interop\Container\ContainerInterface;

class FormationControllerFactory {

    /**
     * @param ContainerInterface $container
     * @return FormationController
     * @throws ContainerExceptionInterface
     * @throws NotFoundExceptionInterface
     */
    public function __invoke(ContainerInterface $container) : FormationController
    {
        /**
         * @var EntityManager $entityManager
         * @var EtablissementService $etablissementService
         * @var FormationService $formationService
         * @var ModuleService $moduleService
         * @var SessionService $sessionService
         */
        $entityManager = $container->get('doctrine.entitymanager.orm_default');
        $etablissementService = $container->get(EtablissementService::class);
        $formationService = $container->get(FormationService::class);
        $moduleService = $container->get(ModuleService::class);
        $sessionService = $container->get(SessionService::class);
        $notificationService = $container->get(NotifierService::class);
        /** @var FormationNotificationFactory $formationNotificationFactory */
        $formationNotificationFactory = $container->get(FormationNotificationFactory::class);
        $anneeUnivService = $container->get(AnneeUnivService::class);

        /**
         * @var FormationForm $formationForm
         */
        $formationForm = $container->get('FormElementManager')->get(FormationForm::class);

        $controller = new FormationController();
        $controller->setEntityManager($entityManager);
        $controller->setEtablissementService($etablissementService);
        $controller->setFormationService($formationService);
        $controller->setModuleService($moduleService);
        $controller->setSessionService($sessionService);
        $controller->setFormationForm($formationForm);
        $controller->setNotifierService($notificationService);
        $controller->setFormationNotificationFactory($formationNotificationFactory);
        $controller->setAnneeUnivService($anneeUnivService);

        return $controller;
    }
}