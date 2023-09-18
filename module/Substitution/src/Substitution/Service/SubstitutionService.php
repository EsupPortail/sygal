<?php

namespace Substitution\Service;

use Doctrine\DBAL\Result;
use UnicaenApp\Service\EntityManagerAwareTrait;

class SubstitutionService
{
    use EntityManagerAwareTrait;

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsIndividu(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsIndividu() . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsIndividu(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsIndividu()
        );
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsDoctorant(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsDoctorant() . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsDoctorant(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsDoctorant()
        );
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsStructure(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsStructureAbstraite() . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsStructure(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsStructureAbstraite()
        );
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsEtablissement(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsStructureConcrete('etablissement') . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsEtablissement(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsStructureConcrete('etablissement')
        );
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsEcoleDoct(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsStructureConcrete('ecole_doct') . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsEcoleDoct(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsStructureConcrete('ecole_doct')
        );
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function countAllSubstitutionsUniteRech(): int
    {
        return $this->entityManager->getConnection()->executeQuery(
            'select count(*) nb from (' . $this->generateSqlToFindAllSubstitutionsStructureConcrete('unite_rech') . ') tmp'
        )->fetchOne();
    }

    /**
     * @throws \Doctrine\DBAL\Exception
     */
    public function findAllSubstitutionsUniteRech(): Result
    {
        return $this->entityManager->getConnection()->executeQuery(
            $this->generateSqlToFindAllSubstitutionsStructureConcrete('unite_rech')
        );
    }


    //------------------------------------------------------------------------------------------------------------
    // SQL substitutions
    //------------------------------------------------------------------------------------------------------------

    public function generateSqlToFindAllSubstitutionsIndividu(): string
    {
        return <<<EOT
select distinct
    x.id as to_id,
    x.substit_update_enabled update_enabled,
    x.nom_patronymique as to_nom_patronymique,
    x.prenom1 as to_prenom1,
    date(x.date_naissance) as to_date_naissance,
    sub.npd,
    string_agg(sub.from_id::varchar, '|') as from_ids,
    string_agg(coalesce(px.npd_force, ''), '|') as npd_forces
from individu_substit sub
    join pre_individu px on px.id = sub.from_id
    join individu x on x.id = sub.to_id
where sub.histo_destruction is null
group by
    x.id,
    x.nom_patronymique,
    x.prenom1,
    x.date_naissance,
    sub.npd
order by x.nom_patronymique, x.prenom1
EOT;
    }

    public function generateSqlToFindAllSubstitutionsDoctorant(): string
    {
        return <<<EOT
select distinct
    x.id as to_id,
    x.substit_update_enabled update_enabled,
    x.ine as to_ine,
    sub.npd,
    string_agg(sub.from_id::varchar, '|') as from_ids,
    string_agg(coalesce(px.npd_force, ''), '|') as npd_forces
from doctorant_substit sub
    join pre_doctorant px on px.id = sub.from_id
    join doctorant x on x.id = sub.to_id
where sub.histo_destruction is null
group by
    x.id,
    x.ine,
    sub.npd
order by x.ine
EOT;
    }

    public function generateSqlToFindAllSubstitutionsStructureAbstraite(): string
    {
        return <<<EOT
select distinct
    x.id as to_id,
    x.substit_update_enabled update_enabled,
    x.code as to_code,
    sub.npd,
    string_agg(sub.from_id::varchar, '|') as from_ids,
    string_agg(coalesce(px.npd_force, ''), '|') as npd_forces
from structure_substit sub
    join pre_structure px on px.id = sub.from_id
    join structure x on x.id = sub.to_id
where sub.histo_destruction is null
group by
    x.id,
    x.code,
    sub.npd
order by x.code
EOT;
    }

    private function generateSqlToFindAllSubstitutionsStructureConcrete(string $type): string
    {
        return <<<EOT
select distinct
    x.id as to_id,
    x.substit_update_enabled update_enabled,
    xs.code as to_code,
    sub.npd,
    string_agg(sub.from_id::varchar, '|') as from_ids,
    string_agg(coalesce(px.npd_force, ''), '|') as npd_forces
from {$type}_substit sub
    join pre_{$type} px on px.id = sub.from_id
    join {$type} x on x.id = sub.to_id
    join structure xs on xs.id = x.structure_id
where sub.histo_destruction is null
group by
    x.id,
    xs.code,
    sub.npd
order by x.id
EOT;
    }
}