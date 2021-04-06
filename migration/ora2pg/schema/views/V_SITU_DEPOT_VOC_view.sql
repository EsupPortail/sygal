-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_situ_depot_voc (these_id, fichier_id) AS SELECT 
    ft.these_id,
    f.id AS fichier_id
 FROM FICHIER_THESE ft
         JOIN FICHIER f ON ft.FICHIER_ID = f.id and f.HISTO_DESTRUCTION is null
         JOIN NATURE_FICHIER nf ON f.NATURE_ID = nf.id AND nf.CODE = 'THESE_PDF'
         JOIN VERSION_FICHIER vf ON f.VERSION_FICHIER_ID = vf.ID AND vf.CODE = 'VOC'
where EST_ANNEXE = 0 AND EST_EXPURGE = 0 AND RETRAITEMENT IS NULL;

