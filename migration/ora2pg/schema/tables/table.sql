-- Generated by Ora2Pg, the Oracle database Schema converter, version 20.0
-- Copyright 2000-2019 Gilles DAROLD. All rights reserved.
-- DATASOURCE: dbi:Oracle:host=sygaldb.unicaen.fr;sid=SYGLPROD;port=1523

SET client_encoding TO 'UTF8';

\set ON_ERROR_STOP ON


CREATE TABLE acteur (
	id bigint NOT NULL,
	individu_id bigint NOT NULL DEFAULT NULL,
	these_id bigint NOT NULL DEFAULT NULL,
	role_id bigint NOT NULL DEFAULT NULL,
	qualite varchar(200),
	lib_role_compl varchar(200),
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	acteur_etablissement_id bigint
) ;

CREATE TABLE api_log (
	id bigint NOT NULL,
	req_uri varchar(2000) NOT NULL,
	req_start_date timestamp NOT NULL,
	req_end_date timestamp,
	req_status varchar(32),
	req_response text,
	req_etablissement varchar(64),
	req_table varchar(64)
) ;
COMMENT ON TABLE api_log IS E'Logs des appels aux API des établissements.';

CREATE TABLE attestation (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	ver_depo_est_ver_ref smallint NOT NULL DEFAULT 0,
	ex_impr_conform_ver_depo smallint DEFAULT null,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	version_corrigee smallint NOT NULL DEFAULT 0,
	creation_auto smallint NOT NULL DEFAULT 0
) ;

CREATE TABLE categorie_privilege (
	id bigint NOT NULL,
	code varchar(150) NOT NULL,
	libelle varchar(200) NOT NULL,
	ordre bigint
) ;

CREATE TABLE diffusion (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	droit_auteur_ok smallint NOT NULL DEFAULT 0,
	autoris_mel smallint NOT NULL DEFAULT 0,
	autoris_embargo_duree varchar(20),
	autoris_motif varchar(2000),
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	certif_charte_diff smallint NOT NULL DEFAULT 0,
	confident smallint NOT NULL DEFAULT 0,
	confident_date_fin timestamp,
	orcid varchar(200),
	nnt varchar(30),
	hal_id varchar(100),
	version_corrigee smallint NOT NULL DEFAULT 0,
	creation_auto smallint NOT NULL DEFAULT 0
) ;
COMMENT ON COLUMN diffusion.droit_auteur_ok IS E'Je garantis que tous les documents de la version mise en ligne sont libres de droits ou que j''ai acquis les droits afférents pour la reproduction et la représentation sur tous supports';
COMMENT ON COLUMN diffusion.autoris_embargo_duree IS E'Durée de l''embargo éventuel';
COMMENT ON COLUMN diffusion.autoris_mel IS E'J''autorise la mise en ligne de la version de diffusion de la thèse sur Internet';
COMMENT ON COLUMN diffusion.confident IS E'La thèse est-elle confidentielle ?';
COMMENT ON COLUMN diffusion.certif_charte_diff IS E'En cochant cette case, je certifie avoir pris connaissance de la charte de diffusion des thèses en vigueur à la date de signature de la convention de mise en ligne';

CREATE TABLE doctorant (
	id bigint NOT NULL,
	etablissement_id bigint NOT NULL DEFAULT NULL,
	individu_id bigint NOT NULL DEFAULT NULL,
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	ine varchar(64)
) ;
COMMENT ON TABLE doctorant IS E'Doctorant par établissement.';

