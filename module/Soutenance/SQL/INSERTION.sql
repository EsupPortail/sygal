-------------------------------------------------------------------------------
--- CONFIG
-------------------------------------------------------------------------------

INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (1, 'AVIS_DEADLINE', 'Nombre de jours avant soutenance pour le retour des rapports', '14');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (2, 'JURY_SIZE_MIN', 'Nombre minimal de membre de jury', '4');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (3, 'JURY_SIZE_MAX', 'Nombre maximal de membre de jury', '8');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (4, 'JURY_RAPPORTEUR_SIZE_MIN', 'Nombre minimal de rapporteur', '2');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (5, 'JURY_RANGA_RATIO_MIN', 'Ratio minimal de membre de rang A', '0.5');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (6, 'JURY_EXTERIEUR_RATIO_MIN', 'Ratio minimal de membre exterieur', '0.50');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (7, 'JURY_PARITE_RATIO_MIN', 'Ratio minimal sur la parity du jury', '0');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (8, 'PROPOSITION_ORDRE_VALIDATION_ACTEUR', 'Ordre de validation de la proposition pour les acteurs directs', '1');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (9, 'PROPOSITION_ORDRE_VALIDATION_UR', 'Ordre de validation de la proposition pour l''unité de recherche', '2');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (10, 'PROPOSITION_ORDRE_VALIDATION_ED', 'Ordre de validation de la proposition pour l''école doctorale', '3');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (11, 'PROPOSITION_ORDRE_VALIDATION_BDD', 'Ordre de validation de la proposition pour le bureau des doctorats', '4');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (12, 'PROPOSITION_ORDRE_VALIDATION_PRESIDENT', 'Ordre de validation de la proposition pour le président', '-1');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (13, 'FORMULAIRE_DELOCALISATION', 'Formulaire de demande de délocalisation de la soutenance', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/8716');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (14, 'FORMULAIRE_DELEGUATION', 'Formulaire de demande de déléguation de signature', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/8714');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (15, 'FORMULAIRE_LABEL_EUROPEEN', 'Formulaire de demande de label européen', 'https://sygal-test.normandie-univ.fr/informations/fichiers/telecharger/802');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (16, 'FORMULAIRE_THESE_ANGLAIS', 'Formulaire de demande de rédaction en anglais', 'https://sygal-test.normandie-univ.fr/informations/fichiers/telecharger/1541');
INSERT INTO SOUTENANCE_CONFIGURATION (ID, CODE, LIBELLE, VALEUR) VALUES (17, 'FORMULAIRE_CONFIDENTIALITE', 'Formulaire de de mande de confidentialité', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/8715');

-------------------------------------------------------------------------------
--- ETAT
-------------------------------------------------------------------------------

INSERT INTO SOUTENANCE_ETAT (ID, CODE, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (1, 'EN_COURS', 'En cours d''examen', TO_DATE('2020-09-21 10:50:03', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 10:50:03', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_ETAT (ID, CODE, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (2, 'VALIDEE', 'Soutenance autorisée', TO_DATE('2020-09-21 10:50:04', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 10:50:04', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_ETAT (ID, CODE, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (3, 'REJETEE', 'Soutenance rejetée', TO_DATE('2020-09-21 10:50:04', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 10:50:04', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);

ALTER SEQUENCE SOUTENANCE_ETAT_ID_SEQ INCREMENT BY 4;
select SOUTENANCE_ETAT_ID_SEQ.nextval from dual;
ALTER SEQUENCE SOUTENANCE_ETAT_ID_SEQ INCREMENT BY 1;

-------------------------------------------------------------------------------
--- QUALITE
-------------------------------------------------------------------------------

INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (7, 'Professeur émerite', 'A', 'O', 'O', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (8, 'Chargé de Recherche (HDR)', 'B', 'O', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (9, 'Ingénieur de Recherche ', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (10, 'Ingénieur de Recherche (HDR)', 'B', 'O', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (11, 'Ingénieur d''Etude ', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (0, 'Qualité inconnue', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (12, 'Autre', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (1, 'Professeur des universités', 'A', 'O', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (2, 'Directeur de recherche', 'A', 'O', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (4, 'Maître de conférences', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (5, 'Chargé de recherche', 'B', 'N', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE (ID, LIBELLE, RANG, HDR, EMERITAT, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (6, 'Maître de conférences (HDR)', 'B', 'O', 'N', TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2020-09-21 11:05:34', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);

ALTER SEQUENCE SOUTENANCE_QUALITE_ID_SEQ INCREMENT BY 13;
select SOUTENANCE_QUALITE_ID_SEQ.nextval from dual;
ALTER SEQUENCE SOUTENANCE_QUALITE_ID_SEQ INCREMENT BY 1;

INSERT INTO SOUTENANCE_QUALITE_SUP (ID, QUALITE_ID, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (1, 5, 'CHARGE DE RECHERCHE', TO_DATE('2019-12-17 10:01:15', 'YYYY-MM-DD HH24:MI:SS'), 1, TO_DATE('2019-12-17 10:01:22', 'YYYY-MM-DD HH24:MI:SS'), 1, null, null);
INSERT INTO SOUTENANCE_QUALITE_SUP (ID, QUALITE_ID, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (4, 1, 'PROFESSEUR DES UNIVERSITES', TO_DATE('2019-12-17 11:54:12', 'YYYY-MM-DD HH24:MI:SS'), 1446, TO_DATE('2019-12-17 11:54:12', 'YYYY-MM-DD HH24:MI:SS'), 1446, null, null);
INSERT INTO SOUTENANCE_QUALITE_SUP (ID, QUALITE_ID, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (2, 2, 'DIRECTEUR DE RECHERCHE', TO_DATE('2019-12-17 11:26:10', 'YYYY-MM-DD HH24:MI:SS'), 1446, TO_DATE('2019-12-17 11:26:10', 'YYYY-MM-DD HH24:MI:SS'), 1446, null, null);
INSERT INTO SOUTENANCE_QUALITE_SUP (ID, QUALITE_ID, LIBELLE, HISTO_CREATION, HISTO_CREATEUR_ID, HISTO_MODIFICATION, HISTO_MODIFICATEUR_ID, HISTO_DESTRUCTION, HISTO_DESTRUCTEUR_ID) VALUES (3, 1, 'PROFESSEUR DES UNIVERSITÉS', TO_DATE('2019-12-17 11:27:29', 'YYYY-MM-DD HH24:MI:SS'), 1446, TO_DATE('2019-12-17 11:27:29', 'YYYY-MM-DD HH24:MI:SS'), 1446, null, null);

ALTER SEQUENCE SOUTENANCE_QUALITE_SUP_ID_SEQ INCREMENT BY 5;
select SOUTENANCE_QUALITE_SUP_ID_SEQ.nextval from dual;
ALTER SEQUENCE SOUTENANCE_QUALITE_SUP_ID_SEQ INCREMENT BY 1;
-------------------------------------------------------------------------------
--- NATURE DOCUMENT
-------------------------------------------------------------------------------

INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (11, 'JUSTIFICATIF_HDR', 'Justificatif d''habilitation à diriger des recherches');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (12, 'DELOCALISATION_SOUTENANCE', 'Formulaire de délocalisation de soutenance');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (13, 'DELEGUATION_SIGNATURE', 'Formulaire de délégation de signature du rapport de soutenance (visioconférence)');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (14, 'DEMANDE_LABEL_EUROPEEN', 'Formulaire de demande de label européen');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (15, 'DEMANDE_LANGUE_ANGLAISE', 'Formulaire de demande de manuscrit ou de soutenance en anglais');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (16, 'JUSTIFICATIF_EMERITAT', 'Justificatif d''émeritat');
INSERT INTO NATURE_FICHIER (ID, CODE, LIBELLE) VALUES (17, 'AUTRES_JUSTIFICATIFS', 'Autres justificatifs concernant la soutenance');

ALTER SEQUENCE NATURE_FICHIER_ID_SEQ INCREMENT BY 18;
select NATURE_FICHIER_ID_SEQ.nextval from dual;
ALTER SEQUENCE NATURE_FICHIER_ID_SEQ INCREMENT BY 1;

-------------------------------------------------------------------------------
--- TYPE VALIDATION
-------------------------------------------------------------------------------

INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (6, 'PROPOSITION_SOUTENANCE', 'Validation de la proposition de soutenance');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (8, 'ENGAGEMENT_IMPARTIALITE', 'Signature de l''engagement d''impartialité');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (9, 'VALIDATION_PROPOSITION_ED', 'Validation de la proposition de soutenance par l''école doctorale');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (10, 'VALIDATION_PROPOSITION_UR', 'Validation de la proposition de soutenance par l''unité de recherche');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (11, 'VALIDATION_PROPOSITION_BDD', 'Validation de la proposition de soutenance par le bureau des doctorats');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (12, 'AVIS_SOUTENANCE', 'Signature de l''avis de soutenance');
INSERT INTO TYPE_VALIDATION (ID, CODE, LIBELLE) VALUES (13, 'REFUS_ENGAGEMENT_IMPARTIALITE', 'Refus de l''engagement d''impartialité');