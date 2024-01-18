<?php

namespace Admission\Entity;

use Admission\Entity\Db\Admission;
use Admission\Entity\Db\AdmissionAvis;
use Admission\Entity\Db\AdmissionValidation;
use Admission\Filter\AdmissionOperationsFormatter;

class AdmissionRecapitulatifDataTemplate
{
    private Admission $admission;
    private array $operations = [];

    public function getOperations(): array
    {
        return $this->operations;
    }
    public function setOperations(array $operations): void
    {
        $this->operations = $operations;
    }

    public function getAdmission(): Admission
    {
        return $this->admission;
    }

    public function setAdmission(Admission $admission): void
    {
        $this->admission = $admission;
    }

    /**
     * @noinspection PhpUnusedMethod (il s'agit d'une méthode utilisée par les macros)
     */
    public function getOperationstoHtmlArray()
    {
        $operations = $this->getOperations();
        $operationsFormatter = new AdmissionOperationsFormatter();
        $operationsToPrint["header"] = ["Opération", "Acteur", "Date de l'opération"];
        foreach($operations as $operation){
            if ($operation instanceof AdmissionValidation) {
                $libelleOperation = $operation->getTypeValidation()->getLibelle();
            }elseif ($operation instanceof AdmissionAvis) {
                $libelleOperation = $operation->getTypeToString();
            }
            $operationsToPrint["operations"][] = [
                "libelle" => $libelleOperation,
                "createur" => $operation->getId() !== null ? $operation->getHistoCreateur() : "/",
                "dateCreation" => $operation->getId() !== null ? $operation->getHistoCreation()->format(\Application\Constants::DATETIME_FORMAT) : "/"
            ];
        }
        return $operationsFormatter->htmlifyOperations($operationsToPrint);
    }
}