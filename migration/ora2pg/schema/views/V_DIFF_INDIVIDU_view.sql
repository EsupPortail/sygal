-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_individu (source_code, source_id, operation, u_type, u_supann_id, u_civilite, u_nom_usuel, u_nom_patronymique, u_prenom1, u_prenom2, u_prenom3, u_email, u_date_naissance, u_nationalite, s_type, s_supann_id, s_civilite, s_nom_usuel, s_nom_patronymique, s_prenom1, s_prenom2, s_prenom3, s_email, s_date_naissance, s_nationalite, d_type, d_supann_id, d_civilite, d_nom_usuel, d_nom_patronymique, d_prenom1, d_prenom2, d_prenom3, d_email, d_date_naissance, d_nationalite) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'update'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= LOCALTIMESTAMP)) then 'undelete'
            when(s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'delete' end as operation,

            CASE WHEN d.TYPE <> s.TYPE OR (d.TYPE IS NULL AND s.TYPE IS NOT NULL) OR (d.TYPE IS NOT NULL AND s.TYPE IS NULL) THEN 1 ELSE 0 END as U_TYPE,
    CASE WHEN d.SUPANN_ID <> s.SUPANN_ID OR (d.SUPANN_ID IS NULL AND s.SUPANN_ID IS NOT NULL) OR (d.SUPANN_ID IS NOT NULL AND s.SUPANN_ID IS NULL) THEN 1 ELSE 0 END as U_SUPANN_ID,
    CASE WHEN d.CIVILITE <> s.CIVILITE OR (d.CIVILITE IS NULL AND s.CIVILITE IS NOT NULL) OR (d.CIVILITE IS NOT NULL AND s.CIVILITE IS NULL) THEN 1 ELSE 0 END as U_CIVILITE,
    CASE WHEN d.NOM_USUEL <> s.NOM_USUEL OR (d.NOM_USUEL IS NULL AND s.NOM_USUEL IS NOT NULL) OR (d.NOM_USUEL IS NOT NULL AND s.NOM_USUEL IS NULL) THEN 1 ELSE 0 END as U_NOM_USUEL,
    CASE WHEN d.NOM_PATRONYMIQUE <> s.NOM_PATRONYMIQUE OR (d.NOM_PATRONYMIQUE IS NULL AND s.NOM_PATRONYMIQUE IS NOT NULL) OR (d.NOM_PATRONYMIQUE IS NOT NULL AND s.NOM_PATRONYMIQUE IS NULL) THEN 1 ELSE 0 END as U_NOM_PATRONYMIQUE,
    CASE WHEN d.PRENOM1 <> s.PRENOM1 OR (d.PRENOM1 IS NULL AND s.PRENOM1 IS NOT NULL) OR (d.PRENOM1 IS NOT NULL AND s.PRENOM1 IS NULL) THEN 1 ELSE 0 END as U_PRENOM1,
    CASE WHEN d.PRENOM2 <> s.PRENOM2 OR (d.PRENOM2 IS NULL AND s.PRENOM2 IS NOT NULL) OR (d.PRENOM2 IS NOT NULL AND s.PRENOM2 IS NULL) THEN 1 ELSE 0 END as U_PRENOM2,
    CASE WHEN d.PRENOM3 <> s.PRENOM3 OR (d.PRENOM3 IS NULL AND s.PRENOM3 IS NOT NULL) OR (d.PRENOM3 IS NOT NULL AND s.PRENOM3 IS NULL) THEN 1 ELSE 0 END as U_PRENOM3,
    CASE WHEN d.EMAIL <> s.EMAIL OR (d.EMAIL IS NULL AND s.EMAIL IS NOT NULL) OR (d.EMAIL IS NOT NULL AND s.EMAIL IS NULL) THEN 1 ELSE 0 END as U_EMAIL,
    CASE WHEN d.DATE_NAISSANCE <> s.DATE_NAISSANCE OR (d.DATE_NAISSANCE IS NULL AND s.DATE_NAISSANCE IS NOT NULL) OR (d.DATE_NAISSANCE IS NOT NULL AND s.DATE_NAISSANCE IS NULL) THEN 1 ELSE 0 END as U_DATE_NAISSANCE,
    CASE WHEN d.NATIONALITE <> s.NATIONALITE OR (d.NATIONALITE IS NULL AND s.NATIONALITE IS NOT NULL) OR (d.NATIONALITE IS NOT NULL AND s.NATIONALITE IS NULL) THEN 1 ELSE 0 END as U_NATIONALITE,

            s.TYPE AS S_TYPE,
    s.SUPANN_ID AS S_SUPANN_ID,
    s.CIVILITE AS S_CIVILITE,
    s.NOM_USUEL AS S_NOM_USUEL,
    s.NOM_PATRONYMIQUE AS S_NOM_PATRONYMIQUE,
    s.PRENOM1 AS S_PRENOM1,
    s.PRENOM2 AS S_PRENOM2,
    s.PRENOM3 AS S_PRENOM3,
    s.EMAIL AS S_EMAIL,
    s.DATE_NAISSANCE AS S_DATE_NAISSANCE,
    s.NATIONALITE AS S_NATIONALITE,

            d.TYPE AS D_TYPE,
    d.SUPANN_ID AS D_SUPANN_ID,
    d.CIVILITE AS D_CIVILITE,
    d.NOM_USUEL AS D_NOM_USUEL,
    d.NOM_PATRONYMIQUE AS D_NOM_PATRONYMIQUE,
    d.PRENOM1 AS D_PRENOM1,
    d.PRENOM2 AS D_PRENOM2,
    d.PRENOM3 AS D_PRENOM3,
    d.EMAIL AS D_EMAIL,
    d.DATE_NAISSANCE AS D_DATE_NAISSANCE,
    d.NATIONALITE AS D_NATIONALITE

         FROM INDIVIDU d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_INDIVIDU s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select "SOURCE_CODE","SOURCE_ID","OPERATION","U_TYPE","U_SUPANN_ID","U_CIVILITE","U_NOM_USUEL","U_NOM_PATRONYMIQUE","U_PRENOM1","U_PRENOM2","U_PRENOM3","U_EMAIL","U_DATE_NAISSANCE","U_NATIONALITE","S_TYPE","S_SUPANN_ID","S_CIVILITE","S_NOM_USUEL","S_NOM_PATRONYMIQUE","S_PRENOM1","S_PRENOM2","S_PRENOM3","S_EMAIL","S_DATE_NAISSANCE","S_NATIONALITE","D_TYPE","D_SUPANN_ID","D_CIVILITE","D_NOM_USUEL","D_NOM_PATRONYMIQUE","D_PRENOM1","D_PRENOM2","D_PRENOM3","D_EMAIL","D_DATE_NAISSANCE","D_NATIONALITE" from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_TYPE+U_SUPANN_ID+U_CIVILITE+U_NOM_USUEL+U_NOM_PATRONYMIQUE+U_PRENOM1+U_PRENOM2+U_PRENOM3+U_EMAIL+U_DATE_NAISSANCE+U_NATIONALITE);

