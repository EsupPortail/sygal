--
-- PostgreSQL database dump
--

-- Dumped from database version 13.0 (Debian 13.0-1.pgdg100+1)
-- Dumped by pg_dump version 13.2 (Ubuntu 13.2-1.pgdg20.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: categorie_privilege; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3100, 'financement', 'Financement', 5);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (21, 'ecole-doctorale', 'École doctorale', 100);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (23, 'faq', 'FAQ', 10);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (1, 'droit', 'Gestion des droits', 1);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (2, 'import', 'Import', 10);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3, 'these', 'Thèse', 20);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (4, 'doctorant', 'Doctorant', 30);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (5, 'utilisateur', 'Utilisateur', 5);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (22, 'unite-recherche', 'Unité de Recherche', 200);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (24, 'validation', 'Validations', 25);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (20, 'etablissement', 'Établissement', 90);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (50, 'indicateur', 'Indicateur & Statistiques', 250);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (47, 'fichier-commun', 'Dépôt de fichier commun non lié à une thèse (ex: avenant à la convention de MEL)', 50);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (101, 'soutenance', 'Soutenance', 1000);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (102, 'co-encadrant', 'Gestion des co-encadrants', 21);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (19, 'substitution', 'Substitution de structures', 300);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (7, 'page-information', 'Page d''information', NULL);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3080, 'gestion-president', 'Gestion des Présidents du jury', 22);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (100, 'structure', 'Structures associées à SyGAL (écoles doctorales, établissements et unités de recherche)', 80);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3000, 'rapport-annuel', 'Rapport annuel', 25);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3001, 'liste-diffusion', 'Liste de diffusion', 50);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3101, 'soutenance_intervention', 'Intervention sur les soutenances', 102);
INSERT INTO public.categorie_privilege (id, code, libelle, ordre) VALUES (3102, 'soutenance_justificatif', 'Justificatifs associés à la soutenance', 102);


--
-- Data for Name: domaine_scientifique; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.domaine_scientifique (id, libelle) VALUES (1, 'Mathématiques et leurs interactions');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (2, 'Physique');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (3, 'Sciences de la terre et de l''univers, espace');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (4, 'Chimie');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (5, 'Biologie, médecine et santé');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (6, 'Sciences humaines et humanités');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (7, 'Sciences de la société');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (8, 'Sciences pour l''ingénieur');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (9, 'Sciences et technologies de l''information et de la communication');
INSERT INTO public.domaine_scientifique (id, libelle) VALUES (10, 'Sciences agronomiques et écologiques');


--
-- Data for Name: import_observ; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.import_observ (id, code, table_name, column_name, operation, to_value, description, enabled, filter) VALUES (6, 'RESULTAT_PASSE_A_ADMIS', 'THESE', 'RESULTAT', 'UPDATE', '1', 'Le résultat de la thèse passe à 1 (admis)', 1, 'ETABLISSEMENT_ID IN (SELECT ID FROM ETABLISSEMENT WHERE SOURCE_CODE = ''UCN'')');
INSERT INTO public.import_observ (id, code, table_name, column_name, operation, to_value, description, enabled, filter) VALUES (9, 'CORRECTION_PASSE_A_FACULTATIVE', 'THESE', 'CORREC_AUTORISEE', 'UPDATE', 'facultative', 'Correction attendue passe à facultative', 1, 'ETABLISSEMENT_ID IN (SELECT ID FROM ETABLISSEMENT WHERE SOURCE_CODE = ''UCN'')');
INSERT INTO public.import_observ (id, code, table_name, column_name, operation, to_value, description, enabled, filter) VALUES (10, 'CORRECTION_PASSE_A_OBLIGATOIRE', 'THESE', 'CORREC_AUTORISEE', 'UPDATE', 'obligatoire', 'Correction attendue passe à obligatoire', 1, 'ETABLISSEMENT_ID IN (SELECT ID FROM ETABLISSEMENT WHERE SOURCE_CODE = ''UCN'')');


