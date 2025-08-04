--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T5-rm-plsql.sql

--Student ID: 33521026
--Student Name: Er Jun Yet

/* Comments for your marker:

*/

-- =======================================
-- TASK 5a: Elapsed Time Function
-- =======================================
create or replace function calculate_elapsed_time (
    p_start_time  in varchar2,
    p_finish_time in varchar2
) return varchar2 is
    v_start   date;
    v_finish  date;
    v_elapsed date;
begin
    if p_start_time is null
    or p_finish_time is null then
        return '00:00:00';
    end if;
    v_start := to_date ( p_start_time,'HH24:MI:SS' );
    v_finish := to_date ( p_finish_time,'HH24:MI:SS' );
    if v_finish < v_start then
        v_finish := v_finish + 1;
    end if;
    v_elapsed := to_date ( '00:00:00','HH24:MI:SS' ) + ( v_finish - v_start );
    return to_char(
        v_elapsed,
        'HH24:MI:SS'
    );
end;
/

-- Test Harness for 5a
-- Test case 1: Normal case
declare
    v_actual   varchar2(20);
    v_expected varchar2(20) := '01:15:30';
begin
    v_actual := calculate_elapsed_time(
        '08:30:00',
        '09:45:30'
    );
    if v_actual = v_expected then
        dbms_output.put_line('Test 1 PASS');
    else
        dbms_output.put_line('Test 1 FAIL: Expected '
                             || v_expected
                             || ', got '
                             || v_actual);
    end if;

end;
/

-- Test 2: Overnight run (start late, finish early next day)
declare
    v_actual   varchar2(20);
    v_expected varchar2(20) := '01:45:30';
begin
    v_actual := calculate_elapsed_time(
        '23:30:00',
        '01:15:30'
    );
    if v_actual = v_expected then
        dbms_output.put_line('Test 2 PASS');
    else
        dbms_output.put_line('Test 2 FAIL: Expected '
                             || v_expected
                             || ', got '
                             || v_actual);
    end if;

end;
/

-- Test 3: Null input
declare
    v_actual1  varchar2(20);
    v_actual2  varchar2(20);
    v_actual3  varchar2(20);
    v_expected varchar2(20) := '00:00:00';
    v_pass     boolean := true;
begin
    v_actual1 := calculate_elapsed_time(
        null,
        '01:15:30'
    );
    v_actual2 := calculate_elapsed_time(
        '08:30:00',
        null
    );
    v_actual3 := calculate_elapsed_time(
        null,
        null
    );
    if v_actual1 != v_expected then
        dbms_output.put_line('Test 3.1 FAIL: Expected '
                             || v_expected
                             || ', got '
                             || v_actual1);
        v_pass := false;
    end if;

    if v_actual2 != v_expected then
        dbms_output.put_line('Test 3.2 FAIL: Expected '
                             || v_expected
                             || ', got '
                             || v_actual2);
        v_pass := false;
    end if;

    if v_actual3 != v_expected then
        dbms_output.put_line('Test 3.3 FAIL: Expected '
                             || v_expected
                             || ', got '
                             || v_actual3);
        v_pass := false;
    end if;

    if v_pass then
        dbms_output.put_line('Test 3 PASS');
    end if;
end;
/

rollback;


-- =======================================
-- TASK 5b: Entry Completion Trigger
-- =======================================
create or replace trigger trg_entry_completion before
    update of entry_finishtime on entry
    for each row
    when ( new.entry_finishtime is not null
       and old.entry_finishtime is null )
declare
    v_elapsed varchar2(8);
begin
    -- Only proceed if start time exists
    if :new.entry_starttime is not null then
        -- Calculate elapsed time
        v_elapsed := calculate_elapsed_time(
            to_char(
                :new.entry_starttime,
                'HH24:MI:SS'
            ),
            to_char(
                :new.entry_finishtime,
                'HH24:MI:SS'
            )
        );
        
        -- Update elapsed time
        :new.entry_elapsedtime := to_date ( v_elapsed,'HH24:MI:SS' );
        dbms_output.put_line('Updated elapsed time for event ID - '
                             || :new.event_id
                             || ' and entry no -'
                             || :new.entry_no
                             || ' to '
                             || v_elapsed);
        
        -- Update competitor's completed events count
        update competitor
           set
            comp_completed_events = comp_completed_events + 1
         where comp_no = :new.comp_no;

        dbms_output.put_line('Incremented completed events for competitor ' || :new.comp_no
        );
    end if;
exception
    when others then
        dbms_output.put_line('Error in trigger: ' || sqlerrm);
        raise;
