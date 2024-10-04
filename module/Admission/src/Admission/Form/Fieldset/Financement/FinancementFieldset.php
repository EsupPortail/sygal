<?php
namespace Admission\Form\Fieldset\Financement;

use Admission\Form\Fieldset\AdmissionBaseFieldset;
use Admission\Form\Fieldset\Verification\VerificationFieldset;
use Application\Entity\Db\OrigineFinancement;
use Laminas\Filter\StringTrim;
use Laminas\Filter\StripTags;
use Laminas\Filter\ToNull;
use Laminas\Form\Element\Radio;
use Laminas\Form\Element\Select;
use Laminas\Form\Element\Text;
use Laminas\Form\Element\Textarea;
use Laminas\Form\FormInterface;
use Laminas\InputFilter\InputFilterProviderInterface;

class FinancementFieldset extends AdmissionBaseFieldset implements InputFilterProviderInterface
{
    private array $financements;

    public function setFinancements(array $financements): void
    {
        $options = [];
        foreach ($financements as $origine) {
            /** @var OrigineFinancement $origine */
            if(!in_array($origine->getLibelleLong(), $options)){
                $options[$origine->getId()] = $origine->getLibelleLong();
            }
        }
        $this->financements = $options;
    }

    public function prepareElement(FormInterface $form): void
    {
        $this->get('financement')->setValueOptions($this->financements);
        $this->get('financementCompl')->setValueOptions($this->financements);
        parent::prepareElement($form); // TODO: Change the autogenerated stub
    }

    public function init()
    {

        $this->add(
            (new Radio('contratDoctoral'))
                ->setLabel("Avez-vous un contrat doctoral ?")
                ->setLabelAttributes(['data-after' => " / Do you have a PhD contract?"])
                ->setValueOptions([
                    1 => "Oui",
                    0 => "Non"
                ])
        );

        $this->add(
            (new Select("financement"))
                ->setLabel("Financement")
                ->setLabelAttributes(['data-after' => " / Funding"])
                ->setEmptyOption('Sélectionnez une option')
                ->setAttributes([
                    'class' => 'bootstrap-selectpicker show-tick',
                    'data-live-search' => 'true',
                    'id' => 'financement',
                ])
        );

        $this->add(
            (new Select("financementCompl"))
                ->setLabel("Financement (dans le cas d'un financement supplémentaire)")
                ->setLabelAttributes(['data-after' => " / Funding (in the case of additional funding)"])
                ->setEmptyOption('Sélectionnez une option')
                ->setAttributes([
                    'class' => 'bootstrap-selectpicker show-tick',
                    'data-live-search' => 'true',
                    'id' => 'financementCompl',
                ])
        );

        $this->add(
            (new Textarea('detailContratDoctoral'))
        );

        $this->add(
            (new Text('etablissementPartenaire'))
        );

        $this->add(
            (new Radio('tempsTravail'))
                ->setValueOptions([
                    1 => "temps complet",
                    2 => "temps partiel"
                ])
                ->setLabel("Temps de travail du doctorant mené à")
                ->setLabelAttributes(['data-after' => " / Doctoral student's working time in"])
        );

        $this->add(
            (new Radio('estSalarie'))
                ->setLabel("Êtes-vous salarié ?")
                ->setLabelAttributes(['data-after' => " / Are you employed?"])
                ->setValueOptions([
                    1 => "Oui",
                    0 => "Non"
                ])
        );

        $this->add(
            (new Text('statutProfessionnel'))
                ->setLabel("Statut professionnel")
                ->setLabelAttributes(['data-after' => " / Professional status"])
        );

        $verificationFieldset = $this->getFormFactory()->getFormElementManager()->get(VerificationFieldset::class);
        $verificationFieldset->setName("verificationFinancement");
        $this->add($verificationFieldset);
    }

    /**
     * @return array
     */
    public function getInputFilterSpecification(): array
    {
        return [
            'contratDoctoral' => [
                'name' => 'contratDoctoral',
                'required' => false,
            ],
            'etablissementPartenaire' => [
                'name' => 'etablissementPartenaire',
                'required' => false,
            ],
            'financement' => [
                'name' => 'financement',
                'required' => false,
                'filters' => [
                    ['name' => ToNull::class], /** nécessaire et suffisant pour mettre la relation à null */
                ],
            ],
            'financementCompl' => [
                'name' => 'financementCompl',
                'required' => false,
                'filters' => [
                    ['name' => ToNull::class], /** nécessaire et suffisant pour mettre la relation à null */
                ],
            ],
            'detailContratDoctoral' => [
                'name' => 'detailContratDoctoral',
                'required' => false,
                'filters' => [
                    ['name' => StripTags::class],
                    ['name' => StringTrim::class],
                ],
            ],
            'tempsTravail' => [
                'name' => 'tempsTravail',
                'required' => false,
            ],
            'estSalarie' => [
                'name' => 'contratDoctoral',
                'required' => false,
            ],
            'statutProfessionnel' => [
                'name' => 'statutProfessionnel',
                'required' => false,
                'filters' => [
                    ['name' => StripTags::class],
                    ['name' => StringTrim::class],
                ],
            ],
        ];
    }
}