--
-- Data for Name: information_langue; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.information_langue (id, libelle, drapeau) VALUES ('FR', 'Français', 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0iVVRGLTgiPz4KPHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI5MDAiIGhlaWdodD0iNjAwIj48cmVjdCB3aWR0aD0iOTAwIiBoZWlnaHQ9IjYwMCIgZmlsbD0iI0VEMjkzOSIvPjxyZWN0IHdpZHRoPSI2MDAiIGhlaWdodD0iNjAwIiBmaWxsPSIjZmZmIi8+PHJlY3Qgd2lkdGg9IjMwMCIgaGVpZ2h0PSI2MDAiIGZpbGw9IiMwMDIzOTUiLz48L3N2Zz4K');
INSERT INTO public.information_langue (id, libelle, drapeau) VALUES ('EN', 'English', 'data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIj8+CjxzdmcgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIiB2aWV3Qm94PSIwIDAgNjAgMzAiIHdpZHRoPSIxMjAwIiBoZWlnaHQ9IjYwMCI+CjxjbGlwUGF0aCBpZD0icyI+Cgk8cGF0aCBkPSJNMCwwIHYzMCBoNjAgdi0zMCB6Ii8+CjwvY2xpcFBhdGg+CjxjbGlwUGF0aCBpZD0idCI+Cgk8cGF0aCBkPSJNMzAsMTUgaDMwIHYxNSB6IHYxNSBoLTMwIHogaC0zMCB2LTE1IHogdi0xNSBoMzAgeiIvPgo8L2NsaXBQYXRoPgo8ZyBjbGlwLXBhdGg9InVybCgjcykiPgoJPHBhdGggZD0iTTAsMCB2MzAgaDYwIHYtMzAgeiIgZmlsbD0iIzAxMjE2OSIvPgoJPHBhdGggZD0iTTAsMCBMNjAsMzAgTTYwLDAgTDAsMzAiIHN0cm9rZT0iI2ZmZiIgc3Ryb2tlLXdpZHRoPSI2Ii8+Cgk8cGF0aCBkPSJNMCwwIEw2MCwzMCBNNjAsMCBMMCwzMCIgY2xpcC1wYXRoPSJ1cmwoI3QpIiBzdHJva2U9IiNDODEwMkUiIHN0cm9rZS13aWR0aD0iNCIvPgoJPHBhdGggZD0iTTMwLDAgdjMwIE0wLDE1IGg2MCIgc3Ryb2tlPSIjZmZmIiBzdHJva2Utd2lkdGg9IjEwIi8+Cgk8cGF0aCBkPSJNMzAsMCB2MzAgTTAsMTUgaDYwIiBzdHJva2U9IiNDODEwMkUiIHN0cm9rZS13aWR0aD0iNiIvPgo8L2c+Cjwvc3ZnPgo=');


--
-- Data for Name: nature_fichier; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.nature_fichier (id, code, libelle) VALUES (1, 'THESE_PDF', 'Thèse au format PDF');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (2, 'FICHIER_NON_PDF', 'Fichier non PDF joint à une thèse (ex: vidéo)');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (3, 'PV_SOUTENANCE', 'PV de soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (4, 'RAPPORT_SOUTENANCE', 'Rapport de soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (5, 'DEMANDE_CONFIDENT', 'Demande de confidentialité');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (6, 'PROLONG_CONFIDENT', 'Demande de prolongation de confidentialité');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (7, 'PRE_RAPPORT_SOUTENANCE', 'Pré-rapport de soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (8, 'CONV_MISE_EN_LIGNE', 'Convention de mise en ligne');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (9, 'AVENANT_CONV_MISE_EN_LIGNE', 'Avenant à la convention de mise en ligne');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (22, 'COMMUNS', 'Fichier commun non lié à une thèse (ex: modèle d''avenant à la convention de MEL)');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (61, 'JUSTIFICATIF_HDR', 'Justificatif d''habilitation à diriger des recherches');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (62, 'DELOCALISATION_SOUTENANCE', 'Formulaire de délocalisation de soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (63, 'DELEGUATION_SIGNATURE', 'Formulaire de délégation de signature du rapport de soutenance (visioconférence)');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (64, 'DEMANDE_LABEL_EUROPEEN', 'Formulaire de demande de label européen');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (65, 'DEMANDE_LANGUE_ANGLAISE', 'Formulaire de demande de manuscrit ou de soutenance en anglais');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (66, 'JUSTIFICATIF_EMERITAT', 'Justificatif d''émeritat');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (67, 'AUTRES_JUSTIFICATIFS', 'Autres justificatifs concernant la soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (68, 'JUSTIFICATIF_HDR', 'Justificatif d''habilitation à diriger des recherches');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (69, 'DELOCALISATION_SOUTENANCE', 'Formulaire de délocalisation de soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (70, 'DELEGUATION_SIGNATURE', 'Formulaire de délégation de signature du rapport de soutenance (visioconférence)');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (71, 'DEMANDE_LABEL_EUROPEEN', 'Formulaire de demande de label européen');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (72, 'DEMANDE_LANGUE_ANGLAISE', 'Formulaire de demande de manuscrit ou de soutenance en anglais');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (73, 'JUSTIFICATIF_EMERITAT', 'Justificatif d''émeritat');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (74, 'AUTRES_JUSTIFICATIFS', 'Autres justificatifs concernant la soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (101, 'SIGNATURE_CONVOCATION', 'Signature pour la convocation à la soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (81, 'SIGNATURE_CONVOCATION', 'Signature pour la convocation à la soutenance');
INSERT INTO public.nature_fichier (id, code, libelle) VALUES (41, 'RAPPORT_ANNUEL', 'Rapport annuel');


--
-- Data for Name: privilege; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (481, 3100, 'voir-origine-non-visible', 'Voir les origines de financement masquées', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (524, 101, 'proposition-sursis', 'Accorder un sursis pour la validation d''une Modifier la proposition de soutenance', 500);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (517, 101, 'proposition-presidence', 'Générer document pour la signature par la présidence', 34);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (518, 101, 'avis-annuler', 'Annuler un avis de soutenance', 400);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (519, 101, 'avis-notifier', 'Notifier les demandes d''avis de soutenance', 500);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (520, 101, 'index-global', 'Accès à l''index global', 1);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (521, 101, 'index-acteur', 'Accès à l''index acteur', 2);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (500, 101, 'modification-date-rapport', 'Modification de la date de rendu des rapports', 50);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (501, 101, 'association-membre-individu', 'Associer des individus aux membres de jury', 50);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (502, 101, 'proposition-visualisation', 'Visualier de la proposition de soutenance', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (503, 101, 'proposition-modification', 'Modifier la proposition de soutenance', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (504, 101, 'proposition-validation-acteur', 'Valider/Annuler la proposition de soutenance (acteur)', 30);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (505, 101, 'proposition-validation-ed', 'Valider/Annuler la proposition de soutenance (ecole-doctorale)', 31);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (506, 101, 'proposition-validation-ur', 'Valider/Annuler la proposition de soutenance (unite-recherche)', 32);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (507, 101, 'proposition-validation-bdd', 'Valider/Annuler la proposition de soutenance (bureau-doctorat)', 33);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (508, 101, 'engagement-impartialite-signer', 'Signer l''engagement d''impartialité ', 130);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (509, 101, 'engagement-impartialite-annuler', 'Annuler une signature  d''engagement d''impartialité', 140);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (510, 101, 'engagement-impartialite-visualiser', 'Visualiser un engagement d''impartialité', 100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (511, 101, 'engagement-impartialite-notifier', 'Notifier des demandes de signature d''engagement d''impartialité', 110);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (512, 101, 'presoutenance-visualisation', 'Visualiser les informations associées à la présoutenance', 45);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (513, 101, 'avis-visualisation', 'Visualiser l''avis de soutenance et au rapport de présoutenance', 200);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (514, 101, 'avis-modifier', 'Modifier l''avis de soutenance et le rapport de présoutenance', 300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (522, 101, 'index-rapporteur', 'Accès à l''index rapporteur', 3);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (515, 101, 'qualite-visualisation', 'Visualiser les qualités renseignées', 400);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (516, 101, 'qualite-modification', 'Ajout/Modification des qualités ', 410);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (523, 101, 'index-structure', 'Accès à l''index structure', 4);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (421, 102, 'co-encadrant_afficher', 'Affichage des historiques de co-encadrants', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (422, 102, 'co-encadrant_gerer', 'Gérer les co-encadrants', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (343, 47, 'televerser', 'Téléversement de fichier commun non lié à une thèse (ex: avenant à la convention de MEL)', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (344, 47, 'telecharger', 'Téléchargement de fichier commun non lié à une thèse (ex: avenant à la convention de MEL)', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (461, 3080, 'gestion-president', 'Affichage de la gestion des Présidents du jury', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (425, 4, 'afficher-mail-contact', 'Afficher le mail de contact', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (381, 3, 'consultation-page-couverture', 'Consultation de la page de couverture', 3026);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (462, 3080, 'modifier-mail-president', 'Modification de l''email des Présidents du jury', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (463, 3080, 'notifier-president', 'Notification des Présidents du jury', 30);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (273, 50, 'edition', 'Édition des indicateurs', 40);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (35, 50, 'consultation-statistique', 'Consultation des statistique', 1000);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (15, 5, 'create_from_individu', 'Créer un utilisateur ''local'' à partir d''un utilisateur', 100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (482, 3101, 'intervention_index', 'Afficher la liste des interventions', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (483, 3101, 'intervention_afficher', 'Afficher une intervention', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (361, 3000, 'consulter', 'Consulter les rapports annuels d''une thèse', 250);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (362, 3000, 'televerser', 'Téléverser un rapport annuel de thèse', 300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (363, 3000, 'supprimer', 'Supprimer un rapport annuel de thèse', 350);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (364, 3000, 'telecharger', 'Télécharger un rapport annuel de thèse', 400);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (161, 24, 'version-papier-corrigee', 'Validation de la remise de la version papier corrigée', 4300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (81, 3, 'telechargement-fichier', 'Téléchargement de fichier déposé', 3060);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (82, 3, 'consultation-fiche', 'Consultation de la fiche d''identité de la thèse', 3025);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (83, 3, 'consultation-depot', 'Consultation du dépôt de la thèse', 3026);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (84, 3, 'consultation-description', 'Consultation de la description de la thèse', 3027);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (85, 3, 'consultation-archivage', 'Consultation de l''archivage de la thèse', 3028);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (86, 3, 'consultation-rdv-bu', 'Consultation du rendez-vous BU', 3029);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (365, 3000, 'telecharger-zip', 'Télécharger des rapports annuels de thèse sous la forme d''une archive compressée (.zip)', 410);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (88, 24, 'rdv-bu', 'Validation suite au rendez-vous à la BU', 3035);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (366, 3000, 'rechercher', 'Rechercher des rapports annuels de thèse', 500);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (367, 3001, 'consulter', 'Consulter une liste de diffusion', 250);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (96, 23, 'modification', 'Modification de la FAQ', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (1, 1, 'role-visualisation', 'Rôles - Visualisation', 1);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (2, 1, 'role-edition', 'Rôles - Édition', 2);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (3, 1, 'privilege-visualisation', 'Privilèges - Visualisation', 3);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (4, 1, 'privilege-edition', 'Privilèges - Édition', 4);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (6, 2, 'ecarts', 'Écarts entre les données de l''application et ses sources', 1);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (9, 2, 'vues-procedures', 'Mise à jour des vues différentielles et des procédures de mise à jour', 4);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (8, 2, 'tbl', 'Tableau de bord principal', 3);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (7, 2, 'maj', 'Mise à jour des données à partir de leurs sources', 2);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (11, 4, 'modification-persopass', 'Modification du persopass', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (14, 5, 'attribution-role', 'Attribution de rôle aux utilisateurs', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (41, 3, 'saisie-description-version-initiale', 'Saisie de la description de la thèse', 3040);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (49, 3, 'saisie-description-version-corrigee', 'Saisie de la description de version corrigée', 3041);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (42, 3, 'saisie-autorisation-diffusion-version-initiale', 'Saisie du formulaire d''autorisation de diffusion de la version initiale', 3090);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (48, 3, 'saisie-autorisation-diffusion-version-corrigee', 'Saisie du formulaire d''autorisation de diffusion de la version corrigée', 3091);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (43, 3, 'depot-version-initiale', 'Dépôt de la version initiale de la thèse', 3050);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (44, 3, 'edition-convention-mel', 'Edition de la convention de mise en ligne', 3070);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (45, 3, 'saisie-mot-cle-rameau', 'Saisie des mots-clés RAMEAU', 3030);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (46, 5, 'consultation', 'Consultation des utilisateurs', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (47, 3, 'recherche', 'Recherche de thèses', 3010);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (61, 3, 'saisie-conformite-version-archivage-initiale', 'Juger de la conformité de la version retraitée', 3080);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (62, 3, 'saisie-conformite-version-archivage-corrigee', 'Juger de la conformité de la version corrigée retraitée', 3081);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (90, 24, 'rdv-bu-suppression', 'Suppression de la validation concernant le rendez-vous à la BU', 3036);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (368, 3001, 'lister', 'Lister les listes de diffusion', 300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (484, 3101, 'intervention_modifier', 'Déclarer/Modifier une intervention', 30);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (95, 5, 'modification', 'Modification d''utilisateur', 110);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (137, 3, 'depot-version-corrigee', 'Dépôt de la version corrigée de la thèse', 3055);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (127, 24, 'depot-these-corrigee', 'Validation du dépôt de la thèse corrigée', 4000);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (128, 24, 'depot-these-corrigee-suppression', 'Suppression de la validation du dépôt de la thèse corrigée', 4120);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (157, 3, 'fichier-divers-televerser', 'Téléverser un fichier comme le PV ou le rapport de soutenance, la demande de confidentialité, etc.', 100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (160, 3, 'fichier-divers-consulter', 'Télécharger/consulter un fichier comme le PV ou le rapport de soutenance, la demande de confidentialité, etc.', 150);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (177, 3, 'export-csv', 'Export des thèses au format CSV', 3020);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (197, 3, 'saisie-rdv-bu', 'Modification des informations rendez-vous BU', 3029);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (129, 24, 'correction-these', 'Validation des corrections de la thèse', 4100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (130, 24, 'correction-these-suppression', 'Suppression de la validation des corrections de la thèse', 4120);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (198, 3, 'saisie-attestations-version-initiale', 'Modification des attestations', 3030);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (199, 3, 'saisie-attestations-version-corrigee', 'Modification des attestations concernant la version corrigée', 3031);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (485, 3102, 'justificatif_index ', 'Index des justificatifs', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (486, 3102, 'justificatif_ajouter', 'Ajouter un justificatif la liste des interventions', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (22, 24, 'page-de-couverture', 'Validation de la page de couverture', 3030);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (260, 24, 'page-de-couverture-suppr', 'Suppression de la validation de la page de couverture', 3031);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (270, 50, 'consultation', 'Consultation des indicateurs', 10);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (271, 50, 'exportation', 'Exportation des indicateurs', 20);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (272, 50, 'rafraichissement', 'Rafraîchissement des indicateurs', 30);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (402, 100, 'creation-ur', 'Création d''unité de recherche', 102);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (404, 100, 'consultation-de-toutes-les-structures', 'Consultation de toutes les structures', 1000);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (403, 100, 'creation-etab', 'Création d''établissement', 100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (405, 100, 'consultation-de-ses-structures', 'Consultation de ses structures', 1100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (406, 100, 'modification-de-toutes-les-structures', 'Modification de toutes les structures', 1200);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (407, 100, 'modification-de-ses-structures', 'Modification de ses structures', 1300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (408, 3, 'consultation-de-toutes-les-theses', 'Consultation de toutes les thèses', 1000);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (409, 3, 'consultation-de-ses-theses', 'Consultation de ses thèses', 1100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (401, 100, 'creation-ed', 'Création d''école doctorale', 101);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (410, 3, 'modification-de-toutes-les-theses', 'Modification de toutes les thèses', 1200);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (411, 3, 'modification-de-ses-theses', 'Modification de ses thèses', 1300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (281, 3, 'refresh-these', 'Réimporter la thèse', 3000);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (250, 19, 'automatique', 'Substitution automatique de structures', 100);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (487, 3102, 'justificatif_retirer', 'Retirer un justificatif la liste des interventions', 30);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (321, 3, 'saisie-correc-autorisee-forcee', 'Modification du témoin de correction autorisée forcée', 3045);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (10, 7, 'modifier-information', 'Modifier les pages d''information ', 50);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (36, 19, 'consultation-toutes-structures', 'Consultation de toutes les substitutions', 200);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (37, 19, 'consultation-sa-structure', 'Consultation de la substitution de sa structure', 300);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (38, 19, 'modification-toutes-structures', 'Modification de toutes les substitutions ', 400);
INSERT INTO public.privilege (id, categorie_id, code, libelle, ordre) VALUES (39, 19, 'modification-sa-structure', 'Modification de la substitution de sa structure', 500);


--
-- Data for Name: type_structure; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.type_structure (id, code, libelle) VALUES (1, 'etablissement', 'Établissement');
INSERT INTO public.type_structure (id, code, libelle) VALUES (2, 'ecole-doctorale', 'École doctorale');
INSERT INTO public.type_structure (id, code, libelle) VALUES (3, 'unite-recherche', 'Unité de recherche');


--
-- Data for Name: profil; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (1, 'Unité de recherche', 'UR', 3, NULL, 40);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (2, 'École doctorale', 'ED', 2, NULL, 30);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (3, 'Administrateur', 'ADMIN', 1, NULL, 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (4, 'Bureau des doctorats', 'BDD', 1, NULL, 20);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (5, 'Bibliothèque universitaire', 'BU', 1, NULL, 10);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (101, 'Rapporteur Absent', 'A', 1, NULL, 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (41, 'Président du jury', 'P', 1, NULL, 300);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (6, 'Administrateur technique', 'ADMIN_TECH', NULL, NULL, 0);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (7, 'Doctorant', 'DOCTORANT', NULL, NULL, 100);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (8, 'Observateur', 'OBSERV', NULL, NULL, 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (9, 'Directeur de thèse', 'D', NULL, NULL, 200);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (10, 'Co-directeur', 'K', NULL, NULL, 210);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (11, 'Rapporteur', 'R', NULL, NULL, 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (12, 'Membre', 'M', NULL, NULL, 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (61, 'Doctorant sans dépôt', 'NODEPOT', NULL, 'Rôle de doctorant temporaire', 1000);
INSERT INTO public.profil (id, libelle, role_id, structure_type, description, ordre) VALUES (21, 'Observatoire', 'OBSERVATOIRE', NULL, NULL, 1000);


--
-- Data for Name: profil_privilege; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (421, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (422, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (506, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (523, 1);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (421, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (422, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (505, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (523, 2);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (11, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (15, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (367, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (368, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (407, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 3);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (1, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (3, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (10, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (15, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (22, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (41, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (42, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (43, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (44, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (45, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (46, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (48, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (49, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (61, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (62, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (88, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (90, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (96, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (127, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (128, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (130, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (137, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (157, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (160, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (161, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (197, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (198, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (199, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (260, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (281, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (321, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (343, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (344, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (361, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (362, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (363, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (364, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (365, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (366, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (406, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (407, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (410, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (411, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (421, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (422, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (461, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (462, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (463, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (481, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (482, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (483, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (484, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (500, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (501, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (507, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (509, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (511, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (517, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (518, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (519, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (523, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (524, 4);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (1, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (3, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (10, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (22, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (41, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (42, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (43, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (44, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (45, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (46, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (48, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (49, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (61, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (62, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (88, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (90, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (96, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (127, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (128, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (130, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (137, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (157, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (160, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (161, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (197, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (198, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (199, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (260, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (281, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (321, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (343, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (344, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (406, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (407, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (410, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (411, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 5);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (1, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (2, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (3, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (4, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (6, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (7, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (8, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (9, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (10, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (11, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (14, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (15, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (22, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (36, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (37, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (38, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (39, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (41, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (42, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (43, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (44, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (45, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (46, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (48, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (49, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (61, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (62, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (88, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (90, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (95, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (96, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (127, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (128, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (129, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (130, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (137, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (157, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (160, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (161, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (197, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (198, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (199, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (250, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (260, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (272, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (273, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (281, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (321, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (343, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (344, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (361, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (362, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (363, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (364, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (365, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (366, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (367, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (368, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (401, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (402, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (403, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (406, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (407, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (410, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (411, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (421, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (422, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (425, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (461, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (462, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (463, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (481, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (482, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (483, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (484, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (485, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (486, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (487, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (500, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (501, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (503, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (504, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (505, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (506, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (507, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (508, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (509, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (511, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (512, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (514, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (515, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (516, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (517, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (518, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (519, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (523, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (524, 6);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (11, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (41, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (42, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (43, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (44, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (48, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (49, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (61, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (62, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (127, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (129, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (137, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (197, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (198, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (199, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (361, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (362, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (364, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (365, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (366, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (411, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (425, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (483, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (486, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (487, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (503, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (504, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (521, 7);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (160, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (361, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (362, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (363, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (364, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (523, 8);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (483, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (484, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (486, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (487, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (503, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (504, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (521, 9);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (47, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (483, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (486, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (487, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (503, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (504, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (521, 10);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (508, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (514, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (522, 11);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 12);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (381, 12);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (35, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (160, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (270, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (271, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (404, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (405, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (408, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 21);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 41);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (129, 41);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 41);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (522, 41);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (11, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (81, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (82, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (83, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (84, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (85, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (86, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (127, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (129, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (177, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (366, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (409, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (425, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (502, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (503, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (504, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (510, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (513, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (520, 61);
INSERT INTO public.profil_privilege (privilege_id, profil_id) VALUES (521, 61);


--
-- Data for Name: soutenance_configuration; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (1, 'AVIS_DEADLINE', 'Nombre de jours avant soutenance pour le retour des rapports', '14');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (2, 'JURY_SIZE_MIN', 'Nombre minimal de membre de jury et de rapporteur', '4');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (3, 'JURY_SIZE_MAX', 'Nombre maximal de membre de jury et de rapporteur', '8');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (4, 'JURY_RAPPORTEUR_SIZE_MIN', 'Nombre minimal de rapporteur', '2');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (5, 'JURY_RANGA_RATIO_MIN', 'Ratio minimal de membre de rang A', '0.5');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (6, 'JURY_EXTERIEUR_RATIO_MIN', 'Ratio minimal de membre exterieur', '0.50');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (7, 'JURY_PARITE_RATIO_MIN', 'Ratio minimal sur la parity du jury', '0');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (8, 'PROPOSITION_ORDRE_VALIDATION_ACTEUR', 'Ordre de validation de la proposition pour les acteurs directs', '1');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (9, 'PROPOSITION_ORDRE_VALIDATION_UR', 'Ordre de validation de la proposition pour l''unité de recherche', '2');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (10, 'PROPOSITION_ORDRE_VALIDATION_ED', 'Ordre de validation de la proposition pour l''école doctorale', '3');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (11, 'PROPOSITION_ORDRE_VALIDATION_BDD', 'Ordre de validation de la proposition pour le bureau des doctorats', '4');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (12, 'PROPOSITION_ORDRE_VALIDATION_PRESIDENT', 'Ordre de validation de la proposition pour le président', '-1');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (13, 'FORMULAIRE_DELOCALISATION', 'Formulaire de demande de délocalisation de la soutenance', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/11322');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (14, 'FORMULAIRE_DELEGUATION', 'Formulaire de demande de déléguation de signature', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/11321');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (15, 'FORMULAIRE_LABEL_EUROPEEN', 'Formulaire de demande de label européen', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/11325');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (16, 'FORMULAIRE_THESE_ANGLAIS', 'Formulaire de demande de rédaction en anglais', 'https://sygal-test.normandie-univ.fr/informations/fichiers/telecharger/1541');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (17, 'FORMULAIRE_CONFIDENTIALITE', 'Formulaire de de mande de confidentialité', 'https://sygal.normandie-univ.fr/informations/fichiers/telecharger/11324');
INSERT INTO public.soutenance_configuration (id, code, libelle, valeur) VALUES (18, 'PERIODE_INTERVENTION_DIRECTEUR', 'Période autorisant les directeurs à intervenir', '7');


--
-- Data for Name: soutenance_etat; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.soutenance_etat (id, code, libelle, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (1, 'EN_COURS', 'En cours d''examen', '2020-09-21 10:50:03', 1, '2020-09-21 10:50:03', 1, NULL, NULL);
INSERT INTO public.soutenance_etat (id, code, libelle, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (2, 'VALIDEE', 'Soutenance autorisée', '2020-09-21 10:50:04', 1, '2020-09-21 10:50:04', 1, NULL, NULL);
INSERT INTO public.soutenance_etat (id, code, libelle, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (3, 'REJETEE', 'Soutenance rejetée', '2020-09-21 10:50:04', 1, '2020-09-21 10:50:04', 1, NULL, NULL);


--
-- Data for Name: soutenance_qualite; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (7, 'Professeur émerite', 'A', 'O', 'O', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (8, 'Chargé de Recherche (HDR)', 'B', 'O', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (9, 'Ingénieur de Recherche ', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (10, 'Ingénieur de Recherche (HDR)', 'B', 'O', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (11, 'Ingénieur d''Etude ', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (0, 'Qualité inconnue', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (12, 'Autre', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (1, 'Professeur des universités', 'A', 'O', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (2, 'Directeur de recherche', 'A', 'O', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (4, 'Maître de conférences', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (5, 'Chargé de recherche', 'B', 'N', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);
INSERT INTO public.soutenance_qualite (id, libelle, rang, hdr, emeritat, histo_creation, histo_createur_id, histo_modification, histo_modificateur_id, histo_destruction, histo_destructeur_id) VALUES (6, 'Maître de conférences (HDR)', 'B', 'O', 'N', '2020-09-21 11:05:34', 1, '2020-09-21 11:05:34', 1, NULL, NULL);


--
-- Data for Name: type_validation; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.type_validation (id, code, libelle) VALUES (1, 'RDV_BU', 'Validation suite au rendez-vous avec le doctorant');
INSERT INTO public.type_validation (id, code, libelle) VALUES (2, 'DEPOT_THESE_CORRIGEE', 'Validation automatique du dépôt de la thèse corrigée');
INSERT INTO public.type_validation (id, code, libelle) VALUES (3, 'CORRECTION_THESE', 'Validation par le président du jury des corrections de la thèse');
INSERT INTO public.type_validation (id, code, libelle) VALUES (4, 'VERSION_PAPIER_CORRIGEE', 'Confirmation dépot de la version papier corrigée');
INSERT INTO public.type_validation (id, code, libelle) VALUES (5, 'PAGE_DE_COUVERTURE', 'Validation de la page de couverture');
INSERT INTO public.type_validation (id, code, libelle) VALUES (6, 'PROPOSITION_SOUTENANCE', 'Validation de la proposition de soutenance');
INSERT INTO public.type_validation (id, code, libelle) VALUES (8, 'ENGAGEMENT_IMPARTIALITE', 'Signature de l''engagement d''impartialité');
INSERT INTO public.type_validation (id, code, libelle) VALUES (9, 'VALIDATION_PROPOSITION_ED', 'Validation de la proposition de soutenance par l''école doctorale');
INSERT INTO public.type_validation (id, code, libelle) VALUES (10, 'VALIDATION_PROPOSITION_UR', 'Validation de la proposition de soutenance par l''unité de recherche');
INSERT INTO public.type_validation (id, code, libelle) VALUES (11, 'VALIDATION_PROPOSITION_BDD', 'Validation de la proposition de soutenance par le bureau des doctorats');
INSERT INTO public.type_validation (id, code, libelle) VALUES (12, 'AVIS_SOUTENANCE', 'Signature de l''avis de soutenance');
INSERT INTO public.type_validation (id, code, libelle) VALUES (13, 'REFUS_ENGAGEMENT_IMPARTIALITE', 'Refus de l''engagement d''impartialité');


--
-- Data for Name: version_fichier; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.version_fichier (id, code, libelle) VALUES (1, 'VA', 'Version d''archivage');
INSERT INTO public.version_fichier (id, code, libelle) VALUES (2, 'VD', 'Version de diffusion');
INSERT INTO public.version_fichier (id, code, libelle) VALUES (3, 'VO', 'Version originale');
INSERT INTO public.version_fichier (id, code, libelle) VALUES (4, 'VAC', 'Version d''archivage corrigée');
INSERT INTO public.version_fichier (id, code, libelle) VALUES (5, 'VDC', 'Version de diffusion corrigée');
INSERT INTO public.version_fichier (id, code, libelle) VALUES (6, 'VOC', 'Version originale corrigée');


--
-- Data for Name: wf_etape; Type: TABLE DATA; Schema: public; Owner: ad_sygal
--

INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (1, 'DEPOT_VERSION_ORIGINALE', 10, 1, 1, 'these/depot', 'Téléversement de la thèse', 'Téléversement de la thèse', 'Téléversement de la thèse non effectué', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (2, 'AUTORISATION_DIFFUSION_THESE', 20, 1, 1, 'these/depot', 'Autorisation de diffusion de la thèse', 'Autorisation de diffusion de la thèse', 'Autorisation de diffusion non remplie', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (3, 'SIGNALEMENT_THESE', 30, 1, 1, 'these/description', 'Signalement de la thèse', 'Signalement de la thèse', 'Signalement non renseigné', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (4, 'ARCHIVABILITE_VERSION_ORIGINALE', 40, 1, 1, 'these/archivage', 'Archivabilité de la thèse', 'Archivabilité de la thèse', 'Archivabilité non testée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (5, 'DEPOT_VERSION_ARCHIVAGE', 50, 2, 1, 'these/archivage', 'Téléversement d''une version retraitée de la thèse', 'Téléversement d''une version retraitée de la thèse', 'Téléversement d''une version retraitée non effectué', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (6, 'ARCHIVABILITE_VERSION_ARCHIVAGE', 60, 2, 1, 'these/archivage', 'Archivabilité de la version retraitée de la thèse', 'Archivabilité de la version retraitée de la thèse', 'Archivabilité de la version retraitée non testée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (7, 'VERIFICATION_VERSION_ARCHIVAGE', 70, 2, 1, 'these/archivage', 'Vérification de la version retraitée de la thèse', 'Vérification de la version retraitée de la thèse', 'Vérification de la version retraitée non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (8, 'RDV_BU_SAISIE_DOCTORANT', 80, 1, 1, 'these/rdv-bu', 'Saisie des coordonnées et disponibilités du doctorant pour le rendez-vous à la bibliothèque universitaire', 'Saisie des coordonnées et disponibilités du doctorant pour le rendez-vous à la bibliothèque universitaire', 'Saisie des coordonnées et disponibilités pour le rendez-vous à la BU non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (9, 'RDV_BU_SAISIE_BU', 90, 1, 1, 'these/rdv-bu', 'Saisie des informations pour la bibliothèque universitaire', 'Saisie des informations pour la bibliothèque universitaire', 'Saisie infos BU non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (10, 'RDV_BU_VALIDATION_BU', 100, 1, 1, 'these/rdv-bu', 'Validation', 'Validation', 'Validation de la BU non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (11, 'ATTESTATIONS', 15, 1, 1, 'these/depot', 'Attestations', 'Attestations', 'Attestations non renseignées', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (12, 'VALIDATION_PAGE_DE_COUVERTURE', 8, 1, 1, 'these/validation-page-de-couverture', 'Validation de la page de couverture', 'Validation de la page de couverture', 'Validation de la page de couverture non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (31, 'DEPOT_VERSION_ORIGINALE_CORRIGEE', 200, 1, 1, 'these/depot-version-corrigee', 'Téléversement de la thèse corrigée', 'Téléversement de la thèse corrigée', 'Téléversement de la thèse corrigée non effectué', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (32, 'ARCHIVABILITE_VERSION_ORIGINALE_CORRIGEE', 240, 1, 1, 'these/archivage-version-corrigee', 'Archivabilité de la version originale de la thèse corrigée', 'Archivabilité de la version originale de la thèse corrigée', 'Archivabilité de la version originale de la thèse corrigée non testée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (33, 'DEPOT_VERSION_ARCHIVAGE_CORRIGEE', 250, 2, 1, 'these/archivage-version-corrigee', 'Téléversement d''une version retraitée de la thèse corrigée', 'Téléversement d''une version retraitée de la thèse corrigée', 'Téléversement d''une version retraitée de la thèse corrigée non effectué', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (34, 'ARCHIVABILITE_VERSION_ARCHIVAGE_CORRIGEE', 260, 2, 1, 'these/archivage-version-corrigee', 'Archivabilité de la version retraitée de la thèse corrigée', 'Archivabilité de la version retraitée de la thèse corrigée', 'Archivabilité de la version retraitée de la thèse corrigée non testée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (35, 'VERIFICATION_VERSION_ARCHIVAGE_CORRIGEE', 270, 2, 1, 'these/archivage-version-corrigee', 'Vérification de la version retraitée de la thèse corrigée', 'Vérification de la version retraitée de la thèse corrigée', 'Vérification de la version retraitée de la thèse corrigée non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (38, 'DEPOT_VERSION_CORRIGEE_VALIDATION_DOCTORANT', 280, 1, 1, 'these/validation-these-corrigee', 'Validation automatique du dépôt de votre thèse corrigée', 'Validation automatique du dépôt de la thèse corrigée', 'Validation automatique du dépôt de la thèse corrigée non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (39, 'DEPOT_VERSION_CORRIGEE_VALIDATION_DIRECTEUR', 290, 1, 1, 'these/validation-these-corrigee', 'Validation de la thèse corrigée par le président du jury', 'Validation de la thèse corrigée par le président du jury', 'Validation de la thèse corrigée par le président du jury non effectuée', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (51, 'ATTESTATIONS_VERSION_CORRIGEE', 210, 1, 1, 'these/depot-version-corrigee', 'Attestations version corrigée', 'Attestations version corrigée', 'Attestations version corrigée non renseignées', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (52, 'AUTORISATION_DIFFUSION_THESE_VERSION_CORRIGEE', 220, 1, 1, 'these/depot-version-corrigee', 'Autorisation de diffusion de la version corrigée', 'Autorisation de diffusion de la version corrigée', 'Autorisation de diffusion de la version corrigée non remplie', NULL);
INSERT INTO public.wf_etape (id, code, ordre, chemin, obligatoire, route, libelle_acteur, libelle_autres, desc_non_franchie, desc_sans_objectif) VALUES (60, 'REMISE_EXEMPLAIRE_PAPIER_THESE_CORRIGEE', 300, 1, 1, 'these/version-papier', 'Remise de l''exemplaire papier de la thèse corrigée', 'Remise de l''exemplaire papier de la thèse corrigée', 'Remise de l''exemplaire papier de la thèse corrigée', NULL);


--
-- PostgreSQL database dump complete
--

