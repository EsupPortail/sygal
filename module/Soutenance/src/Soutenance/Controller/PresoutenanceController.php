<?php

namespace Soutenance\Controller;


use Application\Controller\AbstractController;
use Application\Entity\Db\Acteur;
use Application\Entity\Db\Fichier;
use Application\Entity\Db\NatureFichier;
use Application\Entity\Db\These;
use Application\Entity\Db\TypeValidation;
use Application\Entity\Db\Utilisateur;
use Application\Entity\Db\VersionFichier;
use Application\Service\Acteur\ActeurServiceAwareTrait;
use Application\Service\Fichier\FichierServiceAwareTrait;
use Application\Service\Individu\IndividuServiceAwareTrait;
use Application\Service\Role\RoleServiceAwareTrait;
use Application\Service\These\TheseServiceAwareTrait;
use Application\Service\Utilisateur\UtilisateurServiceAwareTrait;
use Application\Service\Validation\ValidationServiceAwareTrait;
use DateInterval;
use Exception;
use Soutenance\Entity\Avis;
use Soutenance\Entity\Membre;
use Soutenance\Entity\Proposition;
use Soutenance\Form\SoutenanceDateRenduRapport\SoutenanceDateRenduRapportForm;
use Soutenance\Service\Avis\AvisServiceAwareTrait;
use Soutenance\Service\Membre\MembreServiceAwareTrait;
use Soutenance\Service\Notifier\NotifierSoutenanceServiceAwareTrait;
use Soutenance\Service\Parametre\ParametreServiceAwareTrait;
use Soutenance\Service\Proposition\PropositionServiceAwareTrait;
use UnicaenApp\Exception\RuntimeException;
use Zend\Http\Request;
use Zend\View\Model\ViewModel;

// TODO mettre directement l'acteur dans la table membre simplifierai beaucoup de chose ...

class PresoutenanceController extends AbstractController
{
    use TheseServiceAwareTrait;
    use MembreServiceAwareTrait;
    use IndividuServiceAwareTrait;
    use NotifierSoutenanceServiceAwareTrait;
    use PropositionServiceAwareTrait;
    use ActeurServiceAwareTrait;
    use ValidationServiceAwareTrait;
    use RoleServiceAwareTrait;
    use AvisServiceAwareTrait;
    use FichierServiceAwareTrait;
    use UtilisateurServiceAwareTrait;
    use ParametreServiceAwareTrait;

    public function presoutenanceAction()
    {
        /** @var These $these */
        $idThese = $this->params()->fromRoute('these');
        $these = $this->getTheseService()->getRepository()->find($idThese);

        /** @var Proposition $proposition */
        $proposition = $this->getPropositionService()->findByThese($these);
        $rapporteurs = $this->getPropositionService()->getRapporteurs($proposition);

        /** Si la proposition ne possède pas encore de date de rendu de rapport alors la valeur par défaut est donnée */
        $renduRapport = $proposition->getRenduRapport();
        if (!$renduRapport) {
            try {
                $renduRapport = $proposition->getDate();
                $deadline = $this->getParametreService()->getParametreByCode('AVIS_DEADLINE')->getValeur();
                $renduRapport = $renduRapport->sub(new DateInterval('P'. $deadline.'D'));
            } catch (Exception $e) {
                throw new RuntimeException("Un problème a été rencontré lors du calcul de la date de rendu des rapport.");
            }
            $proposition->setRenduRapport($renduRapport);
            $this->getPropositionService()->update($proposition);
        }

        /** Recupération des engagements d'impartialité */
        $engagements = [];
        foreach ($rapporteurs as $rapporteur) {
            if ($rapporteur->getIndividu()) {
                $validations = $this->getValidationService()->getRepository()->findValidationByCodeAndIndividu(TypeValidation::CODE_ENGAGEMENT_IMPARTIALITE, $rapporteur->getIndividu());
                if ($validations) $engagements[$rapporteur->getIndividu()->getId()] = current($validations);
            }
        }

        /** Récupération des avis de soutenances */
        $avis = $this->getAvisService()->getAvisByThese($these);
        $tousLesAvis = count($avis) === count($rapporteurs);


        return new ViewModel([
            'these'                 => $these,
            'proposition'           => $proposition,
            'rapporteurs'           => $rapporteurs,
            'engagements'           => $engagements,
            'avis'                  => $avis,
            'tousLesAvis'           => $tousLesAvis,
            'urlFichierThese'        => $this->urlFichierThese(),

            'deadline' => $this->getParametreService()->getParametreByCode('AVIS_DEADLINE')->getValeur(),
        ]);
    }


    public function dateRenduRapportAction()
    {
        /** @var These $these */
        $idThese = $this->params()->fromRoute('these');
        $these = $this->getTheseService()->getRepository()->find($idThese);

        /** @var Proposition $proposition */
        $proposition = $this->getPropositionService()->findByThese($these);

        /** @var SoutenanceDateRenduRapportForm $form */
        $form = $this->getServiceLocator()->get('FormElementManager')->get(SoutenanceDateRenduRapportForm::class);
        $form->setAttribute('action', $this->url()->fromRoute('soutenance/presoutenance/date-rendu-rapport', ['these' => $these->getId()], [], true));
        $form->bind($proposition);

        /** @var Request $request */
        $request = $this->getRequest();
        if ($request->isPost()) {
            $data = $request->getPost();
            $form->setData($data);
            if ($form->isValid()) {
                $this->getPropositionService()->update($proposition);
            }
        }

        return new ViewModel([
                'form' => $form,
                'title' => 'Modification de la date de rendu des rapports',
            ]
        );
    }

