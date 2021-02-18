-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE OR REPLACE VIEW v_situ_rdv_bu_validation_bu (these_id, valide) AS SELECT 
    v.these_id,
    CASE WHEN v.id is not null THEN 1 ELSE 0 END valide
 FROM VALIDATION v
         JOIN TYPE_VALIDATION tv on v.TYPE_VALIDATION_ID = tv.id and tv.code = 'RDV_BU'
where v.HISTO_DESTRUCTEUR_ID is null;

