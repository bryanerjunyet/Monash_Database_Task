--****PLEASE ENTER YOUR DETAILS BELOW****
--T4-rm-mods.sql

--Student ID: 33521026
--Student Name: Er Jun Yet

/* Comments for your marker:


*/

-- =======================================
-- TASK 4a: Add completed events count to COMPETITOR
-- =======================================
alter table competitor add comp_completed_events number(3) default 0 not null;

comment on column competitor.comp_completed_events is
    'Number of completed events by this competitor (has finish time)';

-- Populate new completion column 
update competitor c
   set
    comp_completed_events = (
        select count(*)
          from entry e
         where e.comp_no = c.comp_no
           and e.entry_finishtime is not null
    );

commit;

-- Display table change
DESC competitor;

-- Display updated data with new column
select comp_no,
       comp_fname,
       comp_lname,
       comp_completed_events
  from competitor
 order by comp_no;

-- =======================================
-- TASK 4b: Allow support multiple charities
-- =======================================
drop table entry_charity cascade constraints purge;

-- Create new table
create table entry_charity (
    event_id           number(6) not null,
    entry_no           number(5) not null,
    char_id            number(3) not null,
    charity_percentage number(3) not null
);

comment on column entry_charity.event_id is
    'Event identifier (part of composite PK)';

comment on column entry_charity.entry_no is
    'Entry number (part of composite PK)';

comment on column entry_charity.char_id is
    'Charity identifier (part of composite PK)';

comment on column entry_charity.charity_percentage is
    'Percentage of funds allocated to this charity (0-100)';

alter table entry_charity
    add constraint entry_charity_pk primary key ( event_id,
                                                  entry_no,
                                                  char_id );

alter table entry_charity
    add constraint entry_charity_entry_fk
        foreign key ( event_id,
                      entry_no )
            references entry ( event_id,
                               entry_no );

alter table entry_charity
    add constraint entry_charity_charity_fk foreign key ( char_id )
        references charity ( char_id );

alter table entry_charity
    add constraint charity_percentage_chk check ( charity_percentage between 0 and 100
    );

-- Move existing charity data from ENTRY to ENTRY_CHARITY
insert into entry_charity (
    event_id,
    entry_no,
    char_id,
    charity_percentage
)
    select event_id,
           entry_no,
           char_id,
           100
      from entry
     where char_id is not null;

-- Remove the charity ID from ENTRY table
alter table entry drop constraint entry_charity_fk;

alter table entry drop column char_id;

-- Update Jackson Bull's charity percentages
-- Delete existing 100% charity entry for Jackson Bull
delete from entry_charity
 where ( event_id,
         entry_no ) in (
    select e.event_id,
           e.entry_no
      from entry e
      join competitor c
    on e.comp_no = c.comp_no
      join event ev
    on e.event_id = ev.event_id
      join carnival car
    on ev.carn_date = car.carn_date
     where upper(c.comp_fname) = upper('Jackson')
       and upper(c.comp_lname) = upper('Bull')
       and upper(car.carn_name) = upper('RM Winter Series Caulfield 2025')
);

-- Insert new charity allocations (70% RSPCA, 30% Beyond Blue)
insert into entry_charity (
    event_id,
    entry_no,
    char_id,
    charity_percentage
)
    select e.event_id,
           e.entry_no,
           (
               select char_id
                 from charity
                where upper(char_name) = upper('RSPCA')
           ),
           70
      from entry e
      join competitor c
    on e.comp_no = c.comp_no
      join event ev
    on e.event_id = ev.event_id
      join carnival car
    on ev.carn_date = car.carn_date
     where upper(c.comp_fname) = upper('Jackson')
       and upper(c.comp_lname) = upper('Bull')
       and upper(car.carn_name) = upper('RM Winter Series Caulfield 2025');

insert into entry_charity (
    event_id,
    entry_no,
    char_id,
    charity_percentage
)
    select e.event_id,
           e.entry_no,
           (
               select char_id
                 from charity
                where upper(char_name) = upper('Beyond Blue')
           ),
           30
      from entry e
      join competitor c
    on e.comp_no = c.comp_no
      join event ev
    on e.event_id = ev.event_id
      join carnival car
    on ev.carn_date = car.carn_date
     where upper(c.comp_fname) = upper('Jackson')
       and upper(c.comp_lname) = upper('Bull')
       and upper(car.carn_name) = upper('RM Winter Series Caulfield 2025');

commit;

-- Display new table change
DESC entry_charity;

-- Display new sample data
select ec.*,
       c.comp_fname,
       c.comp_lname,
       ch.char_name,
       ec.charity_percentage
  from entry_charity ec
  join entry e
on ec.event_id = e.event_id
   and ec.entry_no = e.entry_no
  join competitor c
on e.comp_no = c.comp_no
  join charity ch
on ec.char_id = ch.char_id
 order by ec.event_id,
          ec.entry_no,
          ec.char_id;

-- Display modified ENTRY table
DESC entry;