end;
/

-- Test Harness for 5b

-- Create test entry with start time but no finish time
declare
    v_event_id number;
begin
    -- Get an event ID for testing
    select event_id
      into v_event_id
      from event
     where carn_date = to_date('29/JUN/2025','DD/MON/YYYY')
       and rownum = 1;
    
    -- Create test entry
    insert into entry (
        event_id,
        entry_no,
        entry_starttime,
        comp_no
    ) values ( v_event_id,
               (
                   select nvl(
                       max(entry_no),
                       0
                   ) + 1
                     from entry
                    where event_id = v_event_id
               ),
               to_date('08:30:00','HH24:MI:SS'),
               1  -- Testing with competitor 1
                );

    commit;
    dbms_output.put_line('Created test entry for trigger testing');
end;
/

-- Before values
select e.event_id,
       e.entry_no,
       to_char(
           e.entry_starttime,
           'HH24:MI:SS'
       ) as start_time,
       to_char(
           e.entry_finishtime,
           'HH24:MI:SS'
       ) as finish_time,
       to_char(
           e.entry_elapsedtime,
           'HH24:MI:SS'
       ) as elapsed_time,
       c.comp_no,
       c.comp_fname,
       c.comp_lname,
       c.comp_completed_events
  from entry e
  join competitor c
on e.comp_no = c.comp_no
 where c.comp_no = 1
 order by e.event_id,
          e.entry_no;

-- Update the test entry with finish time
declare
    v_event_id number;
    v_entry_no number;
begin
    -- Get the test entry created
    select event_id,
           entry_no
      into
        v_event_id,
        v_entry_no
      from entry
     where entry_starttime is not null
       and entry_finishtime is null
       and comp_no = 1
       and rownum = 1;
    
    -- Update with finish time
    update entry
       set
        entry_finishtime = to_date('09:15:30','HH24:MI:SS')
     where event_id = v_event_id
       and entry_no = v_entry_no;

    commit;
    dbms_output.put_line('Updated finished time for event ID - '
                         || v_event_id
                         || 'entry no -'
                         || v_entry_no);
exception
    when no_data_found then
        dbms_output.put_line('No uncompleted entries found for testing');
end;
/

-- After values
select e.event_id,
       e.entry_no,
       to_char(
           e.entry_starttime,
           'HH24:MI:SS'
       ) as start_time,
       to_char(
           e.entry_finishtime,
           'HH24:MI:SS'
       ) as finish_time,
       to_char(
           e.entry_elapsedtime,
           'HH24:MI:SS'
       ) as elapsed_time,
       c.comp_no,
       c.comp_fname,
       c.comp_lname,
       c.comp_completed_events
  from entry e
  join competitor c
on e.comp_no = c.comp_no
 where c.comp_no = 1
 order by e.event_id,
          e.entry_no;

rollback;


-- =======================================
-- TASK 5c: Entry Registration Procedure
-- =======================================
create or replace procedure prc_entry_registration (
    p_comp_no         in number,
    p_carn_name       in varchar2,
    p_event_type_desc in varchar2,
    p_team_name       in varchar2,
    p_charity_name    in varchar2,
    p_output          out varchar2
) is

    v_carn_date          date;
    v_event_id           number;
    v_eventtype_code     varchar2(3);
    v_char_id            number;
    v_team_id            number;
    v_entry_no           number;
    v_comp_exists        number;
    v_team_exists        number;
    v_event_exists       number;
    v_charity_exists     number;
    v_carnival_exists    number;
    v_already_registered number;
    v_entry_id           number;
