<?php

namespace Soutenance\Provider\Template;

class MailTemplates
{
    const TRANSMETTRE_DOCUMENTS_DIRECTION = "TRANSMETTRE_DOCUMENTS_DIRECTION";

    /** GESTION DES VALIDATIONS ***************************************************************************************/
    const PROPOSITION_REFUS = 'PROPOSITION_REFUS';
    const PROPOSITION_SUPPRESSION = 'PROPOSITION_SUPPRESSION';
    const SOUTENANCE_TOUS_AVIS_RENDUS = 'SOUTENANCE_TOUS_AVIS_RENDUS';
    const SOUTENANCE_TOUS_AVIS_RENDUS_DIRECTION = 'SOUTENANCE_TOUS_AVIS_RENDUS_DIRECTION';
    const SOUTENANCE_VALIDATION_ANNULEE = 'SOUTENANCE_VALIDATION_ANNULEE';
    const SOUTENANCE_VALIDATION_ACTEUR_DIRECT = 'SOUTENANCE_VALIDATION_ACTEUR_DIRECT';
    const SOUTENANCE_VALIDATION_DEMANDE_UR = 'SOUTENANCE_VALIDATION_DEMANDE_UR';
    const SOUTENANCE_VALIDATION_DEMANDE_ED = 'SOUTENANCE_VALIDATION_DEMANDE_ED';
    const SOUTENANCE_VALIDATION_DEMANDE_ETAB = 'SOUTENANCE_VALIDATION_DEMANDE_ETAB';
    const VALIDATION_SOUTENANCE_AVANT_PRESOUTENANCE = 'VALIDATION_SOUTENANCE_AVANT_PRESOUTENANCE';
    const VALIDATION_SOUTENANCE_ENVOI_PRESOUTENANCE = 'VALIDATION_SOUTENANCE_ENVOI_PRESOUTENANCE';

    /** ENGAGEMENT D'IMPARTIALITE *************************************************************************************/
    const DEMANDE_ENGAGEMENT_IMPARTIALITE = 'DEMANDE_ENGAGEMENT_IMPARTIALITE';
    const SIGNATURE_ENGAGEMENT_IMPARTIALITE = 'SIGNATURE_ENGAGEMENT_IMPARTIALITE';
    const REFUS_ENGAGEMENT_IMPARTIALITE = 'REFUS_ENGAGEMENT_IMPARTIALITE';
    const ANNULATION_ENGAGEMENT_IMPARTIALITE = 'ANNULATION_ENGAGEMENT_IMPARTIALITE';

    const CONNEXION_RAPPORTEUR = 'CONNEXION_RAPPORTEUR';
    const DEMANDE_PRERAPPORT = 'DEMANDE_PRERAPPORT';
    const DEMANDE_RAPPORT_SOUTENANCE = 'DEMANDE_RAPPORT_SOUTENANCE';
    const SOUTENANCE_AVIS_FAVORABLE = 'SOUTENANCE_AVIS_FAVORABLE';
    const SOUTENANCE_AVIS_DEFAVORABLE = 'SOUTENANCE_AVIS_DEFAVORABLE';
    const SOUTENANCE_FEU_VERT = 'SOUTENANCE_FEU_VERT';
    const SOUTENANCE_STOP_DEMARCHE = 'SOUTENANCE_STOP_DEMARCHE';
    const SOUTENANCE_CONVOCATION_DOCTORANT = 'SOUTENANCE_CONVOCATION_DOCTORANT';
    const SOUTENANCE_CONVOCATION_MEMBRE = 'SOUTENANCE_CONVOCATION_MEMBRE';

    /** DEMANDE DOSSIERS */
    const DEMANDE_ADRESSE_EXACTE = 'DEMANDE_ADRESSE_EXACTE';
}