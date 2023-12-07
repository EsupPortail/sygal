<?php

namespace Structure\Entity\Db;

use Application\Entity\Db\Role;
use Application\Search\Filter\SearchFilterValueInterface;
use Doctrine\Common\Collections\ArrayCollection;
use Substitution\Entity\Db\SubstitutionAwareEntityInterface;
use Substitution\Entity\Db\SubstitutionAwareEntityTrait;
use UnicaenApp\Entity\HistoriqueAwareInterface;
use UnicaenApp\Entity\HistoriqueAwareTrait;
use UnicaenDbImport\Entity\Db\Interfaces\SourceAwareInterface;
use UnicaenDbImport\Entity\Db\Traits\SourceAwareTrait;

/**
 * Etablissement
 */
class Etablissement implements
    StructureConcreteInterface,
    HistoriqueAwareInterface,
    SourceAwareInterface,
    SearchFilterValueInterface,
    SubstitutionAwareEntityInterface
{
    use HistoriqueAwareTrait;
    use SourceAwareTrait;
    use StructureAwareTrait;
    use SubstitutionAwareEntityTrait;

    const SOURCE_CODE_ETABLISSEMENT_INCONNU = 'ETAB_INCONNU';

    const CODE_TOUT_ETABLISSEMENT_CONFONDU = 'Tous';

    protected $id;
    protected ?string $emailAssistance = null;
    protected ?string $emailBibliotheque = null;
    protected ?string $emailDoctorat = null;
    protected $domaine;
    protected $theses;
    protected $doctorants;
    protected $roles;

    /**
     * @var string
     */
    private $sourceCode;

    /**
     * @var bool
     */
    protected $estMembre = false;

    /**
     * @var bool
     */
    protected $estAssocie = false;

    /**
     * @var bool
     */
    protected $estInscription = false;

    /**
     * @var bool
     */
    protected $estComue = false;

    /**
     * @var bool
     */
    protected bool $estCed = false;

    /**
     * Etablissement constructor.
     */
    public function __construct()
    {
        $this->structure = new Structure();
        $this->substitues = new ArrayCollection();
    }

    /**
     * Etablissement prettyPrint
     * @return string
     */
    public function __toString()
    {
        return $this->structure->getLibelle();
    }

    /**
     * @return int
     */
    public function getId()
    {
        return $this->id;
    }

    /**
     * @return string
     */
    public function getCode(): string
    {
        return $this->structure->getCode();
    }

    /**
     * Set sourceCode
     *
     * @param string $sourceCode
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
    public function getSourceCode(): ?string
    {
        return $this->sourceCode;
    }

    /**
     * @return string|null
     */
    public function getEmailAssistance(): ?string
    {
        return $this->emailAssistance;
    }

    /**
     * @param string|null $emailAssistance
     * @return self
     */
    public function setEmailAssistance(?string $emailAssistance): self
    {
        $this->emailAssistance = $emailAssistance;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getEmailBibliotheque(): ?string
    {
        return $this->emailBibliotheque;
    }

    /**
     * @param string|null $emailBibliotheque
     * @return self
     */
    public function setEmailBibliotheque(?string $emailBibliotheque): self
    {
        $this->emailBibliotheque = $emailBibliotheque;
        return $this;
    }

    /**
     * @return string|null
     */
    public function getEmailDoctorat(): ?string
    {
        return $this->emailDoctorat;
    }

    /**
     * @param string|null $emailDoctorat
     * @return self
     */
    public function setEmailDoctorat(?string $emailDoctorat): self
    {
        $this->emailDoctorat = $emailDoctorat;
        return $this;
    }

    /**
     * @return string
     */
    public function getDomaine()
    {
        return $this->domaine;
    }

    /**
     * @param string $domaine
     */
    public function setDomaine($domaine)
    {
        $this->domaine = $domaine;
    }

    /**
     * @return bool
     */
    public function estMembre()
    {
        return $this->estMembre;
    }

    /**
     * @param bool $estMembre
     * @return Etablissement
     */
    public function setEstMembre($estMembre)
    {
        $this->estMembre = $estMembre;

        return $this;
    }

    /**
     * @return bool
     */
    public function estAssocie()
    {
        return $this->estAssocie;
    }

    /**
     * @param bool $estAssocie
     * @return Etablissement
     */
    public function setEstAssocie($estAssocie)
    {
        $this->estAssocie = $estAssocie;

        return $this;
    }

    /**
     * @return bool
     */
    public function estInscription()
    {
        return $this->estInscription;
    }

    /**
     * @param bool $estInscription
     * @return Etablissement
     */
    public function setEstInscription($estInscription)
    {
        $this->estInscription = $estInscription;
        return $this;
    }

    /**
     * @return bool
     */
    public function estComue()
    {
        return $this->estComue;
    }

    /**
     * @param bool $estComue
     * @return Etablissement
     */
    public function setEstComue($estComue)
    {
        $this->estComue = $estComue;

        return $this;
    }

    public function estCed(): bool
    {
        return $this->estCed;
    }

    public function setEstCed(bool $estCed): self
    {
        $this->estCed = $estCed;
        return $this;
    }

    /**
     * @return mixed
     */
    public function getTheses()
    {
        return $this->theses;
    }

    /**
     * @return mixed
     */
    public function getDoctorants()
    {
        return $this->doctorants;
    }

    /**
     * @return Role[]
     */
    public function getRoles()
    {
        return $this->roles;
    }

    /**
     * Teste si cet établissement est le pseudo-établissement "Tout établissement confondu".
     *
     * @return bool
     */
    public function estToutEtablissementConfondu()
    {
        return $this->structure->getCode() === self::CODE_TOUT_ETABLISSEMENT_CONFONDU;
    }

    /**
     * @inheritDoc
     */
    public function createSearchFilterValueOption(): array
    {
        $label = ($this->structure->getCode() ?: $this->structure->getSigle()) ?: $this->structure->getLibelle();
        if ($this->structure->estFermee()) {
            $label .= "&nbsp; FERMÉ";
        }

        return ['value' => $this->getSourceCode(), 'label' => $label];
    }
}