
---------------------------------------------- individu_role_etablissement ----------------------------------------------

--
-- Abandon de INDIVIDU.ETABLISSEMENT_ID,
--            INDIVIDU_COMPL.ETABLISSEMENT_ID,
--            INDIVIDU_COMPL.UNITE_ID
-- au profit de ACTEUR.ETABLISSEMENT_ID
--              ACTEUR.ETABLISSEMENT_FORCE_ID (forçage/remplacement de l'établissement importé avec l'acteur),
--              ACTEUR.UNITE_RECH_ID (saisie manuelle de l'UR de l'acteur, car pas importée),
--              INDIVIDU_ROLE_ETABLISSEMENT.ETABLISSEMENT_ID (périmètre, pour les gest/resp ED/UR par ex).
--
alter table acteur rename column acteur_etablissement_id to etablissement_id;
alter table acteur rename column acteur_uniterech_id to unite_rech_id;
alter table acteur add column etablissement_force_id bigint constraint acteur_etablissement_force_fk references etablissement;
alter table acteur add column refonte_site bool default false not null;

-- individu_compl.etablissement ==> acteur.etablissement_force_id
update acteur a
set etablissement_force_id = ic.etablissement_id,
    histo_modification = current_timestamp,
    histo_modificateur_id = 1,
    refonte_site = true
from individu_compl ic
where a.individu_id = ic.individu_id and
    ic.etablissement_id is not null and
    (a.etablissement_id is null or a.etablissement_id <> ic.etablissement_id);

-- individu_compl.unite_id ==> acteur.unite_rech_id
update acteur a
set unite_rech_id = ic.unite_id,
    histo_modification = current_timestamp,
    histo_modificateur_id = 1,
    refonte_site = true
from individu_compl ic
where a.individu_id = ic.individu_id and
    ic.unite_id is not null and
    (a.unite_rech_id is null or a.unite_rech_id <> ic.unite_id);

-- abandon de individu.etablissement_id (pour l'instant, renommages)
alter table individu rename column etablissement_id to z_etablissement_id;
-- abandon de individu_compl.etablissement_id et unite_id (pour l'instant, renommages)
alter table individu_compl rename column etablissement_id to z_etablissement_id;
alter table individu_compl rename column unite_id to z_unite_id;

--
-- Nouvelle table INDIVIDU_ROLE_PERIMETRE pour ne plus avoir à créer un doublon d'individu pour gérer les sites.
--
create table individu_role_etablissement
(
    id bigserial not null primary key,
    individu_role_id bigint constraint individu_role_etablissement_individu_role_id_fk references individu_role,
    etablissement_id bigint constraint individu_role_etablissement_etablissement_id_fk references etablissement
);
comment on table individu_role_etablissement is 'Ajout de périmètre à l''attribution de rôles aux individus.';
create unique index individu_role_etablissement_uindex on individu_role_etablissement (individu_role_id, etablissement_id);
create index individu_role_etablissement_individu_idx on individu_role_etablissement (individu_role_id);
create index individu_role_etablissement_role_idx on individu_role_etablissement (etablissement_id);
---> NB : la reprise de données pour alimenter individu_role_etablissement devra se faire à la main (cf. vue plus bas) !

--
-- Privilèges
--
insert into CATEGORIE_PRIVILEGE(ID, CODE, LIBELLE, ORDRE)
select nextval('categorie_privilege_id_seq'), 'acteur', 'Acteurs des thèses', 20;

insert into PRIVILEGE(ID, CATEGORIE_ID, CODE, LIBELLE, ORDRE)
with d(ordre, code, lib) as (
    select 2000, 'modifier-acteur-de-toutes-theses', 'Modifier les acteurs de n''importe quelle thèse' union
    select 2010, 'modifier-acteur-de-ses-theses', 'Modifier les acteurs des thèses qui me concernent'
)
select nextval('privilege_id_seq'), cp.id, d.code, d.lib, d.ordre
from d join CATEGORIE_PRIVILEGE cp on cp.CODE = 'acteur';

select privilege__grant_privilege_to_profile('acteur', 'modifier-acteur-de-ses-theses', 'GEST_ED');
select privilege__grant_privilege_to_profile('acteur', 'modifier-acteur-de-toutes-theses', 'BDD');
select privilege__grant_privilege_to_profile('acteur', 'modifier-acteur-de-toutes-theses', 'ADMIN_TECH');


--
-- Vue utile quand il faudra créer à la main les 'individu_role_etablissement' pour remplacer le bricolage des
-- doublons d'individus : elle liste ceux qui ont, pour le même rôle, 2 établissements différents.

-- => Pour chaque individu, il faudra créer 1 individu_role_etablissement par etablissement distinct,
--    avec l'insert généré par la requête.
--
with tmp as (
    select i.id as individu_id, i.nom_usuel, i.prenom1, ir.id as individu_role_id, r.id as role_id, r.libelle as role_libelle, r.code as role_code, s.sigle,
           coalesce(ic.z_etablissement_id, i.z_etablissement_id) as etablissement_id
    from individu i
             left join individu_compl ic on i.id = ic.individu_id
             join etablissement e on coalesce(ic.z_etablissement_id, i.z_etablissement_id) = e.id
             join individu_role ir on i.id = ir.individu_id
             join role r on ir.role_id = r.id and code in ('RESP_ED', 'RESP_UR')
             join structure s on r.structure_id = s.id
    order by nom_usuel
), doublons as (
    select nom_usuel, prenom1, role_code from tmp group by nom_usuel, prenom1, role_code having count(*) > 1
), req as (select tmp.individu_id,
                  tmp.nom_usuel,
                  tmp.prenom1,
                  tmp.individu_role_id,
                  tmp.role_id,
                  tmp.role_code,
                  tmp.sigle,
                  tmp.etablissement_id,
                  count(*) over (partition by tmp.nom_usuel, tmp.role_code, tmp.etablissement_id) <>
                  count(tmp.etablissement_id) over (partition by tmp.nom_usuel, tmp.role_code) as doublon,
                  'insert into individu_role_etablissement(individu_role_id,etablissement_id) values (' ||
                  individu_role_id || ',' || etablissement_id || ') on conflict do nothing ;'    as sql
           from tmp
                    join doublons d on lower(d.nom_usuel) = lower(tmp.nom_usuel)
           -- where individu_role_id in (14046,11266,1707 ,2966 ,7746 ,9    ,12266,12216,9446 ,8026 ,6    ,8366 ,7    ,1501)
           order by tmp.nom_usuel, role_code, individu_role_id
)
select * from req
where doublon is true
;
