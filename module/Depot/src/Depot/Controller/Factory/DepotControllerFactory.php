<?php

namespace Depot\Controller\Factory;

use Application\Service\MailConfirmationService;
use Application\Service\Notification\NotifierService;
use Application\Service\Role\RoleService;
use Application\Service\Utilisateur\UtilisateurService;
use Application\Service\Validation\ValidationService;
use Application\Service\Variable\VariableService;
use Depot\Controller\DepotController;
use Depot\Service\FichierThese\FichierTheseService;
use Depot\Service\These\DepotService;
use Depot\Service\Validation\DepotValidationService;
use Doctrine\ORM\EntityManager;
use Fichier\Service\Fichier\FichierStorageService;
use Fichier\Service\VersionFichier\VersionFichierService;
use Individu\Service\IndividuService;
use Interop\Container\ContainerInterface;
use Laminas\View\Renderer\PhpRenderer;
use Structure\Service\Etablissement\EtablissementService;
use Structure\Service\UniteRecherche\UniteRechercheService;
use These\Service\Acteur\ActeurService;
use These\Service\These\TheseService;

class DepotControllerFactory
{
    /**
     * Create service
     *
     * @param ContainerInterface $container
     * @return DepotController
     */
    public function __invoke(ContainerInterface $container): DepotController
    {
        $options = $this->getOptions($container);

        /**
         * @var VariableService         $variableService
         * @var ValidationService       $validationService
         * @var DepotValidationService  $depotValidationService
         * @var VersionFichierService   $versionFichierService
         * @var TheseService            $theseService
         * @var RoleService             $roleService
         * @var FichierTheseService     $fichierTheseService
         * @var FichierStorageService   $fileService
         * @var \Depot\Service\Workflow\WorkflowService         $workflowService
         * @var NotifierService         $notifierService
         * @var EtablissementService    $etablissementService
         * @var UniteRechercheService   $uniteService
         * @var MailConfirmationService $mailConfirmationService
         * @var EntityManager           $entityManager
         * @var UtilisateurService      $utilisateurService
         * @var ActeurService           $acteurService
         * @var IndividuService         $indivdiService
         */
        $variableService = $container->get('VariableService');
        $validationService = $container->get('ValidationService');
        $depotValidationService = $container->get(DepotValidationService::class);
        $versionFichierService = $container->get('VersionFichierService');
        $theseService = $container->get('TheseService');
        $roleService = $container->get('RoleService');
        $uniteService = $container->get('UniteRechercheService');
        $fichierTheseService = $container->get('FichierTheseService');
        $fileService = $container->get(FichierStorageService::class);
        $workflowService = $container->get('WorkflowService');
        $etablissementService = $container->get('EtablissementService');
        $mailConfirmationService = $container->get('MailConfirmationService');
        $entityManager = $container->get('doctrine.entitymanager.orm_default');
        $notifierService = $container->get(NotifierService::class);
        $utilisateurService = $container->get('UtilisateurService');

        /**
         * @var \Depot\Form\RdvBuTheseDoctorantForm $rdvBuTheseDoctorantForm
         * @var \Depot\Form\RdvBuTheseForm $rdvBuTheseForm
         */
        $rdvBuTheseDoctorantForm = $container->get('FormElementManager')->get('RdvBuTheseDoctorantForm');
        $rdvBuTheseForm = $container->get('FormElementManager')->get('RdvBuTheseForm');

        /**
         * @var \Depot\Form\Attestation\AttestationTheseForm $attestationTheseForm
         * @var \Depot\Form\Diffusion\DiffusionTheseForm $diffusionTheseForm
         * @var \Depot\Form\Metadonnees\MetadonneeTheseForm $metadonneeTheseForm
         * @var \Depot\Form\PointsDeVigilanceForm $pointsDeVigilanceForm
         */
        $attestationTheseForm = $container->get('FormElementManager')->get('AttestationTheseForm');
        $diffusionTheseForm = $container->get('FormElementManager')->get('DiffusionTheseForm');
        $metadonneeTheseForm = $container->get('FormElementManager')->get('MetadonneeTheseForm');
        $pointsDeVigilanceForm = $container->get('FormElementManager')->get('PointsDeVigilanceForm');

        /* @var $renderer PhpRenderer */
        $renderer = $container->get('ViewRenderer');

        $controller = new DepotController();
        $controller->setTimeoutRetraitement($this->getTimeoutRetraitementFromOptions($options));
        $controller->setVariableService($variableService);
        $controller->setValidationService($validationService);
        $controller->setDepotValidationService($depotValidationService);
        $controller->setVersionFichierService($versionFichierService);
        $controller->setTheseService($theseService);
        $controller->setRoleService($roleService);
        $controller->setFichierTheseService($fichierTheseService);
        $controller->setFichierStorageService($fileService);
        $controller->setWorkflowService($workflowService);
        $controller->setEtablissementService($etablissementService);
        $controller->setUniteRechercheService($uniteService);
        $controller->setMailConfirmationService($mailConfirmationService);
        $controller->setEntityManager($entityManager);
        $controller->setNotifierService($notifierService);
        $controller->setUtilisateurService($utilisateurService);
        $controller->setRdvBuTheseDoctorantForm($rdvBuTheseDoctorantForm);
        $controller->setRdvBuTheseForm($rdvBuTheseForm);
        $controller->setAttestationTheseForm($attestationTheseForm);
        $controller->setDiffusionTheseForm($diffusionTheseForm);
        $controller->setMetadonneeTheseForm($metadonneeTheseForm);
        $controller->setPointsDeVigilanceForm($pointsDeVigilanceForm);
        $controller->setRenderer($renderer);

        /** @var DepotService $depotService */
        $depotService = $container->get(DepotService::class);
        $controller->setDepotService($depotService);

        return $controller;
    }

    private function getTimeoutRetraitementFromOptions(array $options)
    {
        return $options['retraitement']['timeout'] ?? null;
    }

    private function getOptions(ContainerInterface $container)
    {
        $options = $container->get('config');

        return $options['sygal'] ?? [];
    }
}