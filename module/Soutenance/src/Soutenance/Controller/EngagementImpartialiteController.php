<?php

namespace Soutenance\Controller;

use Application\Controller\AbstractController;
use Application\Entity\Db\Validation;
use Notification\Exception\RuntimeException;
use Soutenance\Provider\Template\TexteTemplates;
use Soutenance\Service\Notification\SoutenanceNotificationFactoryAwareTrait;
use These\Service\Acteur\ActeurServiceAwareTrait;
use Soutenance\Entity\Evenement;
use Soutenance\Entity\Membre;
use Soutenance\Service\EngagementImpartialite\EngagementImpartialiteServiceAwareTrait;
use Soutenance\Service\Evenement\EvenementServiceAwareTrait;
use Soutenance\Service\Membre\MembreServiceAwareTrait;
use Notification\Service\NotifierServiceAwareTrait;
use Soutenance\Service\Proposition\PropositionServiceAwareTrait;
use UnicaenAuthToken\Service\TokenServiceAwareTrait;
use Laminas\View\Model\ViewModel;
use UnicaenRenderer\Service\Rendu\RenduServiceAwareTrait;

/**
 * Class SoutenanceController
 * @package Soutenance\Controller
 */

class EngagementImpartialiteController extends AbstractController
{
    use ActeurServiceAwareTrait;
    use EvenementServiceAwareTrait;
    use EngagementImpartialiteServiceAwareTrait;
    use MembreServiceAwareTrait;
    use NotifierServiceAwareTrait;
    use SoutenanceNotificationFactoryAwareTrait;
    use PropositionServiceAwareTrait;
    use RenduServiceAwareTrait;
    use TokenServiceAwareTrait;

