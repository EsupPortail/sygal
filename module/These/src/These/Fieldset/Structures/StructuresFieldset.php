<?php

namespace These\Fieldset\Structures;

use DoctrineModule\Form\Element\ObjectSelect;
use Laminas\Form\Element\Hidden;
use Laminas\Form\Fieldset;
use Laminas\Form\FormInterface;
use Laminas\InputFilter\InputFilterProviderInterface;
use Laminas\Validator\NotEmpty;
use Structure\Entity\Db\EcoleDoctorale;
use Structure\Entity\Db\Etablissement;
use Structure\Entity\Db\TypeStructure;
use Structure\Entity\Db\UniteRecherche;
use Structure\Service\Etablissement\EtablissementServiceAwareTrait;
use Structure\Service\Structure\StructureServiceAwareTrait;
use These\Entity\Db\These;
use UnicaenApp\Service\EntityManagerAwareTrait;
use Webmozart\Assert\Assert;

class StructuresFieldset extends Fieldset implements InputFilterProviderInterface
{
    use EtablissementServiceAwareTrait;
    use StructureServiceAwareTrait;
    use EntityManagerAwareTrait;

    private array $etablissements;
    private array $ecolesDoctorales;
    private array $unitesRecherche;

    public function setEtablissements(array $etablissements): void
    {
        $options = [];
        foreach ($etablissements as $etablissement) {
            $sigle = $etablissement->getStructure()?->getSigle() ? " (".$etablissement->getStructure()->getSigle().")" : null;
            $options[$etablissement->getId()] = $etablissement->getStructure()?->getLibelle() . $sigle;
        }
        $this->etablissements = $options;
    }

    public function setEcolesDoctorales(array $ecolesDoctorales): void
    {
        $options = [];

        foreach ($ecolesDoctorales as $ecole) {
            $sigle = $ecole->getStructure()?->getCode() ? " (".$ecole->getStructure()->getCode().")" : null;
            $options[$ecole->getId()] = $ecole->getStructure()?->getLibelle() . $sigle;
        }
        $this->ecolesDoctorales = $options;
    }

    public function setUnitesRecherche(array $unitesRecherche): void
    {
        Assert::allIsInstanceOf($unitesRecherche, UniteRecherche::class);
        $this->unitesRecherche = $unitesRecherche;
    }

    public function prepareElement(FormInterface $form): void
    {
        /** @var These $these */
        $these = $this->getObject();
        $estModifiable = !$these->getSource()->getImportable();

        $this->get('etablissement')->setAttribute('disabled', !$estModifiable);
        $this->get('uniteRecherche')->setAttribute('disabled', !$estModifiable);
        $this->get('ecoleDoctorale')->setAttribute('disabled', !$estModifiable);

        parent::prepareElement($form); // TODO: Change the autogenerated stub
    }

    public function init()
    {
        $this->add([
            'type' => Hidden::class,
            'name' => 'id',
        ]);

        $this->add([
            'type' => ObjectSelect::class,
            'name' => 'etablissement',
            'options' => [
                'label' => 'Établissement : *',
                'target_class' => Etablissement::class,
                'value_options' => $this->etablissements,
            ],
            'attributes' => [
                'id' => 'etablissement',
                'class' => 'selectpicker show-menu-arrow',
                'title' => "Sélectionner l'établissement",
                'data-live-search' => 'true',
            ],
        ]);

        $this->add([
            'type' => ObjectSelect::class,
            'name' => 'uniteRecherche',
            'options' => [
                'label' => 'Unité de recherche : *',
                'target_class' => UniteRecherche::class,
                'value_options' => UniteRecherche::toValueOptions($this->unitesRecherche),
            ],
            'attributes' => [
                'id' => 'unite-recherche',
                'class' => 'selectpicker show-menu-arrow',
                'title' => "Sélectionner l'unité de recherche",
                'data-live-search' => 'true',
            ],
        ]);

        $this->add([
            'type' => ObjectSelect::class,
            'name' => 'ecoleDoctorale',
            'options' => [
                'label' => 'École doctorale : *',
                'target_class' => EcoleDoctorale::class,
                'value_options' => $this->ecolesDoctorales,
            ],
            'attributes' => [
                'id' => 'ecole-doctorale',
                'data-live-search' => 'true',
                'class' => 'selectpicker show-menu-arrow',
                'title' => "Sélectionner l'école doctorale"
            ],
        ]);
    }

    /**
     * @inheritDoc
     */
    public function getInputFilterSpecification()
    {
        /** @var These $these */
        $these = $this->getObject();
        $estModifiable = !$these->getSource()->getImportable();
        return [
            'uniteRecherche' => [
                'required' => $estModifiable,
                'validators' => [
                    [
                        'name' => NotEmpty::class,
                        'options' => [
                            'messages' => [
                                NotEmpty::IS_EMPTY => 'Veuillez sélectionner une unité de recherche.',
                            ],
                        ],
                    ],
                ],
            ],
            'ecoleDoctorale' => [
                'required' => $estModifiable,
                'validators' => [
                    [
                        'name' => NotEmpty::class,
                        'options' => [
                            'messages' => [
                                NotEmpty::IS_EMPTY => 'Veuillez sélectionner une école doctorale.',
                            ],
                        ],
                    ],
                ],
            ],
            'etablissement' => [
                'required' => $estModifiable,
                'validators' => [
                    [
                        'name' => NotEmpty::class,
                        'options' => [
                            'messages' => [
                                NotEmpty::IS_EMPTY => 'Veuillez sélectionner un établissement.',
                            ],
                        ],
                    ],
                ],
            ],
        ];
    }
}