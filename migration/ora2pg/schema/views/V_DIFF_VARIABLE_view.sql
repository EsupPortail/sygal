-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_diff_variable (source_code, source_id, operation, u_etablissement_id, u_code, u_description, u_valeur, u_date_deb_validite, u_date_fin_validite, s_etablissement_id, s_code, s_description, s_valeur, s_date_deb_validite, s_date_fin_validite, d_etablissement_id, d_code, d_description, d_valeur, d_date_deb_validite, d_date_fin_validite) AS with diff as (
        SELECT 
            coalesce(s.SOURCE_CODE, d.SOURCE_CODE) SOURCE_CODE,
            coalesce(s.source_id, d.source_id) source_id,

            case
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NULL) then 'insert'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'update'
            when(s.SOURCE_CODE IS NOT NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NOT NULL and d.HISTO_DESTRUCTION <= LOCALTIMESTAMP)) then 'undelete'
            when(s.SOURCE_CODE IS NULL AND d.SOURCE_CODE IS NOT NULL and (d.HISTO_DESTRUCTION IS NULL or d.HISTO_DESTRUCTION > LOCALTIMESTAMP)) then 'delete' end as operation,

            CASE WHEN d.ETABLISSEMENT_ID <> s.ETABLISSEMENT_ID OR (d.ETABLISSEMENT_ID IS NULL AND s.ETABLISSEMENT_ID IS NOT NULL) OR (d.ETABLISSEMENT_ID IS NOT NULL AND s.ETABLISSEMENT_ID IS NULL) THEN 1 ELSE 0 END as U_ETABLISSEMENT_ID,
    CASE WHEN d.CODE <> s.CODE OR (d.CODE IS NULL AND s.CODE IS NOT NULL) OR (d.CODE IS NOT NULL AND s.CODE IS NULL) THEN 1 ELSE 0 END as U_CODE,
    CASE WHEN d.DESCRIPTION <> s.DESCRIPTION OR (d.DESCRIPTION IS NULL AND s.DESCRIPTION IS NOT NULL) OR (d.DESCRIPTION IS NOT NULL AND s.DESCRIPTION IS NULL) THEN 1 ELSE 0 END as U_DESCRIPTION,
    CASE WHEN d.VALEUR <> s.VALEUR OR (d.VALEUR IS NULL AND s.VALEUR IS NOT NULL) OR (d.VALEUR IS NOT NULL AND s.VALEUR IS NULL) THEN 1 ELSE 0 END as U_VALEUR,
    CASE WHEN d.DATE_DEB_VALIDITE <> s.DATE_DEB_VALIDITE OR (d.DATE_DEB_VALIDITE IS NULL AND s.DATE_DEB_VALIDITE IS NOT NULL) OR (d.DATE_DEB_VALIDITE IS NOT NULL AND s.DATE_DEB_VALIDITE IS NULL) THEN 1 ELSE 0 END as U_DATE_DEB_VALIDITE,
    CASE WHEN d.DATE_FIN_VALIDITE <> s.DATE_FIN_VALIDITE OR (d.DATE_FIN_VALIDITE IS NULL AND s.DATE_FIN_VALIDITE IS NOT NULL) OR (d.DATE_FIN_VALIDITE IS NOT NULL AND s.DATE_FIN_VALIDITE IS NULL) THEN 1 ELSE 0 END as U_DATE_FIN_VALIDITE,

            s.ETABLISSEMENT_ID AS S_ETABLISSEMENT_ID,
    s.CODE AS S_CODE,
    s.DESCRIPTION AS S_DESCRIPTION,
    s.VALEUR AS S_VALEUR,
    s.DATE_DEB_VALIDITE AS S_DATE_DEB_VALIDITE,
    s.DATE_FIN_VALIDITE AS S_DATE_FIN_VALIDITE,

            d.ETABLISSEMENT_ID AS D_ETABLISSEMENT_ID,
    d.CODE AS D_CODE,
    d.DESCRIPTION AS D_DESCRIPTION,
    d.VALEUR AS D_VALEUR,
    d.DATE_DEB_VALIDITE AS D_DATE_DEB_VALIDITE,
    d.DATE_FIN_VALIDITE AS D_DATE_FIN_VALIDITE

         FROM VARIABLE d
        JOIN source src ON src.id = d.source_id AND src.importable = 1
        FULL OUTER JOIN SRC_VARIABLE s ON s.source_id = d.source_id AND s.SOURCE_CODE = d.SOURCE_CODE
    )
    select "SOURCE_CODE","SOURCE_ID","OPERATION","U_ETABLISSEMENT_ID","U_CODE","U_DESCRIPTION","U_VALEUR","U_DATE_DEB_VALIDITE","U_DATE_FIN_VALIDITE","S_ETABLISSEMENT_ID","S_CODE","S_DESCRIPTION","S_VALEUR","S_DATE_DEB_VALIDITE","S_DATE_FIN_VALIDITE","D_ETABLISSEMENT_ID","D_CODE","D_DESCRIPTION","D_VALEUR","D_DATE_DEB_VALIDITE","D_DATE_FIN_VALIDITE" from diff
    where operation is not null
    and (operation = 'undelete' or 0 < U_ETABLISSEMENT_ID+U_CODE+U_DESCRIPTION+U_VALEUR+U_DATE_DEB_VALIDITE+U_DATE_FIN_VALIDITE);

