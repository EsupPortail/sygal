<?php

namespace Soutenance\Form\Confidentialite;

use UnicaenApp\Form\Element\Date;
use Zend\Form\Element\Checkbox;
use Zend\Form\Element\Submit;
use Zend\Form\Form;

class ConfidentialiteForm extends Form {

    public function init()
    {
        $this->add(
            (new Date('date'))
                ->setLabel("Date de fin de confidentialité :")
        );
        $this->add(
            [
                'type' => Checkbox::class,
                'name' => 'huitclos',
                'options' => [
                    'label' => "Soutenance en huit clos",
                ],
                'attributes' => [
                    'id' => 'huitclos',
                ],
            ]
        );

        $this->add((new Submit('submit'))
            ->setValue("Enregister")
            ->setAttribute('class', 'btn btn-primary')
        );
    }
}