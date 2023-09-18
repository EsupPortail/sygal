--
-- Substitutions
--

--=============================== UNITE_RECH ================================-

--
-- NOTE IMPORTANTE :
-- Le meilleur attribut candidat pour la détection de doublons d'UR est à l'heure actuelle le "code d'UR"
-- (ex : 'UMR6634'). Ce code réside dans la table des structures (colonne 'code')
-- et non dans la table des UR.
--


--
-- Vue listant les clés étrangères (FK) pointant vers 'unite_rech'
-- dont la valeur doit être remplacée par l'id substituant éventuel.
--
-- drop view v_substit_foreign_keys_unite_rech;
create or replace view v_substit_foreign_keys_unite_rech as
select * from v_substit_foreign_keys
where target_table = 'unite_rech'
  and source_table <> 'unite_rech'
  and source_table <> 'unite_rech_substit'
;


--
-- Mise à jour table unite_rech
--
alter table unite_rech add substit_update_enabled bool default true not null;
comment on column unite_rech.substit_update_enabled is 'Indique si ce substituant (le cas échéant) peut être mis à jour à partir des attributs des substitués';

-- sauvegardes tables
create table unite_rech_sav as select * from unite_rech;

-- nouvelle table PRE_UNITE_RECH
create table pre_unite_rech (like unite_rech including all);
insert into pre_unite_rech select * from unite_rech;
alter table pre_unite_rech add column npd_force varchar(256);
alter table pre_unite_rech add constraint pre_unite_rech_source_fk foreign key (source_id) references source on delete cascade;
alter table pre_unite_rech add constraint pre_unite_rech_hc_fk foreign key (histo_createur_id) references utilisateur on delete cascade;
alter table pre_unite_rech add constraint pre_unite_rech_hm_fk foreign key (histo_modificateur_id) references utilisateur on delete cascade;
alter table pre_unite_rech add constraint pre_unite_rech_hd_fk foreign key (histo_destructeur_id) references utilisateur on delete cascade;
alter table pre_unite_rech add constraint pre_unite_rech_structure_fk foreign key (structure_id) references pre_structure on delete cascade;
create sequence if not exists pre_unite_rech_id_seq owned by pre_unite_rech.id;
select setval('pre_unite_rech_id_seq', (select max(id) from unite_rech));

--drop table unite_rech_substit cascade;
create table unite_rech_substit
(
    id bigserial not null primary key,
    from_id bigint not null constraint unite_rech_substit_from_fk references pre_unite_rech on delete no action, -- 'no action' requis car trigger sur PRE_INDIVIDU
    to_id bigint not null constraint unite_rech_substit_to_fk references unite_rech on delete no action, -- idem
    npd varchar(256) not null,
    histo_creation timestamp default ('now'::text)::timestamp without time zone not null,
    histo_modification timestamp,
    histo_destruction timestamp,
    histo_createur_id bigint constraint unite_rech_substit_createur_fk references utilisateur,
    histo_modificateur_id bigint constraint unite_rech_substit_modificateur_fk references utilisateur,
    histo_destructeur_id bigint constraint unite_rech_substit_destructeur_fk references utilisateur
);
create unique index unite_rech_substit_unique_idx on unite_rech_substit(from_id) where histo_destruction is null;
create unique index unite_rech_substit_unique_hist_idx on unite_rech_substit(from_id, histo_destruction) where histo_destruction is not null;

drop view if exists v_diff_pre_unite_rech;
drop view if exists src_pre_unite_rech;
create or replace view src_pre_unite_rech as
SELECT NULL::text AS id,
       tmp.source_code,
       src.id AS source_id,
       s.id AS structure_id
FROM tmp_unite_rech tmp
         JOIN source src ON src.id = tmp.source_id
         JOIN structure s ON s.source_code = tmp.structure_id;

drop view if exists v_diff_unite_rech;
drop view if exists src_unite_rech;
create or replace view src_unite_rech as
select pre.id,
       pre.source_id,
       pre.source_code,
       coalesce(ssub.to_id, pre.structure_id) as structure_id
from pre_unite_rech pre
left join structure_substit ssub on ssub.from_id = pre.structure_id and ssub.histo_destruction is null
where pre.histo_destruction is null and not exists (
    select id from unite_rech_substit where histo_destruction is null and from_id = pre.id
);

--
-- Trigger sur la table PRE_UNITE_RECH se déclenchant en cas d'insertion ou de mise à jour de l'un des attributs suivants :
--   - attributs participant au NPD
--   - NPD forcé.
drop trigger if exists substit_trigger_pre_unite_rech on pre_unite_rech;
create trigger substit_trigger_pre_unite_rech
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
    on pre_unite_rech
    for each row
execute procedure substit_trigger_on_pre_fct('unite_rech');

--
-- Trigger sur la table UNITE_RECH se déclenchant en cas d'insertion d'un enregistrement potentiellement substituant,
-- en vue de remplacer partout où c'est nécessaire les valeurs des clés étrangères par l'id du substituant.
--
drop trigger if exists substit_trigger_on_unite_rech_substit on unite_rech_substit;
create trigger substit_trigger_on_unite_rech_substit
    after insert
        or update of histo_destruction
        or delete
    on unite_rech_substit
    for each row
execute procedure substit_trigger_on_substit_fct('unite_rech');


--drop function substit_npd_unite_rech cascade
create or replace function substit_npd_unite_rech(pre_record pre_unite_rech) returns varchar
    language plpgsql
as
$$declare
    v_npd_structure varchar(256);
