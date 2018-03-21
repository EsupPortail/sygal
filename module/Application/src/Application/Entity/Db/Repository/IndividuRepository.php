<?php

namespace Application\Entity\Db\Repository;

use Application\Entity\Db\Etablissement;
use Application\Entity\Db\Individu;
use Doctrine\DBAL\DBALException;
use UnicaenApp\Exception\RuntimeException;
use UnicaenApp\Util;

class IndividuRepository extends DefaultEntityRepository
{
    /**
     * @param string $empId
     * @param Etablissement $etablissement
     * @return Individu
     */
    public function findOneByEmpIdAndEtab($empId, Etablissement $etablissement)
    {
        /** @var Individu $i */
        $i = $this->findOneBy(['sourceCode' => $etablissement->getCode() . '::' . $empId]);

        return $i;
    }

    /**
     * Recherche d'individu, en SQL pure.
     *
     * @param string  $text
     * @param integer $limit
     *
     * @return array
     */
    public function findByText($text, $limit = 100)
    {
        if (strlen($text) < 2) return [];

        $text = Util::reduce($text);
        $criteres = explode(' ', $text);

        $sql = sprintf('SELECT * FROM INDIVIDU i JOIN INDIVIDU_RECH ir on ir.id = i.id WHERE rownum <= %s ', (int)$limit);
        $sqlCri  = [];

        foreach ($criteres as $c) {
            $sqlCri[] = "ir.haystack LIKE LOWER(q'[%" . $c . "%]')"; // q'[] : double les quotes
        }
        $sqlCri = implode(' AND ', $sqlCri);

        $orc = [];
        if ($sqlCri !== '') {
            $orc[] = '(' . $sqlCri . ')';
        }
        $orc = implode(' OR ', $orc);

        $sql .= ' AND (' . $orc . ') ';

        try {
            $stmt = $this->getEntityManager()->getConnection()->executeQuery($sql);
        } catch (DBALException $e) {
            throw new RuntimeException("Erreur rencontrée dans la requête de recherche d'individu", null, $e);
        }

        return $stmt->fetchAll();
    }
}