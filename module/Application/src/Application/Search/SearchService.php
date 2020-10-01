<?php

namespace Application\Search;

use Application\Search\Filter\SearchFilter;
use Application\Search\Filter\SelectSearchFilter;
use Application\Search\Sorter\SearchSorter;
use Doctrine\ORM\QueryBuilder;

abstract class SearchService implements SearchServiceInterface
{
    /**
     * @var bool
     */
    protected $unpopulatedOptions = false;

    /**
     * @var SearchFilter[]
     */
    protected $filters = [];

    /**
     * @var SearchSorter[]
     */
    protected $sorters = [];

    /**
     * @var SearchSorter
     */
    protected $defaultSorter;

    /**
     * Initialisation nécessaires, ex: ajouts des filtres, des trieurs.
     */
    abstract public function init();

    /**
     * @param SearchFilter $filter
     * @return self
     */
    public function addFilter(SearchFilter $filter)
    {
        $this->filters[$filter->getName()] = $filter;

        return $this;
    }

    /**
     * @param SearchFilter[] $filters
     * @return self
     */
    public function addFilters(array $filters)
    {
        foreach ($filters as $filter) {
            $this->addFilter($filter);
        }

        return $this;
    }

    /**
     * @param SearchSorter $sorter
     * @return self
     */
    public function addSorter(SearchSorter $sorter)
    {
        $this->sorters[$sorter->getName()] = $sorter;

        if ($sorter->isDefault()) {
            $this->defaultSorter = $sorter;
        }

        return $this;
    }

    /**
     * @param SearchSorter[] $sorters
     * @return self
     */
    public function addSorters(array $sorters)
    {
        foreach ($sorters as $sorter) {
            $this->addSorter($sorter);
        }

        return $this;
    }

    /**
     * @return self
     */
    public function initFiltersWithUnpopulatedOptions()
    {
        $filterValueOptions = [];
        foreach ($this->filters as $filterName => $filter) {
            $filterValueOptions[$filterName] = [];
        }

        $this->initFiltersArray($filterValueOptions);

        $this->unpopulatedOptions = true;

        return $this;
    }

    /**
     * Retourne la liste des filtres.
     *
     * @return SearchFilter[]
     */
    public function getFilters()
    {
        return $this->filters;
    }

    /**
     * @return self
     */
    public function initFilters()
    {
//        if (! $this->unpopulatedOptions/* && ! empty($this->filters)*/) {
//            return $this;
//        }

        $filterValueOptions = [];
        foreach ($this->filters as $filterName => $filter) {
            if ($filter instanceof SelectSearchFilter) {
                $filterValueOptions[$filterName] = $this->fetchValueOptionsForSelectFilter($filter);
            } else {
                $filterValueOptions[$filterName] = [];
            }
        }

        $this->initFiltersArray($filterValueOptions);

        $this->unpopulatedOptions = false;

        return $this;
    }

    /**
     * @param SelectSearchFilter $filter
     * @return array
     */
    abstract protected function fetchValueOptionsForSelectFilter(SelectSearchFilter $filter);

    /**
     * @param array $valueOptions
     * @param array $attributes
     */
    protected function initFiltersArray(array $valueOptions, array $attributes = [])
    {
        foreach ($this->filters as $filterName => $filter) {
            $filter->setAttributes($attributes[$filterName] ?? []);
            if ($filter instanceof SelectSearchFilter) {
                $filter->setOptions($valueOptions[$filterName] ?? []);
            }
        }
    }

    /**
     * @param array $queryParams
     * @return self
     */
    public function processQueryParams(array $queryParams)
    {
        foreach ($this->filters as $filter) {
            $filter->processQueryParams($queryParams);
        }
        foreach ($this->sorters as $sorter) {
            $sorter->processQueryParams($queryParams);
        }

        return $this;
    }

    /**
     * @param $name
     * @return string|null
     */
    public function getFilterValueByName($name)
    {
        if (isset($this->filters[$name])) {
            return $this->filters[$name]->getValue();
        }

        return null;
    }

    /**
     * @param string $name
     * @param array  $queryParams
     * @return string
     */
    private function paramFromQueryParams($name, array $queryParams)
    {
        if (! array_key_exists($name, $queryParams)) {
            // null <=> paramètre absent
            return null;
        }

        // NB: '' <=> "Tous"

        return $queryParams[$name];
    }

    /**
     * @param array $queryParams
     * @return bool
     */
    public function updateQueryParamsWithDefaultFilters(array &$queryParams)
    {
        $updated = false;

        foreach ($this->filters as $filterName => $filter) {
            $defaultValue = $filter->getDefaultValue();
            if ($defaultValue === null) {
                continue;
            }
            $queryParamValue = $this->paramFromQueryParams($filterName, $queryParams); // NB: null <=> filtre absent
            if ($queryParamValue === null) {
                $queryParams = array_merge($queryParams, [$filterName => $defaultValue]);
                $updated = true;
            }
        }

        return $updated;
    }

    /**
     * @param array $queryParams
     * @return bool
     */
    public function updateQueryParamsWithDefaultSorters(array &$queryParams)
    {
        if ($this->defaultSorter === null) {
            return false;
        }

        $updated = false;

        $sort = $this->paramFromQueryParams('sort', $queryParams);

        // Si aucun tri n'est présent, on trie par date de 1ere inscription
        if ($sort === null || $sort === '') {
            $queryParams = array_merge($queryParams, [
                'sort' => $this->defaultSorter->getName(),
                'direction' => $this->defaultSorter->getDirection(),
            ]);
            $updated = true;
        }

        return $updated;
    }

    /**
     * @return QueryBuilder
     */
    public function getQueryBuilder()
    {
        $qb = $this->createQueryBuilder();

        foreach ($this->filters as $filter) {
            $filter->applyToQueryBuilder($qb);
        }

        foreach ($this->sorters as $sorter) {
            $sorter->applyToQueryBuilder($qb);
        }

        return $qb;
    }

    /**
     * @return QueryBuilder
     */
    abstract protected function createQueryBuilder();
}