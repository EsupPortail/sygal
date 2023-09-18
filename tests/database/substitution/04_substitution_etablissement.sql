--
-- Substitutions
--

--=============================== ETABLISSEMENT ================================-

--
-- NOTE IMPORTANTE :
-- Le meilleur attribut candidat pour la détection de doublons d'établissements est le "code établissement"
-- (ex : '0132133Y' pour AIX-MARSEILLE UNIVERSITE). Ce code réside dans la table des structures (colonne 'code')
-- et non dans la table des établissements.
--


--
-- Vue listant les clés étrangères (FK) pointant vers 'etablissement'
-- dont la valeur doit être remplacée par l'id substituant éventuel.
--
-- drop view v_substit_foreign_keys_etablissement;
create or replace view v_substit_foreign_keys_etablissement as
select * from v_substit_foreign_keys
where target_table = 'etablissement'
  and source_table <> 'etablissement'
  and source_table <> 'etablissement_substit'
;


--
-- Mise à jour table ETABLISSEMENT
--
alter table etablissement add substit_update_enabled bool default true not null;
comment on column etablissement.substit_update_enabled is 'Indique si ce substituant (le cas échéant) peut être mis à jour à partir des attributs des substitués';

-- sauvegardes tables
create table etablissement_sav as select * from etablissement;

-- nouvelle table PRE_ETABLISSEMENT
create table pre_etablissement (like etablissement including all);
insert into pre_etablissement select * from etablissement;
alter table pre_etablissement drop column est_membre;
alter table pre_etablissement drop column est_associe;
alter table pre_etablissement drop column est_comue;
alter table pre_etablissement drop column est_etab_inscription;
alter table pre_etablissement drop column signature_convocation_id;
alter table pre_etablissement drop column email_assistance;
alter table pre_etablissement drop column email_bibliotheque;
alter table pre_etablissement drop column email_doctorat;
alter table pre_etablissement drop column est_ced;
alter table pre_etablissement add column npd_force varchar(256);
alter table pre_etablissement add constraint pre_etablissement_source_fk foreign key (source_id) references source on delete cascade;
alter table pre_etablissement add constraint pre_etablissement_hc_fk foreign key (histo_createur_id) references utilisateur on delete cascade;
alter table pre_etablissement add constraint pre_etablissement_hm_fk foreign key (histo_modificateur_id) references utilisateur on delete cascade;
alter table pre_etablissement add constraint pre_etablissement_hd_fk foreign key (histo_destructeur_id) references utilisateur on delete cascade;
alter table pre_etablissement add constraint pre_etablissement_structure_fk foreign key (structure_id) references pre_structure on delete cascade;
create sequence if not exists pre_etablissement_id_seq owned by pre_etablissement.id;
select setval('pre_etablissement_id_seq', (select max(id) from etablissement));

--drop table etablissement_substit cascade;
create table etablissement_substit
(
    id bigserial not null primary key,
    from_id bigint not null constraint etablissement_substit_from_fk references pre_etablissement on delete no action, -- 'no action' requis car trigger sur PRE_INDIVIDU
    to_id bigint not null constraint etablissement_substit_to_fk references etablissement on delete no action, -- idem
    npd varchar(256) not null,
    histo_creation timestamp default ('now'::text)::timestamp without time zone not null,
    histo_modification timestamp,
    histo_destruction timestamp,
    histo_createur_id bigint constraint etablissement_substit_createur_fk references utilisateur,
    histo_modificateur_id bigint constraint etablissement_substit_modificateur_fk references utilisateur,
    histo_destructeur_id bigint constraint etablissement_substit_destructeur_fk references utilisateur
);
create unique index etablissement_substit_unique_idx on etablissement_substit(from_id) where histo_destruction is null;
create unique index etablissement_substit_unique_hist_idx on etablissement_substit(from_id, histo_destruction) where histo_destruction is not null;

drop view if exists v_diff_pre_etablissement;
drop view if exists src_pre_etablissement;
create or replace view src_pre_etablissement as
SELECT NULL::text AS id,
       tmp.source_code,
       src.id AS source_id,
       s.id AS structure_id
FROM tmp_etablissement tmp
         JOIN source src ON src.id = tmp.source_id
         JOIN structure s ON s.source_code = tmp.structure_id;

drop view if exists v_diff_etablissement;
drop view if exists src_etablissement;
create or replace view src_etablissement as
select pre.id,
       pre.source_id,
       pre.source_code,
       coalesce(ssub.to_id, pre.structure_id) as structure_id,
       pre.domaine
from pre_etablissement pre
left join structure_substit ssub on ssub.from_id = pre.structure_id and ssub.histo_destruction is null
where pre.histo_destruction is null and not exists (
    select id from etablissement_substit where histo_destruction is null and from_id = pre.id
);