    /**
     * Ici on affecte au membre des acteurs qui remonte des SIs des établissements
     * Puis on affecte les rôles rapporteurs et membres
     * QUID :: Président ...
     */
    public function associerJuryAction()
    {
        /** @var These $these */
        $theseId = $this->params()->fromRoute('these');
        $these = $this->getTheseService()->getRepository()->find($theseId);

        /** @var Membre $membre */
        $idMembre = $this->params()->fromRoute('membre');
        $membre = $this->getMembreService()->find($idMembre);

        $acteurs = $this->getActeurService()->getRepository()->findActeurByThese($these);

        /** @var Request $request */
        $request = $this->getRequest();
        if ($request->isPost()) {
            $data = $request->getPost();
            $acteurId = $data['acteur'];
            /** @var Acteur $acteur */
            $acteur = $this->getActeurService()->getRepository()->find($acteurId);

            if (!$acteur) {
                throw new RuntimeException("Aucun acteur à associer !");
            } else {
                //mise à jour du membre de soutenance
                $membre->setIndividu($acteur->getIndividu());
                $this->getMembreService()->update($membre);
                //affectation du rôle
                $this->getRoleService()->addIndividuRole($acteur->getIndividu(),$acteur->getRole());
            }
        }

        return new ViewModel([
            'title' => "Association de ".$membre->getDenomination()." à un acteur SyGAL",
            'acteurs' => $acteurs,
            'membre' => $membre,
            'these' => $these,
        ]);
    }

    public function deassocierJuryAction() {
        /** @var These $these */
        $theseId = $this->params()->fromRoute('these');
        $these = $this->getTheseService()->getRepository()->find($theseId);

        /** @var Membre $membre */
        $idMembre = $this->params()->fromRoute('membre');
        $membre = $this->getMembreService()->find($idMembre);

//        /** @var Proposition $proposition */
//        $proposition = $this->getPropositionService()->findByThese($these);

        /** @var Acteur[] $acteurs */
        $acteurs = $this->getActeurService()->getRepository()->findActeurByThese($these);
        $acteur = null;
        foreach ($acteurs as $acteur_) {
            if ($acteur_->getIndividu() === $membre->getIndividu()) $acteur = $acteur_;
        }
        if (!$acteur) {
            throw new RuntimeException("Aucun acteur à deassocier !");
        } else {
            //retrait dans membre de soutenance
            $membre->setIndividu(null);
            $this->getMembreService()->update($membre);
            //retrait du role
            $this->getRoleService()->removeIndividuRole($acteur->getIndividu(), $acteur->getRole());
            //annuler impartialite
            $validations = $this->getValidationService()->getRepository()->findValidationByCodeAndIndividu(TypeValidation::CODE_ENGAGEMENT_IMPARTIALITE, $acteur->getIndividu());
            if (!empty($validations)) {
                $this->getValidationService()->unsignEngagementImpartialite(current($validations));
//                $this->getNotifierService()->triggerAnnulationEngagementImpartialite($these, $proposition, $membre);
            }


            $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $these->getId()], [], true);
        }
    }

    /**
     * Envoi des demandes d'avis de soutenance
     * /!\ si un membre est fourni alors seulement envoyé à celui-ci sinon à tous les rapporteurs
     */
    public function notifierDemandeAvisSoutenanceAction()
    {
        /** @var These $these */
        $idThese = $this->params()->fromRoute('these');
        $these = $this->getTheseService()->getRepository()->find($idThese);

        /** @var Proposition $proposition */
        $proposition = $this->getPropositionService()->findByThese($these);

        /** @var Membre $membre */
        $idMembre = $this->params()->fromRoute('membre');
        $membre = $this->getMembreService()->find($idMembre);

        /** @var Membre[] $rapporteurs */
        $rapporteurs = [];
        if ($membre) {
            $rapporteurs[] = $membre;
        } else {
            $rapporteurs = $this->getPropositionService()->getRapporteurs($proposition);
        }

        /** @var Membre $rapporteur */
        foreach ($rapporteurs as $rapporteur) {
            $this->getNotifierSoutenanceService()->triggerDemandeAvisSoutenance($these, $proposition, $rapporteur);
        }

        $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $these->getId()], [], true);
    }

    public function revoquerAvisSoutenanceAction()
    {
        $idAvis = $this->params()->fromRoute('avis');
        $avis = $this->getAvisService()->getAvis($idAvis);

        //historisation de la validation associée et du prérapport
        $avis->getValidation()->historiser();
        $avis->getFichier()->historiser();
        $avis->historiser();
        $this->getAvisService()->update($avis);

        $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $avis->getThese()->getId()], [], true);
    }
}