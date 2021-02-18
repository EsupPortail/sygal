-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_titre_acces (source_code, source_id, operation, u_these_id, u_titre_acces_interne_externe, u_libelle_titre_acces, u_type_etb_titre_acces, u_libelle_etb_titre_acces, u_code_dept_titre_acces, u_code_pays_titre_acces, s_these_id, s_titre_acces_interne_externe, s_libelle_titre_acces, s_type_etb_titre_acces, s_libelle_etb_titre_acces, s_code_dept_titre_acces, s_code_pays_titre_acces, d_these_id, d_titre_acces_interne_externe, d_libelle_titre_acces, d_type_etb_titre_acces, d_libelle_etb_titre_acces, d_code_dept_titre_acces, d_code_pays_titre_acces) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case 
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > SYSDATE)) then 'update'
            when (s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= SYSDATE)) then 'undelete'
            when (s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > SYSDATE)) then 'delete' end as operation,

            CASE WHEN d.THESE_ID <> s.THESE_ID OR (d.THESE_ID IS NULL AND s.THESE_ID IS NOT NULL) OR (d.THESE_ID IS NOT NULL AND s.THESE_ID IS NULL) THEN 1 ELSE 0 END as U_THESE_ID,
    CASE WHEN d.TITRE_ACCES_INTERNE_EXTERNE <> s.TITRE_ACCES_INTERNE_EXTERNE OR (d.TITRE_ACCES_INTERNE_EXTERNE IS NULL AND s.TITRE_ACCES_INTERNE_EXTERNE IS NOT NULL) OR (d.TITRE_ACCES_INTERNE_EXTERNE IS NOT NULL AND s.TITRE_ACCES_INTERNE_EXTERNE IS NULL) THEN 1 ELSE 0 END as U_TITRE_ACCES_INTERNE_EXTERNE,
    CASE WHEN d.LIBELLE_TITRE_ACCES <> s.LIBELLE_TITRE_ACCES OR (d.LIBELLE_TITRE_ACCES IS NULL AND s.LIBELLE_TITRE_ACCES IS NOT NULL) OR (d.LIBELLE_TITRE_ACCES IS NOT NULL AND s.LIBELLE_TITRE_ACCES IS NULL) THEN 1 ELSE 0 END as U_LIBELLE_TITRE_ACCES,
    CASE WHEN d.TYPE_ETB_TITRE_ACCES <> s.TYPE_ETB_TITRE_ACCES OR (d.TYPE_ETB_TITRE_ACCES IS NULL AND s.TYPE_ETB_TITRE_ACCES IS NOT NULL) OR (d.TYPE_ETB_TITRE_ACCES IS NOT NULL AND s.TYPE_ETB_TITRE_ACCES IS NULL) THEN 1 ELSE 0 END as U_TYPE_ETB_TITRE_ACCES,
    CASE WHEN d.LIBELLE_ETB_TITRE_ACCES <> s.LIBELLE_ETB_TITRE_ACCES OR (d.LIBELLE_ETB_TITRE_ACCES IS NULL AND s.LIBELLE_ETB_TITRE_ACCES IS NOT NULL) OR (d.LIBELLE_ETB_TITRE_ACCES IS NOT NULL AND s.LIBELLE_ETB_TITRE_ACCES IS NULL) THEN 1 ELSE 0 END as U_LIBELLE_ETB_TITRE_ACCES,
    CASE WHEN d.CODE_DEPT_TITRE_ACCES <> s.CODE_DEPT_TITRE_ACCES OR (d.CODE_DEPT_TITRE_ACCES IS NULL AND s.CODE_DEPT_TITRE_ACCES IS NOT NULL) OR (d.CODE_DEPT_TITRE_ACCES IS NOT NULL AND s.CODE_DEPT_TITRE_ACCES IS NULL) THEN 1 ELSE 0 END as U_CODE_DEPT_TITRE_ACCES,
    CASE WHEN d.CODE_PAYS_TITRE_ACCES <> s.CODE_PAYS_TITRE_ACCES OR (d.CODE_PAYS_TITRE_ACCES IS NULL AND s.CODE_PAYS_TITRE_ACCES IS NOT NULL) OR (d.CODE_PAYS_TITRE_ACCES IS NOT NULL AND s.CODE_PAYS_TITRE_ACCES IS NULL) THEN 1 ELSE 0 END as U_CODE_PAYS_TITRE_ACCES,

            s.THESE_ID AS S_THESE_ID,
    s.TITRE_ACCES_INTERNE_EXTERNE AS S_TITRE_ACCES_INTERNE_EXTERNE,
    s.LIBELLE_TITRE_ACCES AS S_LIBELLE_TITRE_ACCES,
    s.TYPE_ETB_TITRE_ACCES AS S_TYPE_ETB_TITRE_ACCES,
    s.LIBELLE_ETB_TITRE_ACCES AS S_LIBELLE_ETB_TITRE_ACCES,
    s.CODE_DEPT_TITRE_ACCES AS S_CODE_DEPT_TITRE_ACCES,
    s.CODE_PAYS_TITRE_ACCES AS S_CODE_PAYS_TITRE_ACCES,

            d.THESE_ID AS D_THESE_ID,
    d.TITRE_ACCES_INTERNE_EXTERNE AS D_TITRE_ACCES_INTERNE_EXTERNE,
    d.LIBELLE_TITRE_ACCES AS D_LIBELLE_TITRE_ACCES,
    d.TYPE_ETB_TITRE_ACCES AS D_TYPE_ETB_TITRE_ACCES,
    d.LIBELLE_ETB_TITRE_ACCES AS D_LIBELLE_ETB_TITRE_ACCES,
    d.CODE_DEPT_TITRE_ACCES AS D_CODE_DEPT_TITRE_ACCES,
    d.CODE_PAYS_TITRE_ACCES AS D_CODE_PAYS_TITRE_ACCES

         FROM TITRE_ACCES d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_TITRE_ACCES s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select "SOURCE_CODE","SOURCE_ID","OPERATION","U_THESE_ID","U_TITRE_ACCES_INTERNE_EXTERNE","U_LIBELLE_TITRE_ACCES","U_TYPE_ETB_TITRE_ACCES","U_LIBELLE_ETB_TITRE_ACCES","U_CODE_DEPT_TITRE_ACCES","U_CODE_PAYS_TITRE_ACCES","S_THESE_ID","S_TITRE_ACCES_INTERNE_EXTERNE","S_LIBELLE_TITRE_ACCES","S_TYPE_ETB_TITRE_ACCES","S_LIBELLE_ETB_TITRE_ACCES","S_CODE_DEPT_TITRE_ACCES","S_CODE_PAYS_TITRE_ACCES","D_THESE_ID","D_TITRE_ACCES_INTERNE_EXTERNE","D_LIBELLE_TITRE_ACCES","D_TYPE_ETB_TITRE_ACCES","D_LIBELLE_ETB_TITRE_ACCES","D_CODE_DEPT_TITRE_ACCES","D_CODE_PAYS_TITRE_ACCES" from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_THESE_ID+U_TITRE_ACCES_INTERNE_EXTERNE+U_LIBELLE_TITRE_ACCES+U_TYPE_ETB_TITRE_ACCES+U_LIBELLE_ETB_TITRE_ACCES+U_CODE_DEPT_TITRE_ACCES+U_CODE_PAYS_TITRE_ACCES);