--
-- Trigger sur la table PRE_ETABLISSEMENT se déclenchant en cas d'insertion ou de mise à jour de l'un des attributs suivants :
--   - attributs participant au NPD
--   - NPD forcé.
drop trigger if exists substit_trigger_pre_etablissement on pre_etablissement;
create trigger substit_trigger_pre_etablissement
    after insert
        or delete
        or update of
        structure_id, -- pour entrer ou sortir d'une substitution éventuelle (NPD)
        --
        /*rien pour l'instant*/ -- pour mettre à jour le substituant éventuel
        --
        npd_force, -- pour réagir à une demande de substitution forcée
        histo_destruction, -- pour réagir à l'historisation/restauration d'un enregsitrement
        source_id -- pour réagir au changement de source (source application => source compatible, et vice-versa)
    on pre_etablissement
    for each row
execute procedure substit_trigger_on_pre_fct('etablissement');

--
-- Trigger sur la table ETABLISSEMENT se déclenchant en cas d'insertion d'un enregistrement potentiellement substituant,
-- en vue de remplacer partout où c'est nécessaire les valeurs des clés étrangères par l'id du substituant.
--
drop trigger if exists substit_trigger_on_etablissement_substit on etablissement_substit;
create trigger substit_trigger_on_etablissement_substit
    after insert
        or update of histo_destruction
        or delete
    on etablissement_substit
    for each row
execute procedure substit_trigger_on_substit_fct('etablissement');


--drop function substit_npd_etablissement cascade
create or replace function substit_npd_etablissement(pre_record pre_etablissement) returns varchar
    language plpgsql
as
$$declare
    v_npd_structure varchar(256);
begin
    --
    -- Fonction de calcul du "NPD" d'un etablissement.
    --
    -- Important : Le NPD d'un etablissement est celui de la structure liée, parce qu'un etablissement ne porte pas
    -- aucune info concernée par la détection de doublon.
    --
    -- Attention !
    -- Modifier le calcul du NPD n'est pas une mince affaire car cela remet en question les substitutions existantes
    -- définies dans la table 'xxxx_substit'.
    -- > Dans les 2 cas qui suivent, il faudra absolument désactiver au préalable les triggers suivants :
    --   - substit_trigger_pre_xxxx
    --   - substit_trigger_on_xxxx_substit
    -- > Dans le cas où cela ne change rien du tout aux substitutions existantes, il faudra tout de même :
    --   - mettre à jour les valeurs dans la colonne 'npd' de la table 'xxxx_substit' en faisant appel
    --     à la fonction 'substit_npd_xxxx()';
    --   - mettre à jour manuellement les valeurs dans la colonne 'npd_force" de la table 'pre_xxxx'.
    -- > Dans le cas où cela invalide des substitutions existantes, il faudra :
    --   - historiser les substitutions concernées dans la table 'xxxx_substit' ;
    --   - mettre à jour manuellement les valeurs dans la colonne 'npd_force" de la table 'pre_xxxx'.
    --

    select substit_npd_structure(s.*) into v_npd_structure from pre_structure s where id = pre_record.structure_id;

    return v_npd_structure;
end;
$$;


--
-- Vue retournant les etablissements en doublon au regard de leur NPD.
--
-- Rappel : Les etablissements en doublons ne sont pas recherchés dans la source correspondant à l'application.
--
--drop view v_etablissement_doublon;
create or replace view v_etablissement_doublon as
with etablissements_npd as (
    select coalesce(pre.npd_force, substit_npd_etablissement(pre.*)) as npd, pre.id
    from pre_etablissement pre
         join pre_structure pres on pres.id = pre.structure_id and pres.histo_destruction is null
    where pre.histo_destruction is null and pre.source_id <> app_source_id()
), npds(npd) as (
    select npd, count(*)
    from etablissements_npd
    group by npd
    having count(*) > 1
)
select d.id, npds.npd
from npds, etablissements_npd d
where d.npd = npds.npd
--order by d.ine
;

drop function if exists substit_fetch_data_for_substituant_etablissement;
create or replace function substit_fetch_data_for_substituant_etablissement(p_npd varchar)
    returns table
            (
                structure_id bigint
            )
    language plpgsql
