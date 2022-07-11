<?php

namespace Structure\Controller;

use Structure\Entity\Db\Etablissement;
use Individu\Entity\Db\Individu;
use Individu\Entity\Db\IndividuRole;
use Application\Entity\Db\Role;
use Structure\Entity\Db\TypeStructure;
use Structure\Service\Etablissement\EtablissementService;
use Structure\Service\Etablissement\EtablissementServiceAwareTrait;
use Application\Service\Role\RoleServiceAwareTrait;
use Structure\Service\StructureDocument\StructureDocumentServiceAwareTrait;
use Application\SourceCodeStringHelperAwareTrait;
use Laminas\View\Model\JsonModel;
use UnicaenApp\Exception\RuntimeException;
use Laminas\Http\Response;
use Laminas\View\Model\ViewModel;

/**
 * Class EtablissementController
 */
class EtablissementController extends StructureConcreteController
{
    use EtablissementServiceAwareTrait;
    use RoleServiceAwareTrait;
    use SourceCodeStringHelperAwareTrait;
    use StructureDocumentServiceAwareTrait;

    protected $codeTypeStructure = TypeStructure::CODE_ETABLISSEMENT;

    /**
     * @var string
     */
    protected $routeName = 'etablissement';

    /**
     * @return EtablissementService
     */
    protected function getStructureConcreteService()
    {
        return $this->etablissementService;
    }

    /**
     * @return ViewModel
     */
    public function indexAction()
    {
        $etablissements = $this->structureService->getAllStructuresAffichablesByType($this->codeTypeStructure, 'libelle');

        $etablissementsPrincipaux = array_filter($etablissements, function (Etablissement $e) {
            return $e->estMembre();
        });
        $etablissementsExternes = array_filter($etablissements, function (Etablissement $e) {
            return !$e->estMembre();
        });

        return new ViewModel([
            'etablissementsSygal'    => $etablissementsPrincipaux,
            'etablissementsExternes' => $etablissementsExternes,
        ]);
    }

    /**
     * @return ViewModel
     */
    public function informationAction(): ViewModel
    {
        $id = $this->params()->fromRoute('structure');
        /** @var Etablissement $etablissement */
        $etablissement = $this->getStructureConcreteService()->getRepository()->findByStructureId($id);
        if ($etablissement === null) {
            throw new RuntimeException("Aucun établissement ne possède l'identifiant renseigné.");
        }
        $contenus = $this->getStructureDocumentService()->getContenusFichiers($etablissement->getStructure());

        $roleListings = [];
        $individuListings = [];
        $roles = $this->roleService->getRolesByStructure($etablissement->getStructure());
        $individus = $this->roleService->getIndividuByStructure($etablissement->getStructure());
        $individuRoles = $this->roleService->getIndividuRoleByStructure($etablissement->getStructure());

        /** @var Role $role */
        foreach ($roles as $role) {
            if (!$role->isTheseDependant()) {
                $roleListings [$role->getLibelle()] = 0;
            }
        }

        /** @var Individu $individu */
        foreach ($individus as $individu) {
            $denomination = $individu->getNomComplet(false, false, false, true, false);
            $individuListings[$denomination] = [];
        }

        /** @var IndividuRole $individuRole */
        foreach ($individuRoles as $individuRole) {
            if (!$individuRole->getRole()->isTheseDependant()) {
                $denomination = $individuRole->getIndividu()->getNomComplet(false, false, false, true, false);
                $role = $individuRole->getRole()->getLibelle();
                $individuListings[$denomination][] = $role;
                $roleListings[$role]++;
            }
        }

        return new ViewModel([
            'etablissement'   => $etablissement,
            'roleListing'     => $roleListings,
            'individuListing' => $individuListings,
            'logoContent'     => $this->structureService->getLogoStructureContent($etablissement),
            'contenus'        => $contenus,
        ]);
    }

    /**
     * @return Response|ViewModel
     */
    public function modifierAction()
    {
        $viewModel = parent::modifierAction();

        if ($viewModel instanceof Response) {
            return $viewModel;
        }

        $viewModel->setTemplate('structure/etablissement/modifier');

        return $viewModel;
    }

    /**
     * @return Response|ViewModel
     */
    public function ajouterAction()
    {
        $viewModel = parent::ajouterAction();

        if ($viewModel instanceof Response) {
            return $viewModel;
        }

        $viewModel->setTemplate('structure/etablissement/modifier');

        return $viewModel;
    }

    public function rechercherAction()
    {
        if (($term = $this->params()->fromQuery('term'))) {
            $unites = $this->getEtablissementService()->getRepository()->findByText($term);
            $result = [];
            foreach ($unites as $unite) {
                $result[] = array(
                    'id' => $unite->getId(),            // identifiant unique de l'item
                    'label' => $unite->getLibelle(),    // libellé de l'item
                    'extra' => $unite->getSigle(),      // infos complémentaires (facultatives) sur l'item
                );
            }
            usort($result, function ($a, $b) {
                return strcmp($a['label'], $b['label']);
            });

            return new JsonModel($result);
        }
        exit;
    }

}