begin
    p_output := '';
    
    -- Check if competitor exists
    select count(*)
      into v_comp_exists
      from competitor
     where comp_no = p_comp_no;

    if v_comp_exists = 0 then
        p_output := 'Competitor '
                    || p_comp_no
                    || ' does not exist';
        return;
    end if;
    
    -- Check if carnival exists
    select count(*),
           max(carn_date)
      into
        v_carnival_exists,
        v_carn_date
      from carnival
     where upper(carn_name) = upper(p_carn_name);

    if v_carnival_exists = 0 then
        p_output := 'Carnival '
                    || p_carn_name
                    || ' does not exist';
        return;
    end if;
    
    -- Check if event type exists
    select count(*),
           max(eventtype_code)
      into
        v_event_exists,
        v_eventtype_code
      from eventtype
     where upper(eventtype_desc) = upper(p_event_type_desc);

    if v_event_exists = 0 then
        p_output := 'Event type '
                    || p_event_type_desc
                    || ' does not exist';
        return;
    end if;
    
    -- Check if event exists for this carnival
    select count(*),
           max(event_id)
      into
        v_event_exists,
        v_event_id
      from event
     where carn_date = v_carn_date
       and eventtype_code = v_eventtype_code;

    if v_event_exists = 0 then
        p_output := 'Event '
                    || p_event_type_desc
                    || ' not offered at '
                    || p_carn_name;
        return;
    end if;
    
    -- Check if competitor is already registered
    select count(*)
      into v_already_registered
      from entry e
      join event ev
    on e.event_id = ev.event_id
     where e.comp_no = p_comp_no
       and ev.carn_date = v_carn_date;

    if v_already_registered > 0 then
        p_output := 'Competitor '
                    || p_comp_no
                    || ' already registered for carnival '
                    || p_carn_name;
        return;
    end if;
    
    -- Check if charity exists 
    if p_charity_name is not null then
        select count(*),
               max(char_id)
          into
            v_charity_exists,
            v_char_id
          from charity
         where upper(char_name) = upper(p_charity_name);

        if v_charity_exists = 0 then
            p_output := 'Charity '
                        || p_charity_name
                        || ' does not exist';
            return;
        end if;

    end if;
    
    -- Get next entry number
    select nvl(
        max(entry_no),
        0
    ) + 1
      into v_entry_no
      from entry
     where event_id = v_event_id;
    
    -- Create entry
    insert into entry (
        event_id,
        entry_no,
        entry_starttime,
        entry_finishtime,
        entry_elapsedtime,
        comp_no,
        team_id
    ) values ( v_event_id,
               v_entry_no,
               null,
               null,
               null,
               p_comp_no,
               null ) returning entry_no into v_entry_no;
    
    -- Handle team registration
    if p_team_name is not null then
        -- Check if team exists for this carnival
        select count(*),
               max(team_id)
          into
            v_team_exists,
            v_team_id
          from team
         where upper(team_name) = upper(p_team_name)
           and carn_date = v_carn_date;

        if v_team_exists = 0 then
            -- Create new team
            insert into team (
                team_id,
                team_name,
                carn_date,
                event_id,
                entry_no
            ) values ( team_seq.nextval,
                       p_team_name,
                       v_carn_date,
                       v_event_id,
                       v_entry_no ) returning team_id into v_team_id;
            
            -- Update entry with team ID
            update entry
               set
                team_id = v_team_id
             where event_id = v_event_id
               and entry_no = v_entry_no;

            p_output := 'Created new team '
                        || p_team_name
                        || ' for carnival '
                        || p_carn_name;
        else
            -- Update entry with existing team ID
            update entry
               set
                team_id = v_team_id
             where event_id = v_event_id
               and entry_no = v_entry_no;

            p_output := 'Added to existing team '
                        || p_team_name
                        || ' for carnival '
                        || p_carn_name;
        end if;

    end if;
    
    -- Add charity support if provided
    if p_charity_name is not null then
        insert into entry_charity (
            event_id,
            entry_no,
            char_id,
            charity_percentage
        ) values ( v_event_id,
                   v_entry_no,
                   v_char_id,
                   100 );

        p_output := p_output
                    || chr(10)
                    || 'Supported a charity during registration.';
    else
        p_output := p_output
                    || chr(10)
                    || 'No charity supported';
    end if;

    p_output := p_output
                || chr(10)
                || 'Successfully registered competitor '
                || p_comp_no
                || ' for event '
                || p_event_type_desc
                || ' at carnival '
                || p_carn_name
                || ' with entry number '
                || v_entry_no;

    commit;
exception
    when others then
        p_output := 'Error: ' || sqlerrm;
        rollback;
end;
/

-- Test Harness for 5c

-- Test 1: Successful registration with new team

-- Before values
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname,
       t.team_name,
       ch.char_name,
       ec.charity_percentage
  from entry e
  join competitor c
on e.comp_no = c.comp_no
  left join team t
on e.team_id = t.team_id
  left join entry_charity ec
on e.event_id = ec.event_id
   and e.entry_no = ec.entry_no
  left join charity ch
on ec.char_id = ch.char_id
 where e.comp_no = 16;

select team_id,
       team_name,
       carn_date
  from team
 where upper(team_name) = upper('Genius League');

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16, -- comp_no (Wartortle Warles)
        'RM Winter Series Caulfield 2025', -- carn_name
        '5 Km Run', -- event_type_desc
        'Genius League', -- team_name
        'Amnesty International', -- charity_name
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname,
       t.team_name,
       ch.char_name,
       ec.charity_percentage
  from entry e
  join competitor c
