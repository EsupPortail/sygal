<?php

namespace Admission\Hydrator\Etudiant;

use Admission\Entity\Db\Etudiant;
use Application\Entity\Db\Pays;
use Application\Service\Pays\PaysServiceAwareTrait;
use Doctrine\Laminas\Hydrator\DoctrineObject;

/**
 * @author Unicaen
 */
class EtudiantHydrator extends DoctrineObject
{
    use PaysServiceAwareTrait;

    public function extract(object $object): array
    {
        /** @var Etudiant $object */
        $data = parent::extract($object);

        if (array_key_exists($key = 'paysNaissance', $data) && $data[$key] instanceof Pays) {
            $data["paysNaissance"] = $data["paysNaissance"]->getId();
        }

        if (array_key_exists($key = 'adresseCodePays', $data) && $data[$key] instanceof Pays) {
            $data["adresseCodePays"] = $data["adresseCodePays"]->getId();
        }

        if (array_key_exists($key = 'nationalite', $data) && $data[$key] instanceof Pays) {
            $data["nationalite"] = $data["nationalite"]->getId();
        }

        $data['verificationEtudiant'] = $object->getVerificationEtudiant()->first();

        return $data;
    }

    public function hydrate(array $data, object $object): object
    {
        $data["adresseCodePays"] = !empty($data["adresseCodePays"]) ? $data["adresseCodePays"] : null;
        /** @var Pays $pays */
        $pays = $data["adresseCodePays"] ? $this->paysService->getRepository()->find($data["adresseCodePays"]) : null;
        //si le pays sélectionné est la France
        if($pays && $pays->getLibelle() === "France"){
            //on met à vide la ville étrangère potentielle
            $data["adresseCpVilleEtrangere"] = null;
        }else if($pays && $pays->getLibelle() !== "France") {
            $data["adresseCodePostal"] = null;
            $data["adresseCodeCommune"] = null;
            $data["adresseNomCommune"] = null;
        }
        //Si aucune ville française de naissance n'est renseignée, on met à vide le code INSEE précédemment renseigné
        if(empty($data["libelleCommuneNaissance"]) || empty($data["codeCommuneNaissance"])){
            $data["codeCommuneNaissance"] = null;
        }
        //Si aucune ville française n'est renseignée, on met à vide le code postal et le code INSEE précédemment renseigné
        if(empty($data["adresseNomCommune"]) || empty($data["adresseCodeCommune"])){
            $data["adresseCodePostal"] = null;
            $data["adresseCodeCommune"] = null;
        }

        $data["paysNaissance"] = !empty($data["paysNaissance"]) ? $data["paysNaissance"] : null;
        $data["nationalite"] = !empty($data["nationalite"]) ? $data["nationalite"] : null;

        //Si la case niveauEtude n'est pas le diplôme national, on met à null les valeurs des champs reliés
        if(isset($data["niveauEtude"]) && $data["niveauEtude"] != 1){
            $data["intituleDuDiplomeNational"] = null;
            $data["anneeDobtentionDiplomeNational"] = null;
            $data["etablissementDobtentionDiplomeNational"] = null;
        }

        //Si la case niveauEtude n'est pas la case Autre, on met à null les valeurs des champs reliés
        if(isset($data["niveauEtude"]) && $data["niveauEtude"] != 2){
            $data["typeDiplomeAutre"] = null;
            $data["intituleDuDiplomeAutre"] = null;
            $data["anneeDobtentionDiplomeAutre"] = null;
            $data["etablissementDobtentionDiplomeAutre"] = null;
        }

        if (isset($data['verificationEtudiant']) && !is_array($data['verificationEtudiant'])) {
            $data['verificationEtudiant'] = [$data['verificationEtudiant']];
        }

        return parent::hydrate($data, $object); // TODO: Change the autogenerated stub
    }

}