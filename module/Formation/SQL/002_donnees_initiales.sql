INSERT INTO FORMATION_ETAT (CODE, LIBELLE, DESCRIPTION, ICONE, COULEUR, ORDRE) VALUES ('P', 'En préparation', 'Formation en cours de préparation', 'glyphicon glyphicon-time', '#cc9200', 1);
INSERT INTO FORMATION_ETAT (CODE, LIBELLE, DESCRIPTION, ICONE, COULEUR, ORDRE) VALUES ('O', 'Inscription ouverte', null, 'glyphicon glyphicon-ok-circle', '#11cc00', 2);
INSERT INTO FORMATION_ETAT (CODE, LIBELLE, DESCRIPTION, ICONE, COULEUR, ORDRE) VALUES ('F', 'Inscription fermée', null, 'glyphicon glyphicon-ban-circle', '#008fcc', 3);
INSERT INTO FORMATION_ETAT (CODE, LIBELLE, DESCRIPTION, ICONE, COULEUR, ORDRE) VALUES ('A', 'Session annulée', 'La session a été annulée', 'icon icon-historiser', '#cc0000', 5);
INSERT INTO FORMATION_ETAT (CODE, LIBELLE, DESCRIPTION, ICONE, COULEUR, ORDRE) VALUES ('C', 'Close', 'Formation close', null, null, 4);

INSERT INTO nature_fichier (id, code, libelle) VALUES (nextval(nature_fichier_id_seq), 'SIGNATURE_FORMATION', 'Signature pour les formations');