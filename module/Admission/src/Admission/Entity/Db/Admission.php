<?php
namespace Admission\Entity\Db;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Individu\Entity\Db\Individu;
use UnicaenApp\Entity\HistoriqueAwareInterface;
use UnicaenApp\Entity\HistoriqueAwareTrait;

class Admission implements HistoriqueAwareInterface{

    use HistoriqueAwareTrait;
    /**
     * @var int|null
     */
    private $etatId;

    /**
     * @var int
     */
    private $id;

    /**
     * @var Collection
     */
    private $financement;

    /**
     * @var Collection
     */
    private $etudiant;

    /**
     * @var Collection
     */
    private $inscription;

    /**
     * @var Collection
     */
    private $validation;

    /**
     * @var Collection
     */
    private $document;

    /**
     * @var Individu
     */
    private $individu;

    /**
     * Constructor
     */
    public function __construct()
    {
        $this->financement = new \Doctrine\Common\Collections\ArrayCollection();
        $this->etudiant = new \Doctrine\Common\Collections\ArrayCollection();
        $this->inscription = new \Doctrine\Common\Collections\ArrayCollection();
        $this->validation = new \Doctrine\Common\Collections\ArrayCollection();
        $this->document = new \Doctrine\Common\Collections\ArrayCollection();
    }

    /**
     * Set etatId.
     *
     * @param int|null $etatId
     *
     * @return Admission
     */
    public function setEtatId($etatId = null)
    {
        $this->etatId = $etatId;

        return $this;
    }

    /**
     * Get etatId.
     *
     * @return int|null
     */
    public function getEtatId()
    {
        return $this->etatId;
    }

    /**
     * Get id.
     *
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * Add financement.
     */
    public function addFinancement(Collection $financements): Admission
    {
        foreach ($financements as $f) {
            $this->financement->add($f);
        }

        return $this;
    }

    /**
     * Remove financements.
     */
    public function removeFinancement(Collection $financements): void
    {
        foreach ($financements as $f) {
            $this->financement->removeElement($f);
        }
    }

    /**
     * Get financement.
     *
     * @return Collection
     */
    public function getFinancement()
    {
        return $this->financement;
    }

    /**
     * Add etudiant.
     */
    public function addEtudiant(Collection $etudiants)
    {
        foreach ($etudiants as $e) {
            $this->etudiant->add($e);
        }

        return $this;
    }

    /**
     * Remove etudiant.
     */
    public function removeEtudiant(Collection $etudiants)
    {
        foreach ($etudiants as $e) {
            $this->etudiant->removeElement($e);
        }
    }

    /**
     * Get etudiant.
     *
     * @return Collection
     */
    public function getEtudiant()
    {
        return $this->etudiant;
    }

    /**
     * Add inscriptions.
     */
    public function addInscription(Collection $inscriptions): Admission
    {
        foreach ($inscriptions as $i) {
            $this->inscription->add($i);
        }

        return $this;
    }

    /**
     * Remove inscriptions.
     */
    public function removeInscription(Collection $inscriptions): void
    {
        foreach ($inscriptions as $i) {
            $this->inscription->removeElement($i);
        }
    }

    /**
     * Get inscription.
     *
     * @return Collection
     */
    public function getInscription()
    {
        return $this->inscription;
    }

    /**
     * Add validation.
     */
    public function addValidation(Collection $validations): self
    {
        foreach ($validations as $v) {
            $this->validation->add($v);
        }

        return $this;
    }

    /**
     * Remove validation.
     */
    public function removeValidation(Collection $validations): void
    {
        foreach ($validations as $v) {
            $this->validation->removeElement($v);
        }
    }

    /**
     * Get validation.
     *
     * @return Collection
     */
    public function getValidation()
    {
        return $this->validation;
    }

    /**
     * Add document.
     */
    public function addDocument(Document $document)
    {
        foreach ($document as $d) {
            $this->document->add($d);
        }

        return $this;
    }

    /**
     * Remove document.
     *
     * @param Document $document
     *
     * @return boolean TRUE if this collection contained the specified element, FALSE otherwise.
     */
    public function removeDocument(Document $document)
    {
        foreach ($document as $d) {
            $this->document->removeElement($d);
        }
    }

    /**
     * Get document.
     *
     * @return Collection
     */
    public function getDocument()
    {
        return $this->document;
    }

    /**
     * Set individu.
     *
     * @param Individu|null $individu
     *
     * @return Admission
     */
    public function setIndividu(Individu $individu = null)
    {
        $this->individu = $individu;

        return $this;
    }

    /**
     * Get individu.
     *
     * @return Individu|null
     */
    public function getIndividu()
    {
        return $this->individu;
    }
}
