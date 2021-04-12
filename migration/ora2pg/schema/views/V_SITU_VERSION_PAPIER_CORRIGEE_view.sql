-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_situ_version_papier_corrigee (these_id, validation_id) AS SELECT 
    v.these_id,
    v.id as validation_id
 FROM VALIDATION v
         JOIN TYPE_VALIDATION tv ON tv.ID = v.TYPE_VALIDATION_ID
WHERE tv.CODE='VERSION_PAPIER_CORRIGEE';
