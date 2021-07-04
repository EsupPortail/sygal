-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW src_origine_financement (id, source_code, source_id, code, libelle_court, libelle_long) AS SELECT  NULL                 AS id,
       tmp.SOURCE_CODE      AS SOURCE_CODE,
       src.ID               AS SOURCE_ID,
       COD_OFI              as CODE,
       LIC_OFI              as LIBELLE_COURT,
       LIB_OFI              as LIBELLE_LONG
 FROM TMP_ORIGINE_FINANCEMENT tmp
         JOIN SOURCE src ON src.CODE = tmp.SOURCE_ID;
