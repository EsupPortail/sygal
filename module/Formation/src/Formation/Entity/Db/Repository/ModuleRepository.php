<?php

namespace Formation\Entity\Db\Repository;

use Doctrine\ORM\EntityRepository;
use Doctrine\ORM\QueryBuilder;
use Formation\Entity\Db\Module;
use Formation\Entity\Db\Session;
use UnicaenApp\Service\EntityManagerAwareTrait;
use Zend\Mvc\Controller\AbstractActionController;

class ModuleRepository extends EntityRepository
{
    use EntityManagerAwareTrait;

    /**
     * @param AbstractActionController $controller
     * @param string $param
     * @return Module|null
     */
    public function getRequestedModule(AbstractActionController $controller, string $param = 'module') : ?Module
    {
        $id = $controller->params()->fromRoute($param);
        /** @var Module|null */
        $module = $this->find($id);
        return $module;
    }

    /**
     * @param array $filtres
     * @return Module[]
     */
    public function fetchModulesWithFiltres(array $filtres) : array
    {
        $alias = 'module';
        $qb = $this->createQueryBuilder($alias);

        if ($filtres['site']) {
            $qb = $qb->leftJoin($alias.'.site', 'site')->addSelect('site')
                ->andWhere('site.code = :site')
                ->setParameter('site', $filtres['site']);
        }
        if ($filtres['responsable']) {
            $qb = $qb->leftJoin($alias.'.responsable', 'responsable')->addSelect('responsable')
                ->andWhere('responsable.id = :responsable')
                ->setParameter('responsable', $filtres['responsable']);
        }
        if ($filtres['structure']) {
            $qb = $qb->leftJoin($alias.'.typeStructure', 'structure')->addSelect('structure')
                ->andWhere('structure.id = :structure')
                ->setParameter('structure', $filtres['structure']);
        }
        if ($filtres['modalite']) {
            $qb = $qb->andWhere($alias.'.modalite = :modalite')
                ->setParameter('modalite', $filtres['modalite']);
        }
        if ($filtres['libelle']) {
            $libelle = '%' . strtolower($filtres['libelle']) . '%';
            $qb = $qb->andWhere('lower('.$alias.'.libelle) like :libelle')
                ->setParameter('libelle', $libelle);
        }

        $result = $qb->getQuery()->getResult();
        return $result;
    }

    public function fetchIndexMax(Module $module) : int
    {
        $index = 0;
        /** @var Session $session */
        foreach ($module->getSessions() as $session) {
            $index = max($session->getIndex(), $index);
        }
        return $index;
    }

    public function fetchListeResponsable() : array
    {
        /** @var Module[] $modules */
        $modules = $this->findAll();
        $responsables = [];

        foreach ($modules as $module) {
            $responsable = $module->getResponsable();
            if ($responsable) {
                $responsables[$responsable->getId()] = $responsable;
            }
        }
        return $responsables;
    }

    public function fetchListeStructures() : array
    {
        /** @var Module[] $modules */
        $modules = $this->findAll();
        $structures = [];

        foreach ($modules as $module) {
            $structure = $module->getTypeStructure();
            if ($structure) {
                $structures[$structure->getId()] = $structure;
            }
        }
        return $structures;
    }
}