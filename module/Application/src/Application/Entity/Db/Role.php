<?php

namespace Application\Entity\Db;

use Doctrine\Common\Collections\ArrayCollection;
use Structure\Entity\Db\StructureAwareTrait;
use Structure\Entity\Db\TypeStructure;
use UnicaenApp\Entity\HistoriqueAwareInterface;
use UnicaenApp\Entity\HistoriqueAwareTrait;
use UnicaenAuth\Entity\Db\AbstractRole;
use UnicaenDbImport\Entity\Db\Interfaces\SourceAwareInterface;
use UnicaenDbImport\Entity\Db\Traits\SourceAwareTrait;

/**
 * An entity that represents a role.
 */
class Role extends AbstractRole implements SourceAwareInterface, HistoriqueAwareInterface
{
    use SourceAwareTrait;
    use HistoriqueAwareTrait;
    use StructureAwareTrait;

    // Memento: (&(eduPersonAffiliation=member)(eduPersonAffiliation=student)(eduPersonAffiliation=researcher))

    const CODE_DOCTORANT = 'DOCTORANT';
    const CODE_ADMIN = 'ADMIN';
    const CODE_ADMIN_TECH = 'ADMIN_TECH';
    const CODE_BU = 'BU';
    const CODE_BDD = 'BDD';

    const CODE_DIRECTEUR_THESE = 'D';
    const CODE_CODIRECTEUR_THESE = 'K';
    const CODE_MEMBRE_JURY = 'M';
    const CODE_PRESIDENT_JURY = 'P';
    const CODE_RAPPORTEUR_JURY = 'R';
    const CODE_RAPPORTEUR_ABSENT = 'A';
    const CODE_CO_ENCADRANT = 'B';
    const CODE_RESP_ED = 'RESP_ED';
    const CODE_GEST_ED = 'GEST_ED';
    const CODE_RESP_UR = 'RESP_UR';
    const CODE_GEST_UR = 'GEST_UR';
    const CODE_OBSERVATEUR_COMUE = "OBSERV";

    const ROLE_ID_USER = 'user'; // ROLE_ID du rôle correspondant à un utilisateur authentifié avec succès.

    // @todo NB: maintenant il y le code étab concaténé au "role_id"
    const ROLE_ID_DOCTORANT = "Doctorant";
    const ROLE_ID_BUREAU_DES_DOCTORATS = "Maison du doctorat";
    const ROLE_ID_BIBLIO_UNIV = "Bibliothèque universitaire";

    const ROLE_ID_ECOLE_DOCT = "École doctorale";
    const ROLE_ID_UNITE_RECH = "Unité de recherche";
    const LIBELLE_PRESIDENT = "Président du jury";
    const CODE_OBSERVATEUR = "Observateur";

    const ROLE_ID_ADMISSION_CANDIDAT = "Candidat";
    const CODE_ADMISSION_CANDIDAT = "ADMISSION_CANDIDAT";
    const ROLE_ID_ADMISSION_DIRECTEUR_THESE = "Potentiel directeur de thèse";
    const CODE_ADMISSION_DIRECTEUR_THESE = "ADMISSION_DIRECTEUR_THESE";

    const ROLE_ID_ADMISSION_CODIRECTEUR_THESE = "Potentiel co-directeur de thèse";
    const CODE_ADMISSION_CODIRECTEUR_THESE = "ADMISSION_CODIRECTEUR_THESE";

    /**
     * Convertit la collection d'entités spécifiée en un tableau d'options injectable dans un <select>.
     *
     * @param object[] $entities
     * @return string[] id => libelle
     */
    static public function toValueOptions(iterable $entities): array
    {
        $options = [];
        foreach ($entities as $entity) {
            $options[$entity->getId()] = (string) $entity;
        }

        return $options;
    }

    /**
     * @var string
     */
    protected $sourceCode;

    /**
     * @var TypeStructure
     */
    protected $typeStructureDependant;

    /**
     * @var string Code unique *au sein d'un établissement*.
     */
    protected $code;

    /**
     * @var string
     */
    protected $libelle;

    /**
     * @var bool
     */
    private $attributionAutomatique = false;

    /**
     * @var bool
     */
    private $theseDependant = false;

    /**
     * @var int
     */
    private $ordreAffichage;

    /** @var ArrayCollection */
    private $profils;

    public function __construct()
    {
        parent::__construct();
        $this->profils = new ArrayCollection();
    }

    /**
     * @return bool
     */
    public function isDoctorant(): bool
    {
        return $this->getCode() === self::CODE_DOCTORANT;
    }

    /**
     * @return bool
     */
    public function isDirecteurThese(): bool
    {
        return $this->getCode() === self::CODE_DIRECTEUR_THESE;
    }