    public function engagementImpartialiteAction() : ViewModel
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);
        $membre = $this->getMembreService()->getRequestedMembre($this);

        $vars = [ 'membre' => $membre, 'doctorant' => $these->getDoctorant() ];
        $texteEngagnement = $this->getRenduService()->generateRenduByTemplateCode(TexteTemplates::SOUTENANCE_ENGAGEMENT_IMPARTIALITE, $vars);

        /** @var Validation $validation */
        $validation = $this->getEngagementImpartialiteService()->getEngagementImpartialiteByMembre($these, $membre);
        if ($validation === null) $validation = $this->getEngagementImpartialiteService()->getRefusEngagementImpartialiteByMembre($these, $membre);

        return new ViewModel([
            'these' => $these,
            'proposition' => $proposition,
            'membre' => $membre,
            'validation' => $validation,
            'encadrants' => $this->getActeurService()->getRepository()->findEncadrementThese($these),
            'urlSigner' => $this->url()->fromRoute('soutenance/engagement-impartialite/signer', ['these' => $these->getId(), 'membre' => $membre->getId()], [], true),
            'urlRefuser' => $this->url()->fromRoute('soutenance/engagement-impartialite/refuser', ['these' => $these->getId(), 'membre' => $membre->getId()], [], true),
            'urlAnnuler' => $this->url()->fromRoute('soutenance/engagement-impartialite/annuler', ['these' => $these->getId(), 'membre' => $membre->getId()], [], true),

            'texteEngagement' => $texteEngagnement,
        ]);
    }

    public function notifierRapporteursEngagementImpartialiteAction()
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);

        /** @var Membre $membre */
        foreach ($proposition->getMembres() as $membre) {
            if ($membre->getActeur() and $membre->estRapporteur()) {
                $validation = $this->getEngagementImpartialiteService()->getEngagementImpartialiteByMembre($these, $membre);
                if (!$validation) {
                    $token = $this->getMembreService()->retrieveOrCreateToken($membre);
                    $url_rapporteur = $this->url()->fromRoute("soutenance/index-rapporteur", ['these' => $these->getId()], ['force_canonical' => true], true);
                    $url = $this->url()->fromRoute('zfcuser/login', ['type' => 'token'], ['query' => ['token' => $token->getToken(), 'redirect' => $url_rapporteur, 'role' => $membre->getActeur()->getRole()->getRoleId()], 'force_canonical' => true], true);
                    try {
                        $notif = $this->soutenanceNotificationFactory->createNotificationDemandeSignatureEngagementImpartialite($these, $proposition, $membre, $url);
                        $this->notifierService->trigger($notif);
                    } catch (RuntimeException $e) {
                        // aucun destintaire, todo : cas à gérer !
                    }
                }
            }
        }

        $this->getEvenementService()->ajouterEvenement($proposition, Evenement::EVENEMENT_ENGAGEMENT);
        $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $these->getId()], [], true);
    }

    public function notifierEngagementImpartialiteAction()
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);
        $membre = $this->getMembreService()->getRequestedMembre($this);

        if ($membre->getActeur()) {
            $token = $this->getMembreService()->retrieveOrCreateToken($membre);
            $url_rapporteur = $this->url()->fromRoute("soutenance/index-rapporteur", ['these' => $these->getId()], ['force_canonical' => true], true);
            $url = $this->url()->fromRoute('zfcuser/login', ['type' => 'token'], ['query' => ['token' => $token->getToken(), 'redirect' => $url_rapporteur, 'role' => $membre->getActeur()->getRole()->getRoleId()], 'force_canonical' => true], true);
            try {
                $notif = $this->soutenanceNotificationFactory->createNotificationDemandeSignatureEngagementImpartialite($these, $proposition, $membre, $url);
                $this->notifierService->trigger($notif);
            } catch (RuntimeException $e) {
                // aucun destintaire, todo : cas à gérer !
            }
        }

        $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $these->getId()], [], true);
    }

    public function signerEngagementImpartialiteAction()
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);
        $membre = $this->getMembreService()->getRequestedMembre($this);

        $signature = $this->getEngagementImpartialiteService()->getEngagementImpartialiteByMembre($these, $membre);
        if ($signature === null) {
            $this->getEngagementImpartialiteService()->create($membre, $these);
            try {
                $notif = $this->soutenanceNotificationFactory->createNotificationSignatureEngagementImpartialite($these, $proposition, $membre);
                $this->notifierService->trigger($notif);
            } catch (RuntimeException $e) {
                // aucun destintaire, todo : cas à gérer !
            }
        }

        $this->redirect()->toRoute('soutenance/engagement-impartialite', ['these' => $these->getId(), 'membre' => $membre->getId()], [], true);
    }

    public function refuserEngagementImpartialiteAction()
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);
        $membre = $this->getMembreService()->getRequestedMembre($this);

        $this->getEngagementImpartialiteService()->createRefus($membre, $these);
        $this->getPropositionService()->annulerValidationsForProposition($proposition);
        try {
            $notif = $this->soutenanceNotificationFactory->createNotificationRefusEngagementImpartialite($these, $proposition, $membre);
            $this->notifierService->trigger($notif);
        } catch (RuntimeException $e) {
            // aucun destintaire, todo : cas à gérer !
        }


        $this->redirect()->toRoute('soutenance/engagement-impartialite', ['these' => $these->getId(), 'membre' => $membre->getId()], [], true);
    }

    public function annulerEngagementImpartialiteAction()
    {
        $these = $this->requestedThese();
        $proposition = $this->getPropositionService()->findOneForThese($these);
        $membre = $this->getMembreService()->getRequestedMembre($this);

        /** @var Validation[] $validations */
        $this->getEngagementImpartialiteService()->delete($membre);
        try {
            $notif = $this->soutenanceNotificationFactory->createNotificationAnnulationEngagementImpartialite($these, $proposition, $membre);
            $this->notifierService->trigger($notif);
        } catch (RuntimeException $e) {
            // aucun destintaire, todo : cas à gérer !
        }

        $this->redirect()->toRoute('soutenance/presoutenance', ['these' => $these->getId()], [], true);
    }
}