<?php

namespace Formation\Form\Module;

use Zend\Form\Element\Button;
use Zend\Form\Element\Text;
use Zend\Form\Element\Textarea;
use Zend\Form\Form;
use Zend\InputFilter\Factory;

class ModuleForm extends Form {

    public function init()
    {
        //titre
        $this->add([
            'type' => Text::class,
            'name' => 'libelle',
            'options' => [
                'label' => "Libellé du module de formation :",
            ],
            'attributes' => [
                'id' => 'libelle',
                'class' => 'required',
            ],
        ]);
        //description
        $this->add([
            'type' => Textarea::class,
            'name' => 'description',
            'options' => [
                'label' => "Complément d'information à propos du module :",
            ],
            'attributes' => [
                'id' => 'description',
                'class' => 'tinymce',
            ],
        ]);
        //titre
        $this->add([
            'type' => Text::class,
            'name' => 'lien',
            'options' => [
                'label' => "Lien vers la fiche du module :",
            ],
            'attributes' => [
                'id' => 'lien',
                'class' => 'required',
            ],
        ]);

        //submit
        $this->add([
            'type' => Button::class,
            'name' => 'bouton',
            'options' => [
                'label' => '<i class="fas fa-save"></i> Enregistrer',
                'label_options' => [
                    'disable_html_escape' => true,
                ],
            ],
            'attributes' => [
                'type' => 'submit',
                'class' => 'btn btn-primary',

            ],
        ]);

        $this->setInputFilter((new Factory())->createInputFilter([
            'libelle'       => [ 'required' => true, ],
            'description'   => [ 'required' => false, ],
            'lien'          => [ 'required' => false, ],
        ]));
    }
}