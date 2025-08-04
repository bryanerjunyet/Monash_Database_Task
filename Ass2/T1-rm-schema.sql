/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T1-rm-schema.sql

--Student ID: 33521026
--Student Name: Er Jun Yet

/* Comments for your marker:




*/

/* drop table statements - do not remove*/

drop table competitor cascade constraints purge;

drop table entry cascade constraints purge;

drop table team cascade constraints purge;

/* end of drop table statements*/

-- Task 1 Add Create table statements for the Missing TABLES below.
-- Ensure all column comments, and constraints (other than FK's)are included.
-- FK constraints are to be added at the end of this script


-- ===========================================================
--                          COMPETITOR
-- ===========================================================

create table competitor (
    comp_no        number(5) not null,
    comp_fname     varchar2(30),
    comp_lname     varchar2(30),
    comp_gender    char(1) not null,
    comp_dob       date not null,
    comp_email     varchar2(50) not null,
    comp_unistatus char(1) not null,
    comp_phone     char(10) not null
);

comment on column competitor.comp_no is
    'Unique identifier for a competitor';

comment on column competitor.comp_fname is
    'Competitor first name';

comment on column competitor.comp_lname is
    'Competitor last name';

comment on column competitor.comp_gender is
    'Competitor gender (M, F, or U)';

comment on column competitor.comp_dob is
    'Competitor date of birth';

comment on column competitor.comp_email is
    'Competitor email - must be unique';

comment on column competitor.comp_unistatus is
    'Competitor Monash student/staff status (Y or N)';

comment on column competitor.comp_phone is
    'Competitor phone number - must be unique';

alter table competitor add constraint competitor_pk primary key ( comp_no );

alter table competitor add constraint competitor_email_uq unique ( comp_email );

alter table competitor add constraint competitor_phone_uq unique ( comp_phone );

alter table competitor
    add constraint competitor_gender_chk
        check ( comp_gender in ( 'M',
                                 'F',
                                 'U' ) );

alter table competitor
    add constraint competitor_unistatus_chk check ( comp_unistatus in ( 'Y',
                                                                        'N' ) );


-- ===========================================================
--                          ENTRY
-- ===========================================================

create table entry (
    event_id          number(6) not null,
    entry_no          number(5) not null,
    entry_starttime   date,
    entry_finishtime  date,
    entry_elapsedtime date,
    comp_no           number(5) not null,
    team_id           number(3),
    char_id           number(3)
);

comment on column entry.event_id is
    'Event identifier';

comment on column entry.entry_no is
    'Entry number (unique within an event)';

comment on column entry.entry_starttime is
    'Entry start time (hh24:mi:ss format)';

comment on column entry.entry_finishtime is
    'Entry finish time (hh24:mi:ss format)';

comment on column entry.entry_elapsedtime is
    'Elapsed time (hh24:mi:ss format)';

comment on column entry.comp_no is
    'Competitor number';

comment on column entry.team_id is
    'Team ID';

comment on column entry.char_id is
    'Charity ID';

alter table entry add constraint entry_pk primary key ( event_id,
                                                        entry_no );


-- ===========================================================
--                          TEAM
-- ===========================================================

create table team (
    team_id   number(3) not null,
    team_name varchar2(30) not null,
    carn_date date not null,
    event_id  number(6) not null,
    entry_no  number(5) not null
);

comment on column team.team_id is
    'Team identifier (unique)';

comment on column team.team_name is
    'Team name';

comment on column team.carn_date is
    'Carnival date associated with team';

comment on column team.event_id is
    'Associated event for the team';

comment on column team.entry_no is
    'Entry number of the team leader';

alter table team add constraint team_pk primary key ( team_id );

alter table team add constraint team_uq unique ( team_name,
                                                 carn_date );


-- ===========================================================
--                 FOREIGN KEY CONSTRAINTS
-- ===========================================================

-- ENTRY foreign keys
alter table entry
    add constraint entry_event_fk foreign key ( event_id )
        references event ( event_id );

alter table entry
    add constraint entry_comp_fk foreign key ( comp_no )
        references competitor ( comp_no );

alter table entry
    add constraint entry_team_fk foreign key ( team_id )
        references team ( team_id );

alter table entry
    add constraint entry_charity_fk foreign key ( char_id )
        references charity ( char_id );

-- TEAM foreign keys
alter table team
    add constraint team_carnival_fk foreign key ( carn_date )
        references carnival ( carn_date );

alter table team
    add constraint team_entry_fk
        foreign key ( event_id,
                      entry_no )
            references entry ( event_id,
                               entry_no );