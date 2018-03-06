<?php

namespace Application\Service\UniteRecherche;

use Application\Entity\Db\Individu;
use Application\Entity\Db\Repository\UniteRechercheRepository;
use Application\Entity\Db\Role;
use Application\Entity\Db\UniteRecherche;
use Application\Entity\Db\UniteRechercheIndividu;
use Application\Entity\Db\Utilisateur;
use Application\Service\BaseService;
use Doctrine\ORM\OptimisticLockException;
use UnicaenApp\Exception\RuntimeException;

/**
 * @method UniteRecherche|null findOneBy(array $criteria, array $orderBy = null)
 */
class UniteRechercheService extends BaseService
{
    /**
     * @return UniteRechercheRepository
     */
    public function getRepository()
    {
        /** @var UniteRechercheRepository $repo */
        $repo = $this->entityManager->getRepository(UniteRecherche::class);

        return $repo;
    }

    /**
     * @return UniteRecherche[]
     */
    public function getUnitesRecherches() {
        /** @var UniteRecherche[] $unites */
        $unites = $this->getRepository()->findAll();
        return $unites;
    }

    /**
     * @param int $id
     * @return null|UniteRecherche
     */
    public function getUniteRechercheById($id) {
        /** @var UniteRecherche $unite */
        $unite = $this->getRepository()->findOneBy(["id" => $id]);
        return $unite;
    }

    /**
     * Historise une ED.
     *
     * @param UniteRecherche $ur
     * @param Utilisateur    $destructeur
     */
    public function deleteSoftly(UniteRecherche $ur, Utilisateur $destructeur)
    {
        $ur->historiser($destructeur);

        $this->flush($ur);
    }

    public function undelete(UniteRecherche $ur)
    {
        $ur->dehistoriser();

        $this->flush($ur);
    }

    public function create(UniteRecherche $ur, Utilisateur $createur)
    {
        $ur->setHistoCreateur($createur);

        $this->persist($ur);
        $this->flush($ur);

        return $ur;
    }

    public function update(UniteRecherche $ur)
    {
        $this->flush($ur);

        return $ur;
    }

    public function setLogo(UniteRecherche $unite, $cheminLogo)
    {
        $unite->setCheminLogo($cheminLogo);
        $this->flush($unite);

        return $unite;
    }

    public function deleteLogo(UniteRecherche $unite)
    {
        $unite->setCheminLogo(null);
        $this->flush($unite);

        return $unite;
    }

    private function persist(UniteRecherche $ur)
    {
        $this->getEntityManager()->persist($ur);
        $this->getEntityManager()->persist($ur->getStructure());
    }

    private function flush(UniteRecherche $ur)
    {
        try {
            $this->getEntityManager()->flush($ur);
            $this->getEntityManager()->flush($ur->getStructure());
        } catch (OptimisticLockException $e) {
            throw new RuntimeException("Erreur lors de l'enregistrement de l'UR", null, $e);
        }
    }


}