<?php

namespace Individu\Service\Search;

use Application\Search\Filter\SearchFilter;
use Application\Search\Filter\TextSearchFilter;
use Application\Search\SearchService;
use Application\Search\Sorter\SearchSorter;
use Doctrine\ORM\QueryBuilder;
use Individu\Service\IndividuServiceAwareTrait;

class IndividuSearchService extends SearchService
{
    use IndividuServiceAwareTrait;

    /**
     * @inheritDoc
     */
    public function createQueryBuilder(): QueryBuilder
    {
        $qb = $this->individuService->getRepository()->createQueryBuilder('i');
        $qb
            ->addSelect('u')
            ->leftJoin('i.utilisateurs', 'u')
            ->addSelect('cu')
            ->leftJoin('i.complements', 'cu');

        return $qb;
    }

    public function init()
    {
        // filtre textuel
        $textFilter = new TextSearchFilter("Recherche textuelle", 'text');
        $textFilter->setAttributes(['title' => "Recherche sur le nom d'usage, le prénom ou l'adresse électronique"]);
        $textFilter->setQueryBuilderApplier(function(SearchFilter $filter, QueryBuilder $qb) {
            $individus = $this->individuService->getRepository()->findByText($filter->getValue());
            $individusIds = array_map(fn(array $individu) => $individu['id'], $individus);
            $qb->andWhere($qb->expr()->in('i.id', $individusIds));
        });
        $this->addFilter($textFilter);

        $this->addSorters([
            (new SearchSorter("Id", 'id')),
            (new SearchSorter("Nom d'usage", 'nomUsuel'))->setIsDefault()
        ]);
    }
}