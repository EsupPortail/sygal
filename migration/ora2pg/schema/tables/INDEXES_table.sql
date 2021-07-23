-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON

CREATE INDEX acteur_acteur_etab_id_idx ON acteur (acteur_etablissement_id);
CREATE INDEX acteur_histo_destruct_id_idx ON acteur (histo_destructeur_id);
CREATE INDEX acteur_histo_modif_id_idx ON acteur (histo_modificateur_id);
CREATE INDEX acteur_individu_id_idx ON acteur (individu_id);
CREATE INDEX acteur_role_id_idx ON acteur (role_id);
CREATE UNIQUE INDEX acteur_source_code_uniq ON acteur (source_code);
CREATE INDEX acteur_source_id_idx ON acteur (source_id);
CREATE INDEX acteur_these_id_idx ON acteur (these_id);
CREATE INDEX attestation_hc_idx ON attestation (histo_createur_id);
CREATE INDEX attestation_hd_idx ON attestation (histo_destructeur_id);
CREATE INDEX attestation_hm_idx ON attestation (histo_modificateur_id);
CREATE INDEX attestation_these_idx ON attestation (these_id);
CREATE UNIQUE INDEX categorie_privilege_unique ON categorie_privilege (code);
CREATE INDEX diffusion_hc_idx ON diffusion (histo_createur_id);
CREATE INDEX diffusion_hd_idx ON diffusion (histo_destructeur_id);
CREATE INDEX diffusion_hm_idx ON diffusion (histo_modificateur_id);
CREATE INDEX diffusion_these_idx ON diffusion (these_id);
CREATE INDEX doctorant_etablissement_idx ON doctorant (etablissement_id);
CREATE INDEX doctorant_hcfk_idx ON doctorant (histo_createur_id);
CREATE INDEX doctorant_hdfk_idx ON doctorant (histo_destructeur_id);
CREATE INDEX doctorant_hmfk_idx ON doctorant (histo_modificateur_id);
CREATE INDEX doctorant_individu_idx ON doctorant (individu_id);
CREATE UNIQUE INDEX doctorant_source_code_uniq ON doctorant (source_code);
CREATE INDEX doctorant_src_id_index ON doctorant (source_id);
CREATE INDEX doctorant_compl_doctorant_idx ON doctorant_compl (doctorant_id);
CREATE INDEX doctorant_compl_hc_idx ON doctorant_compl (histo_createur_id);
CREATE INDEX doctorant_compl_hd_idx ON doctorant_compl (histo_destructeur_id);
CREATE INDEX doctorant_compl_hm_idx ON doctorant_compl (histo_modificateur_id);
CREATE UNIQUE INDEX doctorant_compl_un ON doctorant_compl (persopass, histo_destruction);
CREATE INDEX ecole_doct_hc_idx ON ecole_doct (histo_createur_id);
CREATE INDEX ecole_doct_hd_idx ON ecole_doct (histo_destructeur_id);
CREATE INDEX ecole_doct_hm_idx ON ecole_doct (histo_modificateur_id);
CREATE UNIQUE INDEX ecole_doct_source_code_un ON ecole_doct (source_code);
CREATE INDEX ecole_doct_source_idx ON ecole_doct (source_id);
CREATE INDEX ecole_doct_struct_id_idx ON ecole_doct (structure_id);
CREATE UNIQUE INDEX etablissement_domaine_uindex ON etablissement (domaine);
CREATE INDEX etablissement_struct_id_idx ON etablissement (structure_id);
CREATE UNIQUE INDEX source_code_unique ON etablissement (source_code);
CREATE INDEX fichier_hcfk_idx ON fichier (histo_createur_id);
CREATE INDEX fichier_hdfk_idx ON fichier (histo_destructeur_id);
CREATE INDEX fichier_hmfk_idx ON fichier (histo_modificateur_id);
CREATE INDEX fichier_nature_id_index ON fichier (nature_id);
CREATE UNIQUE INDEX fichier_permanent_id_uindex ON fichier (permanent_id);
CREATE UNIQUE INDEX fichier_uuid_un ON fichier (uuid);
CREATE INDEX fichier_version_fk_idx ON fichier (version_fichier_id);
CREATE INDEX fichier_these_fich_id_idx ON fichier_these (fichier_id);
CREATE INDEX fichier_these_these_id_idx ON fichier_these (these_id);
CREATE UNIQUE INDEX financement_source_code_un ON financement (source_code);
CREATE UNIQUE INDEX import_notif_un ON import_notif (table_name, column_name, operation);
CREATE UNIQUE INDEX import_observ_un ON import_observ (table_name, column_name, operation, to_value);
CREATE INDEX import_obs_notif_io_idx ON import_obs_notif (import_observ_id);
CREATE INDEX import_obs_notif_n_idx ON import_obs_notif (notif_id);
CREATE INDEX import_obs_notif_ior_idx ON import_obs_result_notif (import_observ_result_id);
CREATE INDEX import_obs_notif_nr_idx ON import_obs_result_notif (notif_result_id);
CREATE INDEX individu_hcfk_idx ON individu (histo_createur_id);
CREATE INDEX individu_hdfk_idx ON individu (histo_destructeur_id);
CREATE INDEX individu_hmfk_idx ON individu (histo_modificateur_id);
CREATE UNIQUE INDEX individu_source_code_uniq ON individu (source_code, histo_destruction);
CREATE INDEX individu_src_id_index ON individu (source_id);
CREATE INDEX individu_role_individu_idx ON individu_role (individu_id);
CREATE INDEX individu_role_role_idx ON individu_role (role_id);
CREATE UNIQUE INDEX individu_role_unique ON individu_role (individu_id, role_id);
CREATE UNIQUE INDEX information_filename_uindex ON information_fichier_sav (filename);
CREATE UNIQUE INDEX liste_diff_adresse_un ON liste_diff (adresse);
CREATE UNIQUE INDEX mail_confirmation_code_uindex ON mail_confirmation (code);
CREATE UNIQUE INDEX metadonnee_these_uniq ON metadonnee_these (these_id);
CREATE UNIQUE INDEX nature_fichier_code_uindex ON nature_fichier (code);
CREATE INDEX notif_result_notif_idx ON notif_result (notif_id);
CREATE UNIQUE INDEX origine_fin_source_code_un ON origine_financement (source_code);
CREATE INDEX privilege_categ_idx ON privilege (categorie_id);
CREATE UNIQUE INDEX privilege_unique ON privilege (categorie_id, code);
CREATE UNIQUE INDEX profil_role_id_uindex ON profil (role_id);
CREATE INDEX rapport_validation_hcfk_idx ON rapport_validation (histo_createur_id);
CREATE INDEX rapport_validation_hdfk_idx ON rapport_validation (histo_destructeur_id);
CREATE INDEX rapport_validation_hmfk_idx ON rapport_validation (histo_modificateur_id);
CREATE INDEX rapport_validation_indiv_idx ON rapport_validation (individu_id);
CREATE INDEX rapport_validation_rapport_idx ON rapport_validation (rapport_id);
CREATE INDEX rapport_validation_type_idx ON rapport_validation (type_validation_id);
CREATE UNIQUE INDEX rapport_validation_un ON rapport_validation (type_validation_id, rapport_id, histo_destruction, individu_id);
CREATE INDEX rdv_bu_hc_idx ON rdv_bu (histo_createur_id);
CREATE INDEX rdv_bu_hd_idx ON rdv_bu (histo_destructeur_id);
CREATE INDEX rdv_bu_hm_idx ON rdv_bu (histo_modificateur_id);
CREATE INDEX rdv_bu_these_idx ON rdv_bu (these_id);
CREATE UNIQUE INDEX role_source_code_un ON role (source_code);
CREATE INDEX role_structure_id_idx ON role (structure_id);
CREATE INDEX role_type_structure_id_idx ON role (type_structure_dependant_id);
CREATE INDEX role_privilege_privilege_idx ON role_privilege (privilege_id);
CREATE INDEX role_privilege_role_idx ON role_privilege (role_id);
CREATE UNIQUE INDEX configuration_code_uindex ON soutenance_configuration (code);
CREATE UNIQUE INDEX structure_source_code_un ON structure (source_code);
CREATE INDEX structure_type_str_id_idx ON structure (type_structure_id);
CREATE INDEX str_substit_str_to_idx ON structure_substit (to_structure_id);
CREATE UNIQUE INDEX str_substit_unique ON structure_substit (from_structure_id);
CREATE INDEX acteur_doctorant_id_idx ON these (doctorant_id);
CREATE INDEX acteur_ecole_doct_id_idx ON these (ecole_doct_id);
CREATE INDEX acteur_etablissement_id_idx ON these (etablissement_id);
CREATE INDEX acteur_unite_rech_id_idx ON these (unite_rech_id);
CREATE INDEX these_etat_index ON these (etat_these);
CREATE INDEX these_hcfk_idx ON these (histo_createur_id);
CREATE INDEX these_hdfk_idx ON these (histo_destructeur_id);
CREATE INDEX these_hmfk_idx ON these (histo_modificateur_id);
CREATE UNIQUE INDEX these_source_code_uniq ON these (source_code);
CREATE INDEX these_src_id_index ON these (source_id);
CREATE INDEX these_titre_index ON these (titre);
CREATE INDEX these_annee_univ_these_id_idx ON these_annee_univ (these_id);
CREATE UNIQUE INDEX these_an_univ_source_code_un ON these_annee_univ (source_code);
CREATE UNIQUE INDEX titre_acces_source_code_un ON titre_acces (source_code);
CREATE INDEX titre_acces_these_id_idx ON titre_acces (these_id);
CREATE INDEX tmp_acteur_source_code_index ON tmp_acteur (source_code);
CREATE INDEX tmp_acteur_source_id_index ON tmp_acteur (source_id);
CREATE UNIQUE INDEX tmp_acteur_uniq ON tmp_acteur (id, etablissement_id);
CREATE INDEX tmp_doctorant_source_code_idx ON tmp_doctorant (source_code);
CREATE INDEX tmp_doctorant_source_id_idx ON tmp_doctorant (source_id);
CREATE UNIQUE INDEX tmp_doctorant_uniq ON tmp_doctorant (id, etablissement_id);
CREATE INDEX tmp_ecole_doct_source_code_idx ON tmp_ecole_doct (source_code);
CREATE INDEX tmp_ecole_doct_source_id_idx ON tmp_ecole_doct (source_id);
CREATE INDEX tmp_ecole_doct_struct_id_idx ON tmp_ecole_doct (structure_id);
CREATE UNIQUE INDEX tmp_ecole_doct_uniq ON tmp_ecole_doct (id, structure_id);
CREATE INDEX tmp_etab_source_code_idx ON tmp_etablissement (source_code);
CREATE INDEX tmp_etab_source_id_idx ON tmp_etablissement (source_id);
CREATE INDEX tmp_etab_struct_id_idx ON tmp_etablissement (structure_id);
CREATE UNIQUE INDEX tmp_etab_uniq ON tmp_etablissement (id, structure_id);
CREATE UNIQUE INDEX tmp_financement_uniq ON tmp_financement (id, etablissement_id);
CREATE INDEX tmp_individu_source_code_idx ON tmp_individu (source_code);
CREATE INDEX tmp_individu_source_id_idx ON tmp_individu (source_id);
CREATE UNIQUE INDEX tmp_individu_uniq ON tmp_individu (id, etablissement_id);
CREATE UNIQUE INDEX tmp_origine_financement_uniq ON tmp_origine_financement (id, etablissement_id);
CREATE INDEX tmp_role_source_code_index ON tmp_role (source_code);
CREATE INDEX tmp_role_source_id_index ON tmp_role (source_id);
CREATE UNIQUE INDEX tmp_role_uniq ON tmp_role (id, etablissement_id);
CREATE INDEX tmp_structure_source_code_idx ON tmp_structure (source_code);
CREATE INDEX tmp_structure_source_id_idx ON tmp_structure (source_id);
CREATE INDEX tmp_structure_type_id_idx ON tmp_structure (type_structure_id);
CREATE INDEX tmp_these_source_code_index ON tmp_these (source_code);
CREATE INDEX tmp_these_source_id_index ON tmp_these (source_id);
CREATE UNIQUE INDEX tmp_these_uniq ON tmp_these (id, etablissement_id);
CREATE INDEX tmp_these_annee_u_src_cod_idx ON tmp_these_annee_univ (source_code);
CREATE INDEX tmp_these_annee_u_src_id_idx ON tmp_these_annee_univ (source_id);
CREATE UNIQUE INDEX tmp_these_annee_u_uniq ON tmp_these_annee_univ (id, etablissement_id);
CREATE INDEX tmp_titre_acces_source_cod_idx ON tmp_titre_acces (source_code);
CREATE INDEX tmp_titre_acces_source_id_idx ON tmp_titre_acces (source_id);
CREATE UNIQUE INDEX tmp_titre_acces_uniq ON tmp_titre_acces (id, etablissement_id);
CREATE INDEX tmp_unite_rech_source_code_idx ON tmp_unite_rech (source_code);
CREATE INDEX tmp_unite_rech_source_id_idx ON tmp_unite_rech (source_id);
CREATE INDEX tmp_unite_rech_struct_id_idx ON tmp_unite_rech (structure_id);
CREATE UNIQUE INDEX tmp_unite_rech_uniq ON tmp_unite_rech (id, structure_id);
CREATE INDEX tmp_variable_source_code_index ON tmp_variable (source_code);
CREATE INDEX tmp_variable_source_id_index ON tmp_variable (source_id);
CREATE UNIQUE INDEX tmp_variable_uniq ON tmp_variable (id, etablissement_id);
CREATE UNIQUE INDEX type_rapport_un ON type_rapport (code);
CREATE UNIQUE INDEX type_structure_un ON type_structure (code);
CREATE UNIQUE INDEX type_validation_un ON type_validation (code);
CREATE INDEX unite_rech_hc_idx ON unite_rech (histo_createur_id);
CREATE INDEX unite_rech_hd_idx ON unite_rech (histo_destructeur_id);
CREATE INDEX unite_rech_hm_idx ON unite_rech (histo_modificateur_id);
CREATE UNIQUE INDEX unite_rech_source_code_un ON unite_rech (source_code);
CREATE INDEX unite_rech_source_idx ON unite_rech (source_id);
CREATE INDEX unite_rech_struct_id_idx ON unite_rech (structure_id);
CREATE UNIQUE INDEX user_token_user_action_un ON user_token (user_id, action);
CREATE UNIQUE INDEX utilis_password_reset_token_un ON utilisateur (password_reset_token);
CREATE INDEX validation_hcfk_idx ON validation (histo_createur_id);
CREATE INDEX validation_hdfk_idx ON validation (histo_destructeur_id);
CREATE INDEX validation_hmfk_idx ON validation (histo_modificateur_id);
CREATE INDEX validation_individu_idx ON validation (individu_id);
CREATE INDEX validation_these_idx ON validation (these_id);
CREATE INDEX validation_type_idx ON validation (type_validation_id);
CREATE UNIQUE INDEX validation_un ON validation (type_validation_id, these_id, histo_destruction, individu_id);
CREATE INDEX validite_fichier_fichier_idx ON validite_fichier (fichier_id);
CREATE INDEX validite_fichier_hcfk_idx ON validite_fichier (histo_createur_id);
CREATE INDEX validite_fichier_hdfk_idx ON validite_fichier (histo_destructeur_id);
CREATE INDEX validite_fichier_hmfk_idx ON validite_fichier (histo_modificateur_id);
CREATE UNIQUE INDEX variable_code_uniq ON variable (code, etablissement_id);
CREATE INDEX variable_etablissement_idx ON variable (etablissement_id);
CREATE INDEX variable_hc_idx ON variable (histo_createur_id);
CREATE INDEX variable_hd_idx ON variable (histo_destructeur_id);
CREATE INDEX variable_hm_idx ON variable (histo_modificateur_id);
CREATE UNIQUE INDEX variable_source_code_uniq ON variable (source_code);
CREATE INDEX variable_source_idx ON variable (source_id);
CREATE UNIQUE INDEX version_fichier_uniq_code ON version_fichier (code);
