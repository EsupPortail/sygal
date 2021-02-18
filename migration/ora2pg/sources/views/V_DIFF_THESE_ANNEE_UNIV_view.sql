-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_these_annee_univ (source_code, source_id, operation, u_these_id, u_annee_univ, s_these_id, s_annee_univ, d_these_id, d_annee_univ) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case 
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > SYSDATE)) then 'update'
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= SYSDATE)) then 'undelete'
            when (s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > SYSDATE)) then 'delete' end as operation,

            CASE WHEN d.THESE_ID <> s.THESE_ID OR (d.THESE_ID IS NULL AND s.THESE_ID IS NOT NULL) OR (d.THESE_ID IS NOT NULL AND s.THESE_ID IS NULL) THEN 1 ELSE 0 END as U_THESE_ID,
    CASE WHEN d.ANNEE_UNIV <> s.ANNEE_UNIV OR (d.ANNEE_UNIV IS NULL AND s.ANNEE_UNIV IS NOT NULL) OR (d.ANNEE_UNIV IS NOT NULL AND s.ANNEE_UNIV IS NULL) THEN 1 ELSE 0 END as U_ANNEE_UNIV,

            s.THESE_ID AS S_THESE_ID,
    s.ANNEE_UNIV AS S_ANNEE_UNIV,

            d.THESE_ID AS D_THESE_ID,
    d.ANNEE_UNIV AS D_ANNEE_UNIV

         FROM THESE_ANNEE_UNIV d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_THESE_ANNEE_UNIV s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select "SOURCE_CODE","SOURCE_ID","OPERATION","U_THESE_ID","U_ANNEE_UNIV","S_THESE_ID","S_ANNEE_UNIV","D_THESE_ID","D_ANNEE_UNIV" from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_THESE_ID+U_ANNEE_UNIV);

