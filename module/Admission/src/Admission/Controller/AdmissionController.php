<?php /** @noinspection PhpUnusedAliasInspection */

namespace Admission\Controller;

use Admission\Form\Etudiant\EtudiantForm;
use Laminas\View\Model\ViewModel;

class AdmissionController extends AdmissionAbstractController {

    public function __construct(EtudiantForm $form)
    {
        $this->form = $form;
    }

    protected $form;

    public function ajouterAction()
    {
        $form = $this->getForm();

        return $this->multipageForm($form)
            ->setUsePostRedirectGet()
            ->setReuseRequestQueryParams() // la redir vers la 1ere étape conservera les nom, prenom issus de la recherche
            ->start(); // réinit du plugin et redirection vers la 1ère étape
    }

    public function etudiantAction()
    {
        $form = $this->getForm();

        $form->get('etudiant')->get('infosEtudiant')->setUrlPaysNationalite($this->url()->fromRoute('pays/rechercher-pays', [], [], true));
        $form->get('etudiant')->get('infosEtudiant')->setUrlNationalite($this->url()->fromRoute('pays/rechercher-nationalite', [], [], true));
//
        $response = $this->processMultipageForm($form);
        if ($response instanceof Response) {
            return $response;
        }

        $response->setTemplate('admission/etudiant');

        return $response;
    }

    protected function processMultipageForm(EtudiantForm $form)
    {
        $response = $this->multipageForm($form)
            ->setUsePostRedirectGet()
            ->process();

        if ($response instanceof Response) {
            return $response;
        }

        $form->prepare(); // requis

        return new ViewModel($response);
    }

//    public function ajouterAnnulerAction()
//    {
//        return $this->redirect()->toRoute('admission/informations-etudiants');
//    }
//
//    public function ajouterConfirmerAction()
//    {
//        $response = $this->multipageForm($this->getForm())->process();
//        if ($response instanceof Response) {
//            return $response;
//        }
//        return array('form' => $this->getForm());
//    }
//
//    public function ajouterEnregistrerAction()
//    {
//        $data = $this->multipageForm($this->getForm())->getFormSessionData();
//        // ...
//        // enregistrement en base de données (par exemple)
//        // ...
//        return $this->redirect()->toRoute('home');
//    }

    protected function getForm()
    {
        if (null === $this->form) {
            $this->form = new EtudiantForm();
        }

        return $this->form;
    }


//    public function addInformationsEtudiantAction() : ViewModel
//    {
//        $this->form->get('etudiant')->get('infosEtudiant')->setUrlPaysNationalite($this->url()->fromRoute('pays/rechercher-pays', [], [], true));
//        $this->form->get('etudiant')->get('infosEtudiant')->setUrlNationalite($this->url()->fromRoute('pays/rechercher-nationalite', [], [], true));
//        return new ViewModel([
//            'form' => $this->form,
//        ]);
//    }
//    public function addInformationsInscriptionAction() : ViewModel
//    {
//        $this->form->get('inscription')->get('specifitesEnvisagees')->setUrlPaysNationalite($this->url()->fromRoute('pays/rechercher-pays', [], [], true));
//        return new ViewModel([
//            'form' => $this->form,
//        ]);
//    }
//
//    public function addInformationsFinancementAction() : ViewModel
//    {
//        return new ViewModel([
//            'form' => $this->form,
//        ]);
//    }
//
//    public function addInformationsJustificatifsAction() : ViewModel
//    {
//        return new ViewModel([
//            'form' => $this->form,
//        ]);
//    }

}