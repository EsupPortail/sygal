<?php

namespace These\Controller\Factory;

use Depot\Service\These\DepotService;
use These\Controller\PresidentJuryController;
use Application\Form\AdresseMail\AdresseMailForm;
use These\Service\Acteur\ActeurService;
use These\Service\These\TheseService;
use Interop\Container\ContainerInterface;
use Soutenance\Service\Membre\MembreService;

class PresidentJuryControllerFactory
{
    /**
     * @param ContainerInterface $container
     * @return PresidentJuryController
     */
    public function __invoke(ContainerInterface $container)
    {
        /**
         * @var ActeurService $acteurService
         * @var MembreService $membreService
         * @var TheseService $theseService
         */
        $acteurService = $container->get(ActeurService::class);
        $membreService = $container->get(MembreService::class);
        $theseService = $container->get(TheseService::class);

        /**
         * @var AdresseMailForm $adresseMailForm
         */
        $adresseMailForm = $container->get('FormElementManager')->get(AdresseMailForm::class);

        $controller = new PresidentJuryController();
        $controller->setActeurService($acteurService);
        $controller->setMembreService($membreService);
        $controller->setTheseService($theseService);
        $controller->setAdresseMailForm($adresseMailForm);

        /** @var DepotService $depotService */
        $depotService = $container->get(DepotService::class);
        $controller->setDepotService($depotService);

        return $controller;
    }
}