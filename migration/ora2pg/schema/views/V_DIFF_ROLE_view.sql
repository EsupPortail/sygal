-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_role (source_code, source_id, operation, u_libelle, u_code, u_role_id, u_these_dep, u_structure_id, u_type_structure_dependant_id, s_libelle, s_code, s_role_id, s_these_dep, s_structure_id, s_type_structure_dependant_id, d_libelle, d_code, d_role_id, d_these_dep, d_structure_id, d_type_structure_dependant_id) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'update'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= LOCALTIMESTAMP)) then 'undelete'
            when(s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'delete' end as operation,

            CASE WHEN d.LIBELLE <> s.LIBELLE OR (d.LIBELLE IS NULL AND s.LIBELLE IS NOT NULL) OR (d.LIBELLE IS NOT NULL AND s.LIBELLE IS NULL) THEN 1 ELSE 0 END as U_LIBELLE,
    CASE WHEN d.CODE <> s.CODE OR (d.CODE IS NULL AND s.CODE IS NOT NULL) OR (d.CODE IS NOT NULL AND s.CODE IS NULL) THEN 1 ELSE 0 END as U_CODE,
    CASE WHEN d.ROLE_ID <> s.ROLE_ID OR (d.ROLE_ID IS NULL AND s.ROLE_ID IS NOT NULL) OR (d.ROLE_ID IS NOT NULL AND s.ROLE_ID IS NULL) THEN 1 ELSE 0 END as U_ROLE_ID,
    CASE WHEN d.THESE_DEP <> s.THESE_DEP OR (d.THESE_DEP IS NULL AND s.THESE_DEP IS NOT NULL) OR (d.THESE_DEP IS NOT NULL AND s.THESE_DEP IS NULL) THEN 1 ELSE 0 END as U_THESE_DEP,
    CASE WHEN d.STRUCTURE_ID <> s.STRUCTURE_ID OR (d.STRUCTURE_ID IS NULL AND s.STRUCTURE_ID IS NOT NULL) OR (d.STRUCTURE_ID IS NOT NULL AND s.STRUCTURE_ID IS NULL) THEN 1 ELSE 0 END as U_STRUCTURE_ID,
    CASE WHEN d.TYPE_STRUCTURE_DEPENDANT_ID <> s.TYPE_STRUCTURE_DEPENDANT_ID OR (d.TYPE_STRUCTURE_DEPENDANT_ID IS NULL AND s.TYPE_STRUCTURE_DEPENDANT_ID IS NOT NULL) OR (d.TYPE_STRUCTURE_DEPENDANT_ID IS NOT NULL AND s.TYPE_STRUCTURE_DEPENDANT_ID IS NULL) THEN 1 ELSE 0 END as U_TYPE_STRUCTURE_DEPENDANT_ID,

            s.LIBELLE AS S_LIBELLE,
    s.CODE AS S_CODE,
    s.ROLE_ID AS S_ROLE_ID,
    s.THESE_DEP AS S_THESE_DEP,
    s.STRUCTURE_ID AS S_STRUCTURE_ID,
    s.TYPE_STRUCTURE_DEPENDANT_ID AS S_TYPE_STRUCTURE_DEPENDANT_ID,

            d.LIBELLE AS D_LIBELLE,
    d.CODE AS D_CODE,
    d.ROLE_ID AS D_ROLE_ID,
    d.THESE_DEP AS D_THESE_DEP,
    d.STRUCTURE_ID AS D_STRUCTURE_ID,
    d.TYPE_STRUCTURE_DEPENDANT_ID AS D_TYPE_STRUCTURE_DEPENDANT_ID

         FROM ROLE d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_ROLE s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select "SOURCE_CODE","SOURCE_ID","OPERATION","U_LIBELLE","U_CODE","U_ROLE_ID","U_THESE_DEP","U_STRUCTURE_ID","U_TYPE_STRUCTURE_DEPENDANT_ID","S_LIBELLE","S_CODE","S_ROLE_ID","S_THESE_DEP","S_STRUCTURE_ID","S_TYPE_STRUCTURE_DEPENDANT_ID","D_LIBELLE","D_CODE","D_ROLE_ID","D_THESE_DEP","D_STRUCTURE_ID","D_TYPE_STRUCTURE_DEPENDANT_ID" from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_LIBELLE+U_CODE+U_ROLE_ID+U_THESE_DEP+U_STRUCTURE_ID+U_TYPE_STRUCTURE_DEPENDANT_ID);

