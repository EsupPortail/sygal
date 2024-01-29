<?php

namespace Structure\Entity\Db\Repository;

use Application\Entity\Db\Repository\DefaultEntityRepository;
use Application\QueryBuilder\DefaultQueryBuilder;
use Structure\Entity\Db\EcoleDoctorale;

class EcoleDoctoraleRepository extends DefaultEntityRepository
{
    use StructureConcreteRepositoryTrait;

    public function createQueryBuilder($alias, $indexBy = null): DefaultQueryBuilder
    {
        $qb = $this->_createQueryBuilder($alias);

        $qb
            ->orderBy('structure.code')
            ->addOrderBy('structure.libelle');

        return $qb;
    }

    /**
     * @return EcoleDoctorale[]
     */
    public function findAll(): array
    {
        $qb = $this->createQueryBuilder("ed");

        return $this->_findAll($qb);
    }

    public function findByStructureId($structureId, bool $nonHistorise = true): ?EcoleDoctorale
    {
        $qb = $this->createQueryBuilder("ed");
        if ($nonHistorise) {
            $qb->andWhereNotHistorise('ur');
        }

        return $this->_findByStructureId($qb, $structureId);
    }

    /**
     * @return array[]
     */
    public function findByText(string $term) : array
    {
        $qb = $this->createQueryBuilder("ed");

        return $this->_findByText($qb, $term);
    }
}