    /**
     * @return bool
     */
    public function isActeurDeThese(): bool
    {
        return in_array($this->getCode(), [
            self::CODE_DIRECTEUR_THESE,
            self::CODE_CODIRECTEUR_THESE,
            self::CODE_MEMBRE_JURY,
            self::CODE_PRESIDENT_JURY,
            self::CODE_RAPPORTEUR_JURY,
            self::CODE_RAPPORTEUR_ABSENT,
            self::CODE_CO_ENCADRANT,
        ]);
    }

    /**
     * @return bool
     */
    public function isCoEncadrant(): bool
    {
        return $this->getCode() === self::CODE_CO_ENCADRANT;
    }

    /**
     * @return string
     */
    public function getCode()
    {
        return $this->code;
    }

    /**
     * @param string $code
     * @return Role
     */
    public function setCode($code)
    {
        $this->code = $code;

        return $this;
    }

    /**
     * @return string
     */
    public function getLibelle()
    {
        return $this->libelle;
    }

    /**
     * @param string $libelle
     * @return Role
     */
    public function setLibelle($libelle)
    {
        $this->libelle = $libelle;

        return $this;
    }

    /**
     * Set sourceCode
     *
     * @param string $sourceCode
     *
     * @return self
     */
    public function setSourceCode($sourceCode)
    {
        $this->sourceCode = $sourceCode;

        return $this;
    }

    /**
     * Get sourceCode
     *
     * @return string
     */
    public function getSourceCode()
    {
        return $this->sourceCode;
    }

    /**
     * @return bool
     */
    public function getAttributionAutomatique()
    {
        return $this->attributionAutomatique;
    }

    /**
     * @param bool $attributionAutomatique
     * @return self
     */
    public function setAttributionAutomatique($attributionAutomatique = true)
    {
        $this->attributionAutomatique = $attributionAutomatique;

        return $this;
    }

    /**
     * @return bool
     */
    public function isTheseDependant()
    {
        return $this->theseDependant;
    }

    /**
     * @param bool $theseDependant
     * @return self
     */
    public function setTheseDependant($theseDependant = true)
    {
        $this->theseDependant = $theseDependant;

        return $this;
    }

    /**
     * @return TypeStructure
     */
    public function getTypeStructureDependant()
    {
        return $this->typeStructureDependant;
    }

    /**
     * @param TypeStructure $typeStructureDependant
     * @return self
     */
    public function setTypeStructureDependant(TypeStructure $typeStructureDependant)
    {
        $this->typeStructureDependant = $typeStructureDependant;

        return $this;
    }

    /**
     * @return bool
     */
    public function isEtablissementDependant(): bool
    {
        return ($tsd = $this->getTypeStructureDependant()) && $tsd->isEtablissement();
    }

    /**
     * @return bool
     */
    public function isEcoleDoctoraleDependant(): bool
    {
        return ($tsd = $this->getTypeStructureDependant()) && $tsd->isEcoleDoctorale();
    }

    /**
     * @return bool
     */
    public function isUniteRechercheDependant(): bool
    {
        return ($tsd = $this->getTypeStructureDependant()) && $tsd->isUniteRecherche();
    }

    /**
     * @return bool
     */
    public function isStructureDependant(): bool
    {
        return $this->getTypeStructureDependant() !== null;
    }

    /**
     * Retourne une chaîne de caractères utilisée pour trier les rôles ;
     * l'astuce consiste à concaténer cette valeur aux autres critères de tri.
     *
     * @return string
     */
    public function getOrdreAffichage()
    {
        return $this->ordreAffichage;
    }

    /**
     * @param string $ordreAffichage
     * @return self
     */
    public function setOrdreAffichage($ordreAffichage)
    {
        $this->ordreAffichage = (string)$ordreAffichage;

        return $this;
    }

    /**
     * @return string
     */
    public function __toString()
    {
        $str = $this->getLibelle();

        if ($this->getStructure() !== null) {
            $str .= " " . $this->getStructure()->getSigle();
        }

        return $str;
    }

    /** return ArrayCollection */
    public function getProfils()
    {
        return $this->profils;
    }

    /**
     * @param Profil $profil
     * @return Role
     */
    public function addProfil($profil)
    {
        $this->profils->add($profil);
        return $this;
    }

    /**
     * @param Profil $profil
     * @return Role
     */
    public function removeProfil($profil)
    {
        $this->profils->removeElement($profil);
        return $this;
    }

    /**
     * @param Profil $profil
     * @return boolean
     */
    public function hasProfil($profil)
    {
        return $this->profils->contains($profil);
    }

    public function estUsurpable(): bool
    {
        return in_array($this->getCode(), [
            Role::CODE_DIRECTEUR_THESE,
            Role::CODE_CODIRECTEUR_THESE,
            Role::CODE_PRESIDENT_JURY,
            Role::CODE_RAPPORTEUR_JURY,
            Role::CODE_RAPPORTEUR_ABSENT,
        ]);
    }
}