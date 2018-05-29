
-- CATEGORIE_PRIVILEGE

INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (21, 'ecole-doctorale', 'École doctorale', 100);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (23, 'faq', 'FAQ', 10);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (1, 'droit', 'Gestion des droits', 1);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (2, 'import', 'Import', 10);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (3, 'these', 'Thèse', 20);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (4, 'doctorant', 'Doctorant', 30);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (5, 'utilisateur', 'Utilisateur', 5);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (22, 'unite-recherche', 'Unité de Recherche', 200);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (24, 'validation', 'Validations', 25);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (44, 'fichier-divers', 'Fichier divers', 40);
INSERT INTO CATEGORIE_PRIVILEGE (ID, CODE, LIBELLE, ORDRE) VALUES (20, 'etablissement', 'Établissement', 90);

-- PRIVILEGE

INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (81, 3, 'telechargement-fichier', 'Téléchargement de fichier déposé', 3060);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (82, 3, 'consultation-fiche', 'Consultation de la fiche d''identité de la thèse', 3025);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (83, 3, 'consultation-depot', 'Consultation du dépôt de la thèse', 3026);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (84, 3, 'consultation-description', 'Consultation de la description de la thèse', 3027);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (85, 3, 'consultation-archivage', 'Consultation de l''archivage de la thèse', 3028);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (86, 3, 'consultation-rdv-bu', 'Consultation du rendez-vous BU', 3029);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (87, 3, 'creation-zip', 'Création de l''archive ZIP', 3200);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (88, 24, 'rdv-bu', 'Validation suite au rendez-vous à la BU', 3035);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (91, 21, 'consultation', 'Consultation d''école doctorale', 100);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (92, 21, 'modification', 'Modification d''école doctorale', 110);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (96, 23, 'modification', 'Modification de la FAQ', 10);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (1, 1, 'role-visualisation', 'Rôles - Visualisation', 1);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (2, 1, 'role-edition', 'Rôles - Édition', 2);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (3, 1, 'privilege-visualisation', 'Privilèges - Visualisation', 3);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (4, 1, 'privilege-edition', 'Privilèges - Édition', 4);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (6, 2, 'ecarts', 'Écarts entre les données de l''application et ses sources', 1);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (9, 2, 'vues-procedures', 'Mise à jour des vues différentielles et des procédures de mise à jour', 4);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (8, 2, 'tbl', 'Tableau de bord principal', 3);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (7, 2, 'maj', 'Mise à jour des données à partir de leurs sources', 2);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (11, 4, 'modification-persopass', 'Modification du persopass', 10);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (14, 5, 'attribution-role', 'Attribution de rôle aux utilisateurs', 20);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (41, 3, 'saisie-description', 'Saisie de la description', 3040);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (42, 3, 'saisie-autorisation-diffusion', 'Saisie du formulaire d''autorisation de diffusion', 3090);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (43, 3, 'depot-version-initiale', 'Dépôt de la version initiale de la thèse', 3050);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (44, 3, 'edition-convention-mel', 'Edition de la convention de mise en ligne', 3070);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (45, 3, 'saisie-mot-cle-rameau', 'Saisie des mots-clés RAMEAU', 3030);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (46, 5, 'consultation', 'Consultation des utilisateurs', 10);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (47, 3, 'recherche', 'Recherche de thèses', 3010);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (61, 3, 'saisie-conformite-archivage', 'Juger de la conformité de la thèse pour archivage', 3080);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (90, 24, 'rdv-bu-suppression', 'Suppression de la validation concernant le rendez-vous à la BU', 3036);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (93, 22, 'consultation', 'Consultation d''Unité de Recherche', 100);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (94, 22, 'modification', 'Modification d''Unité de Recherche', 110);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (95, 5, 'modification', 'Modification d''utilisateur', 110);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (137, 3, 'depot-version-corrigee', 'Dépôt de la version corrigée de la thèse', 3055);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (127, 24, 'depot-these-corrigee', 'Validation du dépôt de la thèse corrigée', 4000);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (128, 24, 'depot-these-corrigee-suppression', 'Suppression de la validation du dépôt de la thèse corrigée', 4120);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (157, 44, 'televerser', 'Téléverser un fichier comme le PV ou le rapport de soutenance, la demande de confidentialité, etc.', 100);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (160, 44, 'consulter', 'Télécharger/consulter un fichier comme le PV ou le rapport de soutenance, la demande de confidentialité, etc.', 150);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (177, 3, 'export-csv', 'Export des thèses au format CSV', 3020);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (197, 3, 'saisie-rdv-bu', 'Modification des informations rendez-vous BU', 3029);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (129, 24, 'correction-these', 'Validation des corrections de la thèse', 4100);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (130, 24, 'correction-these-suppression', 'Suppression de la validation des corrections de la thèse', 4120);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (198, 3, 'saisie-attestations', 'Modification des attestations', 3030);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (12, 20, 'consultation', 'Consultation d''établissement', 100);
INSERT INTO PRIVILEGE (ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE) VALUES (13, 20, 'modification', 'Modification d''établissement', 110);


