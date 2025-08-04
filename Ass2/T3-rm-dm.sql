--****PLEASE ENTER YOUR DETAILS BELOW****
--T3-rm-dm.sql

--Student ID: 33521026
--Student Name: Er Jun Yet

/* Comments for your marker:


*/

-- =======================================
-- TASK 3a: Create sequences
-- =======================================
drop sequence competitor_seq;

drop sequence team_seq;

create sequence competitor_seq start with 100 increment by 5;

create sequence team_seq start with 100 increment by 5;

commit;

-- =======================================
-- TASK 3b: Add competitors, entries and team
-- =======================================
-- Add competitor Keith Rose
insert into competitor values ( competitor_seq.nextval,
                                'Keith',
                                'Rose',
                                'M',
                                to_date('15-JUN-1990','DD-MON-YYYY'),
                                'keith.rose@student.monash.edu',
                                'Y',
                                '0422141112' );

-- Add competitor Jackson Bull
insert into competitor values ( competitor_seq.nextval,
                                'Jackson',
                                'Bull',
                                'M',
                                to_date('22-SEP-1992','DD-MON-YYYY'),
                                'jackson.bull@student.monash.edu',
                                'Y',
                                '0422412524' );

-- Create entry for Keith Rose
insert into entry (
    event_id,
    entry_no,
    entry_starttime,
    entry_finishtime,
    entry_elapsedtime,
    comp_no,
    team_id,
    char_id
)
    select e.event_id,
           (
               select nvl(
                   max(entry_no),
                   0
               ) + 1
                 from entry
                where event_id = e.event_id
           ),
           null,
           null,
           null,
           (
               select max(comp_no)
                 from competitor
                where upper(comp_fname) = upper('Keith')
                  and upper(comp_lname) = upper('Rose')
           ),
           null,
           (
               select char_id
                 from charity
                where upper(char_name) = upper('Salvation Army')
           )
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run');

-- Create entry for Jackson Bull 
insert into entry (
    event_id,
    entry_no,
    entry_starttime,
    entry_finishtime,
    entry_elapsedtime,
    comp_no,
    team_id,
    char_id
)
    select e.event_id,
           (
               select nvl(
                   max(entry_no),
                   0
               ) + 1
                 from entry
                where event_id = e.event_id
           ),
           null,
           null,
           null,
           (
               select max(comp_no)
                 from competitor
                where upper(comp_fname) = upper('Jackson')
                  and upper(comp_lname) = upper('Bull')
           ),
           null,
           (
               select char_id
                 from charity
                where upper(char_name) = upper('RSPCA')
           )
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run');

-- Create Super Runners team with Keith as leader
insert into team (
    team_id,
    team_name,
    carn_date,
    event_id,
    entry_no
)
    select team_seq.nextval,
           'Super Runners',
           c.carn_date,
           e.event_id,
           1
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run');

-- Update entries to set team_id
update entry
   set
    team_id = (
        select max(team_id)
          from team
         where upper(team_name) = upper('Super Runners')
           and carn_date = (
            select carn_date
              from carnival
             where upper(carn_name) = upper('RM Winter Series Caulfield 2025')
        )
    )
 where comp_no = (
        select max(comp_no)
          from competitor
         where upper(comp_fname) = upper('Keith')
           and upper(comp_lname) = upper('Rose')
    )
   and event_id = (
    select e.event_id
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run')
);

update entry
   set
    team_id = (
        select max(team_id)
          from team
         where upper(team_name) = upper('Super Runners')
           and carn_date = (
            select carn_date
              from carnival
             where upper(carn_name) = upper('RM Winter Series Caulfield 2025')
        )
    )
 where comp_no = (
        select max(comp_no)
          from competitor
         where upper(comp_fname) = upper('Jackson')
           and upper(comp_lname) = upper('Bull')
    )
   and event_id = (
    select e.event_id
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run')
);

commit;

-- =======================================
-- TASK 3c: Modify Jackson's entry
-- =======================================
-- Delete Jackson's existing entry
delete from entry
 where comp_no = (
        select max(comp_no)
          from competitor
         where upper(comp_fname) = upper('Jackson')
           and upper(comp_lname) = upper('Bull')
    )
   and event_id = (
    select e.event_id
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('10 Km run')
);

-- Create new entry for 5km run
insert into entry (
    event_id,
    entry_no,
    entry_starttime,
    entry_finishtime,
    entry_elapsedtime,
    comp_no,
    team_id,
    char_id
)
    select e.event_id,
           (
               select nvl(
                   max(entry_no),
                   0
               ) + 1
                 from entry
                where event_id = e.event_id
           ),
           null,
           null,
           null,
           (
               select max(comp_no)
                 from competitor
                where upper(comp_fname) = upper('Jackson')
                  and upper(comp_lname) = upper('Bull')
           ),
           (
               select max(team_id)
                 from team
                where upper(team_name) = upper('Super Runners')
           ),
           (
               select char_id
                 from charity
                where upper(char_name) = upper('Beyond Blue')
           )
      from event e
      join carnival c
    on e.carn_date = c.carn_date
      join eventtype et
    on e.eventtype_code = et.eventtype_code
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
       and upper(et.eventtype_desc) = upper('5 Km run');

commit;

-- =======================================
-- TASK 3d: Withdraw Keith and disband team
-- =======================================
-- Remove all team members 
update entry
   set
    team_id = null
 where team_id = (
    select max(team_id)
      from team
     where upper(team_name) = upper('Super Runners')
);

-- Remove Keith's entry
delete from entry
 where comp_no = (
        select max(comp_no)
          from competitor
         where upper(comp_fname) = upper('Keith')
           and upper(comp_lname) = upper('Rose')
    )
   and event_id in (
    select e.event_id
      from event e
      join carnival c
    on e.carn_date = c.carn_date
     where upper(c.carn_name) = upper('RM Winter Series Caulfield 2025')
);

-- Delete team
delete from team
 where upper(team_name) = upper('Super Runners');

commit;