CREATE TABLE doctorant_compl (
	id bigint NOT NULL,
	doctorant_id bigint NOT NULL,
	persopass varchar(50),
	email_pro varchar(100),
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE domaine_scientifique (
	id bigint NOT NULL,
	libelle varchar(128) NOT NULL
) ;

CREATE TABLE ecole_doct (
	id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp DEFAULT null,
	histo_modificateur_id bigint DEFAULT null,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	source_id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	structure_id bigint NOT NULL,
	theme varchar(1024),
	offre_these varchar(2047)
) ;

CREATE TABLE etablissement (
	id bigint NOT NULL,
	structure_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modification timestamp DEFAULT null,
	histo_destruction timestamp,
	histo_createur_id bigint NOT NULL,
	histo_modificateur_id bigint DEFAULT null,
	histo_destructeur_id bigint,
	domaine varchar(50),
	source_id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	est_membre smallint NOT NULL DEFAULT 0,
	est_associe smallint NOT NULL DEFAULT 0,
	est_comue smallint NOT NULL DEFAULT 0,
	est_etab_inscription bigint NOT NULL DEFAULT 0,
	code varchar(64),
	signature_convocation_id bigint
) ;
COMMENT ON COLUMN etablissement.domaine IS E'Domaine DNS de l''établissement tel que présent dans l''EPPN Shibboleth, ex: unicaen.fr.';

CREATE TABLE etablissement_rattach (
	id bigint NOT NULL,
	unite_id bigint NOT NULL,
	etablissement_id bigint NOT NULL
) ;

CREATE TABLE faq (
	id bigint NOT NULL,
	question varchar(2000) NOT NULL,
	reponse varchar(2000) NOT NULL,
	ordre bigint
) ;

CREATE TABLE fichier (
	id bigint NOT NULL,
	uuid varchar(60) NOT NULL,
	nature_id bigint NOT NULL DEFAULT 1,
	nom varchar(255) NOT NULL,
	nom_original varchar(255) NOT NULL DEFAULT 'NULL',
	type_mime varchar(128) NOT NULL,
	taille bigint NOT NULL,
	description varchar(256),
	version_fichier_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	permanent_id varchar(50)
) ;

CREATE TABLE fichier_these (
	id bigint NOT NULL,
	fichier_id bigint NOT NULL,
	these_id bigint NOT NULL,
	est_annexe smallint NOT NULL DEFAULT 0,
	est_expurge smallint NOT NULL DEFAULT 0,
	est_conforme smallint,
	retraitement varchar(50),
	est_partiel smallint NOT NULL DEFAULT 0
) ;

CREATE TABLE financement (
	id bigint NOT NULL,
	source_id bigint NOT NULL,
	these_id bigint,
	annee bigint NOT NULL,
	origine_financement_id bigint NOT NULL,
	complement_financement varchar(256),
	quotite_financement varchar(8),
	date_debut timestamp,
	date_fin timestamp,
	source_code varchar(64) NOT NULL DEFAULT 'NULL',
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp DEFAULT null,
	histo_modificateur_id bigint DEFAULT null,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	code_type_financement varchar(8),
	libelle_type_financement varchar(100)
) ;

CREATE TABLE import_log (
	type varchar(128) NOT NULL,
	name varchar(128) NOT NULL,
	success smallint NOT NULL,
	log text NOT NULL,
	started_on timestamp NOT NULL,
	ended_on timestamp NOT NULL
) ;

CREATE TABLE import_notif (
	id bigint NOT NULL,
	table_name varchar(50) NOT NULL,
	column_name varchar(50) NOT NULL,
	operation varchar(50) NOT NULL DEFAULT 'UPDATE',
	to_value varchar(1000),
	description varchar(200),
	url varchar(1000) NOT NULL
) ;

CREATE TABLE import_observ (
	id bigint NOT NULL,
	code varchar(50) NOT NULL,
	table_name varchar(50) NOT NULL,
	column_name varchar(50) NOT NULL,
	operation varchar(50) NOT NULL DEFAULT 'UPDATE',
	to_value varchar(1000),
	description varchar(200),
	enabled smallint NOT NULL DEFAULT 0,
	filter text
) ;

CREATE TABLE import_observ_result (
	id bigint NOT NULL,
	import_observ_id bigint NOT NULL,
	date_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	source_code varchar(64) NOT NULL,
	resultat text NOT NULL,
	date_notif timestamp,
	date_limite_notif timestamp,
	z_ioer_id bigint
) ;

CREATE TABLE import_obs_notif (
	id bigint NOT NULL,
	import_observ_id bigint NOT NULL,
	notif_id bigint NOT NULL
) ;

CREATE TABLE import_obs_result_notif (
	id bigint NOT NULL,
	import_observ_result_id bigint NOT NULL,
	notif_result_id bigint NOT NULL
) ;

CREATE TABLE indicateur (
	id bigint NOT NULL,
	libelle varchar(128) NOT NULL,
	description varchar(1024),
	requete varchar(2048),
	actif bigint,
	display_as varchar(128),
	class varchar(128)
) ;

CREATE TABLE individu (
	id bigint NOT NULL,
	type varchar(32),
	civilite varchar(5),
	nom_usuel varchar(60) NOT NULL,
	nom_patronymique varchar(60),
	prenom1 varchar(60) NOT NULL,
	prenom2 varchar(60),
	prenom3 varchar(60),
	email varchar(255),
	date_naissance timestamp,
	nationalite varchar(128),
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	supann_id varchar(30),
	etablissement_id bigint
) ;

CREATE TABLE individu_rech (
	id bigint NOT NULL,
	haystack text
) ;

CREATE TABLE individu_role (
	id bigint NOT NULL,
	individu_id bigint,
	role_id bigint
) ;
COMMENT ON TABLE individu_role IS E'Attributions à des individus de rôles sans lien avec une thèse en particulier, ex: bureau des doctorats.';

CREATE TABLE information (
	id bigint NOT NULL,
	titre varchar(256) NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	contenu text NOT NULL,
	priorite bigint NOT NULL DEFAULT 0,
	est_visible bigint NOT NULL DEFAULT 1,
	langue_id varchar(64) NOT NULL
) ;

CREATE TABLE information_fichier_sav (
	id bigint NOT NULL,
	nom varchar(256) NOT NULL,
	createur bigint,
	creation timestamp,
	filename varchar(256) NOT NULL DEFAULT 'none-given'
) ;

CREATE TABLE information_langue (
	id varchar(64) NOT NULL,
	libelle varchar(128),
	drapeau text
) ;

CREATE TABLE liste_diff (
	id bigint NOT NULL,
	adresse varchar(256) NOT NULL,
	enabled smallint NOT NULL DEFAULT 0,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE mail_confirmation (
	id bigint NOT NULL,
	individu_id bigint NOT NULL,
	email varchar(256) NOT NULL,
	etat varchar(1),
	code varchar(19)
) ;

CREATE TABLE metadonnee_these (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	titre varchar(2048) NOT NULL,
	langue varchar(40) NOT NULL,
	resume text NOT NULL DEFAULT 'NULL',
	resume_anglais text NOT NULL DEFAULT 'NULL',
	mots_cles_libres_fr varchar(1024) NOT NULL,
	mots_cles_rameau varchar(1024),
	titre_autre_langue varchar(2048) NOT NULL,
	mots_cles_libres_ang varchar(1024)
) ;

CREATE TABLE nature_fichier (
	id bigint NOT NULL,
	code varchar(50) NOT NULL DEFAULT 'NULL',
	libelle varchar(100) DEFAULT 'NULL'
) ;

CREATE TABLE notif (
	id bigint NOT NULL,
	code varchar(100) NOT NULL,
	description varchar(255) NOT NULL,
	recipients varchar(500),
	template text NOT NULL,
	enabled bigint NOT NULL DEFAULT 1
) ;

CREATE TABLE notif_result (
	id bigint NOT NULL,
	notif_id bigint NOT NULL,
	subject varchar(255) NOT NULL,
	body text NOT NULL,
	sent_on timestamp NOT NULL,
	error text
) ;

CREATE TABLE origine_financement (
	id bigint NOT NULL,
	code varchar(64) NOT NULL,
	libelle_long varchar(256) NOT NULL,
	source_id bigint,
	libelle_court varchar(64),
	source_code varchar(64) NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	visible bigint NOT NULL DEFAULT 1
) ;

CREATE TABLE parametre (
	id varchar(256) NOT NULL,
	description varchar(256) NOT NULL,
	valeur varchar(256) NOT NULL
) ;

CREATE TABLE privilege (
	id bigint NOT NULL,
	categorie_id bigint NOT NULL,
	code varchar(150) NOT NULL,
	libelle varchar(200) NOT NULL,
	ordre bigint
) ;

CREATE TABLE profil (
	id bigint NOT NULL,
	libelle varchar(100) NOT NULL,
	role_id varchar(100) NOT NULL,
	structure_type bigint DEFAULT NULL,
	description varchar(1024),
	ordre bigint DEFAULT 0
) ;

CREATE TABLE profil_privilege (
	privilege_id bigint NOT NULL,
	profil_id bigint NOT NULL
) ;

CREATE TABLE profil_to_role (
	profil_id bigint NOT NULL,
	role_id bigint NOT NULL
) ;

CREATE TABLE rapport_annuel (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	fichier_id bigint NOT NULL,
	annee_univ bigint NOT NULL,
	est_final smallint NOT NULL DEFAULT 0,
	histo_createur_id bigint NOT NULL,
	histo_modificateur_id bigint,
	histo_destructeur_id bigint,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modification timestamp,
	histo_destruction timestamp
) ;

CREATE TABLE rdv_bu (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	coord_doctorant varchar(2000),
	dispo_doctorant varchar(2000),
	mots_cles_rameau varchar(1024),
	convention_mel_signee smallint NOT NULL DEFAULT 0,
	exempl_papier_fourni smallint DEFAULT null,
	version_archivable_fournie smallint NOT NULL DEFAULT 0,
	divers text,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;
COMMENT ON COLUMN rdv_bu.version_archivable_fournie IS E'Témoin indiquant si une version archivable de la thèse existe';
COMMENT ON COLUMN rdv_bu.exempl_papier_fourni IS E'Exemplaire papier remis ?';
COMMENT ON COLUMN rdv_bu.convention_mel_signee IS E'Convention de mise en ligne signée ?';

CREATE TABLE role (
	id bigint NOT NULL,
	code varchar(50) NOT NULL,
	libelle varchar(200) NOT NULL,
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	role_id varchar(64) NOT NULL,
	is_default bigint DEFAULT 0,
	ldap_filter varchar(255),
	attrib_auto smallint NOT NULL DEFAULT 0,
	these_dep smallint NOT NULL DEFAULT 0,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	structure_id bigint,
	type_structure_dependant_id bigint,
	ordre_affichage varchar(32) NOT NULL DEFAULT 'zzz'
) ;
COMMENT ON COLUMN role.ordre_affichage IS E'Chaîne de caractères utilisée pour trier les rôles ; l''astuce consiste à concaténer cette valeur aux autres critères de tri.';

CREATE TABLE role_privilege (
	role_id bigint NOT NULL,
	privilege_id bigint NOT NULL
) ;

CREATE TABLE source (
	id bigint NOT NULL,
	code varchar(64) NOT NULL,
	libelle varchar(128) NOT NULL,
	importable smallint NOT NULL,
	etablissement_id bigint
) ;
COMMENT ON TABLE source IS E'Sources de données, importables ou non, ex: Apogée, Physalis.';

CREATE TABLE soutenance_avis (
	id bigint NOT NULL,
	proposition_id bigint NOT NULL,
	membre_id bigint NOT NULL,
	avis varchar(64),
	motif varchar(1024),
	validation_id bigint,
	fichier_id bigint DEFAULT NULL,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_configuration (
	id bigint NOT NULL,
	code varchar(64) NOT NULL,
	libelle varchar(256),
	valeur varchar(128)
) ;

CREATE TABLE soutenance_etat (
	id bigint NOT NULL,
	code varchar(63) NOT NULL,
	libelle varchar(255) NOT NULL,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_intervention (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	type_intervention bigint NOT NULL,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp,
	histo_modificateur_id bigint,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_justificatif (
	id bigint NOT NULL,
	proposition_id bigint NOT NULL,
	fichier_id bigint NOT NULL,
	membre_id bigint,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_membre (
	id bigint NOT NULL,
	proposition_id bigint NOT NULL,
	genre varchar(1) NOT NULL,
	qualite bigint NOT NULL DEFAULT NULL,
	etablissement varchar(128) NOT NULL,
	role_id varchar(64) NOT NULL,
	exterieur varchar(3),
	email varchar(256),
	acteur_id bigint,
	visio bigint NOT NULL DEFAULT 0,
	nom varchar(256),
	prenom varchar(256),
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_proposition (
	id bigint NOT NULL,
	these_id bigint NOT NULL,
	dateprev timestamp,
	lieu varchar(256),
	rendu_rapport timestamp,
	confidentialite timestamp,
	label_europeen bigint NOT NULL DEFAULT 0,
	manuscrit_anglais bigint NOT NULL DEFAULT 0,
	soutenance_anglais bigint NOT NULL DEFAULT 0,
	huit_clos bigint NOT NULL DEFAULT 0,
	exterieur bigint NOT NULL DEFAULT 0,
	nouveau_titre varchar(2048),
	etat_id bigint NOT NULL,
	sursis varchar(1),
	adresse_exacte varchar(2048),
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_qualite (
	id bigint NOT NULL,
	libelle varchar(128) NOT NULL,
	rang varchar(1) NOT NULL,
	hdr varchar(1) NOT NULL,
	emeritat varchar(1) NOT NULL,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE soutenance_qualite_sup (
	id bigint NOT NULL,
	qualite_id bigint NOT NULL,
	libelle varchar(255) NOT NULL,
	histo_creation timestamp NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE structure (
	id bigint NOT NULL,
	sigle varchar(40),
	libelle varchar(300) NOT NULL DEFAULT 'NULL',
	chemin_logo varchar(200),
	type_structure_id bigint,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp DEFAULT null,
	histo_modificateur_id bigint DEFAULT null,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	source_id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	code varchar(64) NOT NULL DEFAULT 'NULL',
	est_ferme smallint DEFAULT 0,
	adresse varchar(1024),
	telephone varchar(64),
	fax varchar(64),
	email varchar(64),
	site_web varchar(512),
	id_ref varchar(1024)
) ;

CREATE TABLE structure_substit (
	id bigint NOT NULL,
	from_structure_id bigint NOT NULL,
	to_structure_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_destruction timestamp,
	histo_createur_id bigint,
	histo_modificateur_id bigint,
	histo_destructeur_id bigint
) ;

CREATE TABLE synchro_log (
	id bigint NOT NULL,
	log_date timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	start_date timestamp NOT NULL,
	finish_date timestamp NOT NULL,
	status varchar(50) NOT NULL,
	sql text NOT NULL,
	message text
) ;

CREATE TABLE sync_log (
	id bigint NOT NULL,
	date_sync timestamp NOT NULL,
	message text NOT NULL,
	table_name varchar(30),
	source_code varchar(200)
) ;

CREATE TABLE these (
	id bigint NOT NULL,
	etablissement_id bigint DEFAULT 2,
	doctorant_id bigint NOT NULL DEFAULT NULL,
	ecole_doct_id bigint,
	unite_rech_id bigint,
	besoin_expurge smallint NOT NULL DEFAULT 0,
	cod_unit_rech varchar(50),
	correc_autorisee varchar(30),
	date_autoris_soutenance timestamp,
	date_fin_confid timestamp,
	date_prem_insc timestamp,
	date_prev_soutenance timestamp,
	date_soutenance timestamp,
	etat_these varchar(20),
	lib_disc varchar(200),
	lib_etab_cotut varchar(60),
	lib_pays_cotut varchar(40),
	lib_unit_rech varchar(200),
	resultat smallint,
	soutenance_autoris varchar(1),
	tem_avenant_cotut varchar(1),
	titre varchar(2048),
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	correc_autorisee_forcee varchar(30),
	date_abandon timestamp,
	date_transfert timestamp,
	correc_effectuee varchar(30) DEFAULT 'null'
) ;
COMMENT ON TABLE these IS E'Thèses par établissement.';

CREATE TABLE these_annee_univ (
	id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	these_id bigint,
	annee_univ bigint,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp
) ;

CREATE TABLE titre_acces (
	id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	these_id bigint,
	titre_acces_interne_externe varchar(1),
	libelle_titre_acces varchar(200),
	type_etb_titre_acces varchar(50),
	libelle_etb_titre_acces varchar(200),
	code_dept_titre_acces varchar(20),
	code_pays_titre_acces varchar(20),
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	histo_destructeur_id bigint,
	histo_destruction timestamp
) ;

CREATE TABLE tmp_acteur (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	individu_id varchar(64) NOT NULL,
	these_id varchar(64) NOT NULL,
	role_id varchar(64) NOT NULL,
	lib_cps varchar(200),
	cod_cps varchar(50),
	cod_roj_compl varchar(50),
	lib_roj_compl varchar(200),
	tem_hab_rch_per varchar(1),
	tem_rap_recu varchar(1),
	acteur_etablissement_id varchar(64),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_doctorant (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	individu_id varchar(64) NOT NULL,
	ine varchar(64),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_ecole_doct (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	structure_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_etablissement (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	structure_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_financement (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	these_id varchar(50) NOT NULL,
	annee varchar(50) NOT NULL,
	origine_financement_id varchar(50) NOT NULL,
	complement_financement varchar(200),
	quotite_financement varchar(50),
	date_debut_financement timestamp,
	date_fin_financement timestamp,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP,
	code_type_financement varchar(8),
	libelle_type_financement varchar(100)
) ;

CREATE TABLE tmp_individu (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	type varchar(32),
	civ varchar(5),
	lib_nom_usu_ind varchar(60) NOT NULL,
	lib_nom_pat_ind varchar(60) NOT NULL,
	lib_pr1_ind varchar(60) NOT NULL,
	lib_pr2_ind varchar(60),
	lib_pr3_ind varchar(60),
	email varchar(255),
	dat_nai_per timestamp,
	lib_nat varchar(128),
	supann_id varchar(30),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_origine_financement (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	cod_ofi varchar(50) NOT NULL,
	lic_ofi varchar(50) NOT NULL,
	lib_ofi varchar(200) NOT NULL,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_role (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	lib_roj varchar(200),
	lic_roj varchar(50),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_structure (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	type_structure_id varchar(64) NOT NULL,
	sigle varchar(64),
	libelle varchar(200) NOT NULL,
	code_pays varchar(64),
	libelle_pays varchar(200),
	code varchar(64),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_these (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	doctorant_id varchar(64) NOT NULL,
	ecole_doct_id varchar(64),
	unite_rech_id varchar(64),
	correction_possible varchar(30),
	dat_aut_sou_ths timestamp,
	dat_fin_cfd_ths timestamp,
	dat_deb_ths timestamp,
	dat_prev_sou timestamp,
	dat_sou_ths timestamp,
	eta_ths varchar(20),
	lib_int1_dis varchar(200),
	lib_etab_cotut varchar(60),
	lib_pays_cotut varchar(40),
	cod_neg_tre varchar(1),
	tem_sou_aut_ths varchar(1),
	tem_avenant_cotut varchar(1),
	lib_ths varchar(2048),
	annee_univ_1ere_insc bigint,
	dat_abandon timestamp,
	dat_transfert_dep timestamp,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP,
	correction_effectuee varchar(30) DEFAULT 'null'
) ;

CREATE TABLE tmp_these_annee_univ (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	these_id varchar(50) NOT NULL,
	annee_univ bigint,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_titre_acces (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	these_id varchar(50) NOT NULL,
	titre_acces_interne_externe varchar(1),
	libelle_titre_acces varchar(200),
	type_etb_titre_acces varchar(50),
	libelle_etb_titre_acces varchar(200),
	code_dept_titre_acces varchar(20),
	code_pays_titre_acces varchar(20),
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_unite_rech (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	structure_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE tmp_variable (
	insert_date timestamp DEFAULT LOCALTIMESTAMP,
	id varchar(64),
	etablissement_id varchar(64) NOT NULL,
	source_id varchar(64) NOT NULL,
	source_code varchar(64) NOT NULL,
	cod_vap varchar(50),
	lib_vap varchar(300),
	par_vap varchar(200),
	date_deb_validite timestamp NOT NULL DEFAULT NULL,
	date_fin_validite timestamp NOT NULL DEFAULT NULL,
	source_insert_date timestamp DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE type_structure (
	id bigint NOT NULL,
	code varchar(50) NOT NULL,
	libelle varchar(100)
) ;

CREATE TABLE type_validation (
	id bigint NOT NULL,
	code varchar(50) NOT NULL,
	libelle varchar(100)
) ;

CREATE TABLE unite_domaine_linker (
	unite_id bigint NOT NULL,
	domaine_id bigint NOT NULL
) ;

CREATE TABLE unite_rech (
	id bigint NOT NULL,
	etab_support varchar(500),
	autres_etab varchar(500),
	source_id bigint NOT NULL,
	source_code varchar(64) NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL,
	histo_modification timestamp DEFAULT null,
	histo_modificateur_id bigint DEFAULT null,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	structure_id bigint NOT NULL,
	rnsr_id varchar(128)
) ;

CREATE TABLE utilisateur (
	id bigint NOT NULL,
	username varchar(255),
	email varchar(255),
	display_name varchar(100),
	password varchar(128) NOT NULL,
	state bigint NOT NULL DEFAULT 1,
	last_role_id bigint,
	individu_id bigint,
	password_reset_token varchar(256)
) ;
COMMENT ON TABLE utilisateur IS E'Comptes utilisateurs s''étant déjà connecté à l''application + comptes avec mot de passe local.';

CREATE TABLE validation (
	id bigint NOT NULL,
	type_validation_id bigint NOT NULL,
	these_id bigint NOT NULL,
	individu_id bigint DEFAULT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_createur_id bigint NOT NULL DEFAULT 1,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modificateur_id bigint NOT NULL DEFAULT 1,
	histo_destruction timestamp,
	histo_destructeur_id bigint
) ;

CREATE TABLE validite_fichier (
	id bigint NOT NULL,
	fichier_id bigint NOT NULL,
	est_valide smallint,
	message text,
	log text,
	histo_createur_id bigint NOT NULL,
	histo_modificateur_id bigint NOT NULL,
	histo_destruction timestamp,
	histo_destructeur_id bigint,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_modification timestamp NOT NULL DEFAULT LOCALTIMESTAMP
) ;

CREATE TABLE variable (
	id bigint NOT NULL,
	etablissement_id bigint NOT NULL DEFAULT NULL,
	description varchar(300) NOT NULL,
	valeur varchar(200) NOT NULL,
	source_code varchar(64) NOT NULL,
	source_id bigint NOT NULL,
	histo_createur_id bigint NOT NULL,
	histo_creation timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	histo_destructeur_id bigint,
	histo_destruction timestamp,
	histo_modificateur_id bigint DEFAULT null,
	histo_modification timestamp DEFAULT null,
	date_deb_validite timestamp NOT NULL DEFAULT LOCALTIMESTAMP,
	date_fin_validite timestamp NOT NULL DEFAULT to_date('9999-12-31','YYYY-MM-DD'),
	code varchar(64)
) ;
COMMENT ON TABLE variable IS E'Variables d''environnement concernant un établissement, ex: nom de l''établissement, nom du président, etc.';

CREATE TABLE version_fichier (
	id bigint NOT NULL,
	code varchar(16) NOT NULL,
	libelle varchar(128) NOT NULL
) ;

CREATE TABLE wf_etape (
	id bigint NOT NULL,
	code varchar(128) NOT NULL,
	ordre bigint NOT NULL DEFAULT 1,
	chemin bigint NOT NULL DEFAULT 1,
	obligatoire smallint NOT NULL DEFAULT 1,
	route varchar(200) NOT NULL,
	libelle_acteur varchar(150) NOT NULL,
	libelle_autres varchar(150) NOT NULL,
	desc_non_franchie varchar(250) NOT NULL,
	desc_sans_objectif varchar(250)
) ;