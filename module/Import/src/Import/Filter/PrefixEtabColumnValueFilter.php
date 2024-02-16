<?php

namespace Import\Filter;

use Application\SourceCodeStringHelper;
use InvalidArgumentException;
use UnicaenDbImport\Filter\ColumnValue\AbstractColumnValueFilter;

/**
 * Filtre permettant de préfixer une valeur de colonne/attribut par le code établissement,
 * ex : 'UMR6211' devient 'UCN::UMR6211'.
 */
class PrefixEtabColumnValueFilter extends AbstractColumnValueFilter
{
    const PARAM_CODE_ETABLISSEMENT = 'code_etablissement';

    /**
     * Liste des noms de colonnes/attributs à transformer.
     *
     * @var string[]
     */
    protected array $columns = [];

    protected ?string $codeEtablissement = null;
    protected SourceCodeStringHelper $sourceCodeStringHelper;


    public function __construct(array $params = [])
    {
        parent::__construct($params);

        $this->sourceCodeStringHelper = new SourceCodeStringHelper();
    }

    public function __toString(): string
    {
        return "Préfixage par le code établissement des colonnes/attributs suivants : " . PHP_EOL .
            implode(', ', $this->columns);
    }

    public function setParams(array $params): void
    {
        if (array_key_exists('columns', $params)) {
            $this->columns = (array) $params['columns'];
        }
        if (array_key_exists(self::PARAM_CODE_ETABLISSEMENT, $params)) {
            $this->codeEtablissement = $params[self::PARAM_CODE_ETABLISSEMENT];
        }

        parent::setParams($params);
    }

    public function filter($value)
    {
        if ($value === null) {
            return null;
        }

        if ($this->codeEtablissement === null) {
            throw new InvalidArgumentException(sprintf(
                "Le paramètre '%s' n'a pas été fourni",
                self::PARAM_CODE_ETABLISSEMENT
            ));
        }

        if (in_array($this->columnName, $this->columns)) {
            $value = $this->sourceCodeStringHelper->addPrefixTo($value, $this->codeEtablissement);
        }

        return $value;
    }
}