as
$$begin
    --
    -- Détermination des meilleures valeurs d'attributs des etablissements en doublon en vue de les affecter à
    -- l'etablissement substituant.
    --
    -- Pour chaque attribut, la stratégie de choix de la "meilleure" valeur est la fonction 'mode()'
    -- (cf. https://www.postgresql.org/docs/current/functions-aggregate).
    --
    -- Rappel : les etablissements en doublon sont les etablissements ayant le même NPD et n'appartenant pas à la source
    -- correspondnant à l'application.
    --
    -- Important : Une jointure est faite ici avec STRUCTURE_SUBSTIT pour obtenir le cas échéant l'id de la structure substituante.
    --

    raise notice 'Calcul des meilleures valeurs d''attributs parmi les doublons dont le NPD est %...', p_npd;

    return query
        select
            mode() within group (order by coalesce(sub.to_id, pre.structure_id)) as structure_id -- éventuelle structure substituante
        from pre_etablissement pre
                 join v_etablissement_doublon v on v.id = pre.id and v.npd = p_npd
                 left join structure_substit sub on sub.from_id = pre.structure_id and sub.histo_destruction is null
        where pre.histo_destruction is null
        group by v.npd;
end;
$$;


create or replace function substit_create_substituant_etablissement(data record) returns bigint
    language plpgsql
as
$$declare
    substituant_id bigint;
begin
    --
    -- Création d'un etablissement dit "susbtituant", càd se substituant à plusieurs etablissements considérés en doublon,
    -- à partir des valeurs d'attributs spécifiées.
    --

    raise notice 'Insertion du substituant à partir des données %', data;
    insert into etablissement (id,
                           source_id,
                           source_code,
                           histo_createur_id,
                           structure_id)
    select nextval('etablissement_id_seq') as id,
           app_source_id() as source_id,
           app_source_source_code() as source_code,
           app_utilisateur_id(),
           data.structure_id
    returning id into substituant_id;

    raise notice '=> Substituant %', substituant_id;

    return substituant_id;
end
$$;


create or replace function substit_update_substituant_etablissement(p_substituant_id bigint, data record) returns void
    language plpgsql
as
$$begin
    --
    -- Mise à jour des attributs de l'etablissement substituant spécifié, à partir des valeurs spécifiées.
    --

    update etablissement
    set histo_modification = current_timestamp,
        histo_modificateur_id = app_utilisateur_id(),
        structure_id = data.structure_id
    where id = p_substituant_id;
end
$$;


--drop function substit_create_all_substitutions_etablissement
create or replace function substit_create_all_substitutions_etablissement(limite integer default null) returns smallint
    language plpgsql
as
$$declare
    v_npd varchar(256);
    v_pre_count smallint;
    v_count smallint = 0;
    v_data record;
    v_etablissement_substituant_id bigint;
    v_etablissement_substitue record;
begin
    --
    -- Fonction de créations de N substitutions parmi toutes les substitutions possibles.
    --

    -- nombre de nouvelles substitutions possibles
    select count(distinct npd) into v_pre_count from v_etablissement_doublon v where v.id not in (
        select from_id from etablissement_substit where histo_destruction is null
    );
    raise notice '>>> Nombre de nouvelles substitutions possibles : %', v_pre_count;

    for v_npd in select distinct npd from v_etablissement_doublon v where v.id not in (
        select from_id from etablissement_substit where histo_destruction is null
    ) order by npd loop
            raise notice '>>> Substitution % sur %', v_count+1, v_pre_count;

            v_data = substit_fetch_data_for_substituant_etablissement(v_npd);
            if v_data is null then
                raise exception 'Anomalie : aucune donnée trouvée pour le NPD % !', v_npd;
            end if;
            v_etablissement_substituant_id = substit_create_substituant_etablissement(v_data);
            for v_etablissement_substitue in select * from v_etablissement_doublon v where npd = v_npd loop
                    perform substit_add_to_substitution('etablissement', v_etablissement_substitue.id, v_npd, v_etablissement_substituant_id);
                end loop;
            v_count = v_count + 1;

            exit when limite is not null and v_count >= limite;
        end loop;

    raise notice '>> Nombre de substitutions créées : %', v_count;
    return v_count;
end;
$$;



--
-- Liste des etablissements substitués
--
select ss.histo_destruction, ss.npd, ss.from_id, pe.id from_etab_id, ss.to_id, s.id to_etab_id, ps.npd_force, ps.libelle, s.libelle
    from structure_substit ss
        join pre_structure ps on ss.from_id = ps.id
        join pre_etablissement pe on ps.id = pe.structure_id
        join structure s on ss.to_id = s.id and s.histo_destruction is null
        join etablissement e on s.id = e.structure_id and e.histo_destruction is null
    order by to_id, from_id;

select * from structure_substit where from_id=9738;

with c as (select structure_id, count(*) from etablissement group by structure_id having count(*) > 1)
select * from etablissement e
         join structure s on e.structure_id = s.id --and s.source_id <> 1
--          join structure_substit ss on e.structure_id = ss.from_id
         where structure_id in (select structure_id from c)
         order by structure_id;