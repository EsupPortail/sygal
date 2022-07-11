<?php

namespace Structure\Form;

use Laminas\Form\Element\Checkbox;
use Laminas\Form\Element\Text;
use Laminas\InputFilter\InputFilterProviderInterface;
use Structure\Entity\Db\UniteRecherche;

class UniteRechercheForm extends StructureForm implements InputFilterProviderInterface
{
    /**
     * NB: hydrateur injecté par la factory
     */
    public function init()
    {
        parent::init();

        $this->setObject(new UniteRecherche());

        $this->add((new Text('RNSR'))
            ->setLabel("Identifiant RNSR :")
        );

        $this->add((new Checkbox('estFerme'))
            ->setLabel("Unité de recherche fermée")
        );
    }

    /**
     * @inheritDoc
     */
    public function getInputFilterSpecification(): array
    {
        return array_merge(parent::getInputFilterSpecification(), [
            'RNSR' => [
                'name' => 'RNSR',
                'required' => false,
            ],
        ]);
    }
}