begin
    --
    -- Fonction de calcul du "NPD" d'un unite_rech.
    --
    -- Important : Le NPD d'un unite_rech est celui de la structure liée, parce qu'un unite_rech ne porte pas
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
-- Vue retournant les unite_rechs en doublon au regard de leur NPD.
--
-- Rappel : Les unite_rechs en doublons ne sont pas recherchés dans la source correspondant à l'application.
--
--drop view v_unite_rech_doublon;
create or replace view v_unite_rech_doublon as
with unite_rechs_npd as (
    select coalesce(pre.npd_force, substit_npd_unite_rech(pre.*)) as npd, pre.id
    from pre_unite_rech pre
             join pre_structure pres on pres.id = pre.structure_id and pres.histo_destruction is null
    where pre.histo_destruction is null and pre.source_id <> app_source_id()
), npds(npd) as (
    select npd, count(*)
    from unite_rechs_npd
    group by npd
    having count(*) > 1
)
select d.id, npds.npd
from npds, unite_rechs_npd d
where d.npd = npds.npd
--order by d.ine
;

create or replace function substit_fetch_data_for_substituant_unite_rech(p_npd varchar)
    returns table
            (
                structure_id bigint
            )
    language plpgsql
as
$$begin
    --
    -- Détermination des meilleures valeurs d'attributs des unite_rechs en doublon en vue de les affecter à
    -- l'unite_rech substituant.
    --
    -- Pour chaque attribut, la stratégie de choix de la "meilleure" valeur est la fonction 'mode()'
    -- (cf. https://www.postgresql.org/docs/current/functions-aggregate).
    --
    -- Rappel : les unite_rechs en doublon sont les unite_rechs ayant le même NPD et n'appartenant pas à la source
    -- correspondnant à l'application.
    --
    -- Important : Une jointure est faite ici avec STRUCTURE_SUBSTIT pour obtenir le cas échéant l'id de la structure substituante.
    --

    raise notice 'Calcul des meilleures valeurs d''attributs parmi les doublons dont le NPD est %...', p_npd;

    return query
        select
            mode() within group (order by coalesce(sub.to_id, pre.structure_id)) as structure_id -- éventuelle structure substituante
        from pre_unite_rech pre
                 join v_unite_rech_doublon v on v.id = pre.id and v.npd = p_npd
                 left join structure_substit sub on sub.from_id = pre.structure_id and sub.histo_destruction is null
        where pre.histo_destruction is null
        group by v.npd;
end;
$$;


create or replace function substit_create_substituant_unite_rech(data record) returns bigint
    language plpgsql
as
$$declare
    substituant_id bigint;
begin
    --
    -- Création d'un unite_rech dit "susbtituant", càd se substituant à plusieurs unite_rechs considérés en doublon,
    -- à partir des valeurs d'attributs spécifiées.
    --

    raise notice 'Insertion du substituant à partir des données %', data;
    insert into unite_rech (id,
                            source_id,
                            source_code,
                            histo_createur_id,
                            structure_id)
    select nextval('unite_rech_id_seq') as id,
           app_source_id() as source_id,
           app_source_source_code() as source_code,
           app_utilisateur_id(),
           data.structure_id
    returning id into substituant_id;

    raise notice '=> Substituant %', substituant_id;

    return substituant_id;
end
$$;


create or replace function substit_update_substituant_unite_rech(p_substituant_id bigint, data record) returns void
    language plpgsql
as
$$begin
    --
    -- Mise à jour des attributs de l'unite_rech substituant spécifié, à partir des valeurs spécifiées.
    --

    update unite_rech
    set histo_modification = current_timestamp,
        histo_modificateur_id = app_utilisateur_id(),
        structure_id = data.structure_id
    where id = p_substituant_id;
end
$$;


--drop function substit_create_all_substitutions_unite_rech
create or replace function substit_create_all_substitutions_unite_rech(limite integer default null) returns smallint
    language plpgsql
as
$$declare
    v_npd varchar(256);
    v_pre_count smallint;
    v_count smallint = 0;
    v_data record;
    v_unite_rech_substituant_id bigint;
    v_unite_rech_substitue record;
begin
    --
    -- Fonction de créations de N substitutions parmi toutes les substitutions possibles.
    --

    -- nombre de nouvelles substitutions possibles
    select count(distinct npd) into v_pre_count from v_unite_rech_doublon v where v.id not in (
        select from_id from unite_rech_substit where histo_destruction is null
    );
    raise notice '>>> Nombre de nouvelles substitutions possibles : %', v_pre_count;

    for v_npd in select distinct npd from v_unite_rech_doublon v where v.id not in (
        select from_id from unite_rech_substit where histo_destruction is null
    ) order by npd loop
            raise notice '>>> Substitution % sur %', v_count+1, v_pre_count;

            v_data = substit_fetch_data_for_substituant_unite_rech(v_npd);
            if v_data is null then
                raise exception 'Anomalie : aucune donnée trouvée pour le NPD % !', v_npd;
            end if;
            v_unite_rech_substituant_id = substit_create_substituant_unite_rech(v_data);
            for v_unite_rech_substitue in select * from v_unite_rech_doublon v where npd = v_npd loop
                    perform substit_add_to_substitution('unite_rech', v_unite_rech_substitue.id, v_npd, v_unite_rech_substituant_id);
                end loop;
            v_count = v_count + 1;

            exit when limite is not null and v_count >= limite;
        end loop;

    raise notice '>> Nombre de substitutions créées : %', v_count;
    return v_count;
end;
$$;