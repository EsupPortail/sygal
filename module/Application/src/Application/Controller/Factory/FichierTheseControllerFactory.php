<?php

namespace Application\Controller\Factory;

use Application\Controller\FichierTheseController;
use Application\Service\Fichier\FichierService;
use Application\Service\Notification\NotificationService;
use Application\Service\These\TheseService;
use Application\Service\VersionFichier\VersionFichierService;
use Zend\Mvc\Controller\ControllerManager;

class FichierTheseControllerFactory
{
    /**
     * Create service
     *
     * @param ControllerManager $controllerManager
     * @return FichierTheseController
     */
    public function __invoke(ControllerManager $controllerManager)
    {
        /**
         * @var TheseService $theseService
         * @var FichierService $fichierService
         * @var VersionFichierService $versionFichierService
         * @var NotificationService $notificationService
         */
        $theseService = $controllerManager->getServiceLocator()->get('TheseService');
        $fichierService = $controllerManager->getServiceLocator()->get('FichierService');
        $versionFichierService = $controllerManager->getServiceLocator()->get('VersionFichierService');
        $notificationService = $controllerManager->getServiceLocator()->get('NotificationService');

        $controller = new FichierTheseController();
        $controller->setTheseService($theseService);
        $controller->setFichierService($fichierService);
        $controller->setVersionFichierService($versionFichierService);
        $controller->setNotificationService($notificationService);

        return $controller;
    }
}


