-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_situ_archivab_va (these_id, retraitement, est_valide) AS SELECT 
    ft.these_id,
    ft.RETRAITEMENT,
    vf.EST_VALIDE
 FROM FICHIER_THESE ft
         JOIN FICHIER f ON ft.FICHIER_ID = f.id and f.HISTO_DESTRUCTION is null
         JOIN VERSION_FICHIER v ON f.VERSION_FICHIER_ID = v.id AND v.CODE = 'VA'
         JOIN VALIDITE_FICHIER vf ON vf.FICHIER_ID = f.id
where EST_ANNEXE = false AND EST_EXPURGE = false;

