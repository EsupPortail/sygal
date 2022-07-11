<?php

namespace Structure\Form;

use Laminas\Form\Element\Checkbox;
use Laminas\Form\Element\Text;
use Laminas\InputFilter\InputFilterProviderInterface;
use Structure\Entity\Db\EcoleDoctorale;

class EcoleDoctoraleForm extends StructureForm implements InputFilterProviderInterface
{
    /**
     * NB: hydrateur injecté par la factory
     */
    public function init()
    {
        parent::init();

        $this->setObject(new EcoleDoctorale());

        $this->add((new Text('theme'))
            ->setLabel("Thème :")
        );

        $this->add((new Text('offre-these'))
            ->setLabel("Lien vers l'offre de thèse :")
        );

        $this->add((new Checkbox('estFerme'))
            ->setLabel("École doctorale fermée")
        );
    }

    /**
     * @inheritDoc
     */
    public function getInputFilterSpecification(): array
    {
        return array_merge(parent::getInputFilterSpecification(), [
            'theme' => [
                'name' => 'theme',
                'required' => false,
            ],
            'offre-these' => [
                'name' => 'offre-these',
                'required' => false,
            ],
            'estFerme' => [
                'name' => 'estFerme',
                'required' => false,
            ],
        ]);
    }
}