DECLARE
  maxid NUMBER;
  nextval NUMBER;
BEGIN
  select max(id) into maxid from PRIVILEGE;
  loop
    select PRIVILEGE_ID_SEQ.nextval into nextval from dual;
    EXIT WHEN maxid < nextval;
  end loop;
END;
/


-- ROLE_PRIVILEGE_MODELE

INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 1);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 3);
--INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 11);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 14);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 41);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 42);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 43);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 44);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 45);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 46);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 61);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 87);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 88);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 90);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 91);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 92);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 93);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 94);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 95);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 96);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 127);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 128);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 129);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 130);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 137);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 157);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 177);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 197);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 198);
--INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN', 217);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 1);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 2);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 3);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 4);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 6);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 7);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 8);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 9);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 11);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 14);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 41);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 42);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 43);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 44);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 45);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 46);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 61);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 87);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 88);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 90);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 91);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 92);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 93);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 94);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 95);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 96);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 127);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 128);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 129);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 130);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 137);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 157);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 177);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 197);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 198);
--INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ADMIN_TECH', 217);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 1);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 3);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 11);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 41);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 42);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 43);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 44);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 61);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 87);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 91);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 93);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 127);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 128);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 129);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 130);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 137);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 157);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 177);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 198);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BDD', 217);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 1);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 3);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 11);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 41);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 42);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 43);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 44);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 45);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 61);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 87);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 88);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 90);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 91);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 93);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 127);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 128);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 129);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 130);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 137);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 157);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 177);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 197);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 198);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('BU', 217);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 129);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('D', 197);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 11);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 41);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 42);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 43);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 44);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 61);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 127);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 128);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 137);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 160);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 197);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('DOCTORANT', 198);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 91);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 92);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('ED', 177);
-- INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 5);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 47);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 81);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 82);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 83);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 84);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 85);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 86);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 93);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 94);
INSERT INTO ROLE_PRIVILEGE_MODELE (ROLE_CODE, PRIVILEGE_ID) VALUES ('UR', 177);


-- ROLE_PRIVILEGE : application des modèles

insert into ROLE_PRIVILEGE (ROLE_ID, PRIVILEGE_ID)
  SELECT r.id, p.ID
    from ROLE_PRIVILEGE_MODELE rpm
    join role r on r.CODE = rpm.ROLE_CODE
    join PRIVILEGE p on p.id = rpm.PRIVILEGE_ID
;


/*
insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'ED', p.id
  from PRIVILEGE p where p.id in ( 47, 177, 82, 83, 84, 85, 86, 5, 81, 91, 92	)
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'UR', p.id
  from PRIVILEGE p where p.id in ( 47, 177, 82, 83, 84, 85, 86, 5, 81, 93, 94 )
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'ADMIN', p.id
  from PRIVILEGE p where p.id in ( 1, 3, 46, 14, 95, 96, 47, 177, 82, 83, 84, 85, 197, 86, 45, 198, 5, 41, 43, 137, 81, 44, 61, 42, 87, 88, 90, 127, 129, 128, 130, 217, 11, 157, 160, 91, 92, 93, 94 )
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'ADMIN_TECH', p.id
  from PRIVILEGE p
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'BU', p.id
  from PRIVILEGE p where p.id in ( 1, 3, 47, 177, 82, 83, 84, 85, 197, 86, 45, 198, 5, 41, 43, 137, 81, 44, 61, 42, 87, 88, 90, 127, 129, 128, 130, 217, 11, 157, 160, 91, 93 )
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'BDD', p.id
  from PRIVILEGE p where p.id in ( 1, 3, 47, 177, 82, 83, 84, 85, 86, 198, 5, 41, 43, 137, 81, 44, 61, 42, 87, 127, 129, 128, 130, 217, 11, 157, 160, 91, 93 )
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'DOCTORANT', p.id
  from PRIVILEGE p where p.id in ( 47, 82, 83, 84, 85, 197, 86, 198, 5, 41, 43, 137, 81, 44, 61, 42, 127, 128, 11, 160 )
;

insert into ROLE_PRIVILEGE_MODELE(ROLE_CODE, PRIVILEGE_ID)
  select 'D', p.id
  from PRIVILEGE p where p.id in ( 47, 82, 83, 84, 85, 197, 86, 81, 129, 160 )
;
*/