on e.comp_no = c.comp_no
  left join team t
on e.team_id = t.team_id
  left join entry_charity ec
on e.event_id = ec.event_id
   and e.entry_no = ec.entry_no
  left join charity ch
on ec.char_id = ch.char_id
 where e.comp_no = 16;

select team_id,
       team_name,
       carn_date
  from team
 where upper(team_name) = upper('Genius League');

rollback;

-- Test 2: Already registered

-- First register the competitor
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16, -- comp_no (Wartortle Warles)
        'RM Winter Series Caulfield 2025', -- carn_name
        '10 Km Run', -- event_type_desc
        null, -- no team
        null, -- no charity
        v_output
    );
    commit;
end;
/

-- Before values
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname
  from entry e
  join competitor c
on e.comp_no = c.comp_no
 where e.comp_no = 16;

-- Execute procedure (try to register again)
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16, -- comp_no (already registered)
        'RM Winter Series Caulfield 2025', -- carn_name
        '10 Km Run', -- event_type_desc
        null, -- no team
        null, -- no charity
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values (should only have one entry)
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname
  from entry e
  join competitor c
on e.comp_no = c.comp_no
 where e.comp_no = 16;

rollback;

-- Test 3: Successful registration with existing team

-- First register the competitor with a team
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16, -- comp_no (Wartortle Warles)
        'RM Winter Series Caulfield 2025', -- carn_name
        '5 Km Run', -- event_type_desc
        'Genius League', -- team_name
        'Amnesty International', -- charity_name
        v_output
    );
    commit;
end;
/

-- Before values
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname,
       t.team_name,
       ch.char_name,
       ec.charity_percentage
  from entry e
  join competitor c
on e.comp_no = c.comp_no
  left join team t
on e.team_id = t.team_id
  left join entry_charity ec
on e.event_id = ec.event_id
   and e.entry_no = ec.entry_no
  left join charity ch
on ec.char_id = ch.char_id
 where e.comp_no = 17;

select team_id,
       team_name,
       carn_date
  from team
 where upper(team_name) = upper('Genius League');

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        17, -- comp_no (Snorlax Sullivan)
        'RM Winter Series Caulfield 2025', -- carn_name
        '5 Km Run', -- event_type_desc
        'Genius League', -- team_name
        null, -- no charity
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values
select e.event_id,
       e.entry_no,
       c.comp_fname,
       c.comp_lname,
       t.team_name,
       ch.char_name,
       ec.charity_percentage
  from entry e
  join competitor c
on e.comp_no = c.comp_no
  left join team t
on e.team_id = t.team_id
  left join entry_charity ec
on e.event_id = ec.event_id
   and e.entry_no = ec.entry_no
  left join charity ch
on ec.char_id = ch.char_id
 where e.comp_no = 17;

select team_id,
       team_name,
       carn_date
  from team
 where upper(team_name) = upper('Genius League');

rollback;

-- Test 4: Invalid competitor

-- Before values (should be no change)
select *
  from competitor
 where comp_no = 9999;

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        9999,
        'RM Winter Series Caulfield 2025',
        '5 Km Run',
        null,
        null,
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values (should be same as before)
select *
  from competitor
 where comp_no = 9999;

rollback;

-- Test 5: Invalid carnival

-- Before values (should be no change)
select *
  from carnival
 where upper(carn_name) = 'RM Hot Series Malaysia 2099';

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16,
        'RM Hot Series Malaysia 2099',
        '5 Km Run',
        null,
        null,
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values (should be same as before)
select *
  from carnival
 where upper(carn_name) = 'RM Hot Series Malaysia 2099';

rollback;

-- Test 6: Invalid event type

-- Before values (should be no change)
select *
  from eventtype
 where upper(eventtype_desc) = '100K';

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16,
        'RM Winter Series Caulfield 2025',
        '100 Km Run',
        null,
        null,
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values (should be same as before)
select *
  from eventtype
 where upper(eventtype_desc) = '100K';

rollback;

-- Test 7: Invalid charity

-- Before values (should be no change)
select *
  from charity
 where upper(char_name) = upper('Young Charity');

-- Execute procedure
declare
    v_output varchar2(1000);
begin
    prc_entry_registration(
        16, -- Wartortle Warles competitor
        'RM Winter Series Caulfield 2025',
        '5 Km Run',
        null,
        'Young Charity',
        v_output
    );
    dbms_output.put_line(v_output);
end;
/

-- After values (should be same as before)
select *
  from charity
 where upper(char_name) = upper('Young Charity');

rollback;