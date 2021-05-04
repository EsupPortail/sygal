-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_etablissement (source_code, source_id, operation, u_code, u_structure_id, s_code, s_structure_id, d_code, d_structure_id) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'update'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= LOCALTIMESTAMP)) then 'undelete'
            when(s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'delete' end as operation,

            CASE WHEN d.CODE <> s.CODE OR (d.CODE IS NULL AND s.CODE IS NOT NULL) OR (d.CODE IS NOT NULL AND s.CODE IS NULL) THEN 1 ELSE 0 END as U_CODE,
    CASE WHEN d.STRUCTURE_ID <> s.STRUCTURE_ID OR (d.STRUCTURE_ID IS NULL AND s.STRUCTURE_ID IS NOT NULL) OR (d.STRUCTURE_ID IS NOT NULL AND s.STRUCTURE_ID IS NULL) THEN 1 ELSE 0 END as U_STRUCTURE_ID,

            s.CODE AS S_CODE,
    s.STRUCTURE_ID AS S_STRUCTURE_ID,

            d.CODE AS D_CODE,
    d.STRUCTURE_ID AS D_STRUCTURE_ID

         FROM ETABLISSEMENT d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_ETABLISSEMENT s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select SOURCE_CODE,SOURCE_ID,OPERATION,U_CODE,U_STRUCTURE_ID,S_CODE,S_STRUCTURE_ID,D_CODE,D_STRUCTURE_ID from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_CODE+U_STRUCTURE_ID);
