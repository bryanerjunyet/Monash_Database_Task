/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T6-rm-json.sql

--Student ID: 33521026
--Student Name: Er Jun Yet


/* Comments for your marker:




*/


-- SQL generate JSON documents for teams
select
    json_object(
        '_id' value t.team_id,
                'carn_name' value c.carn_name,
                'carn_date' value to_char(
            c.carn_date,
            'DD-MON-YYYY'
        ),
                'team_name' value t.team_name,
                'team_leader' value(
            select
                json_object(
                    'name' value cl.comp_fname
                                 || ' '
                                 || cl.comp_lname,
                            'phone' value nvl(
                        cl.comp_phone,
                        '-'
                    ),
                            'email' value nvl(
                        cl.comp_email,
                        '-'
                    )
                )
              from entry el
              join competitor cl
            on el.comp_no = cl.comp_no
             where el.event_id = t.event_id
               and el.entry_no = t.entry_no
        ),
                'team_no_of_members' value(
            select count(*)
              from entry e
             where e.team_id = t.team_id
        ),
                'team_members' value(
            select json_arrayagg(
                json_object(
                    'competitor_name' value cm.comp_fname
                                            || ' '
                                            || cm.comp_lname,
                            'competitor_phone' value nvl(
                        cm.comp_phone,
                        '-'
                    ),
                            'event_type' value et.eventtype_desc,
                            'entry_no' value e.entry_no,
                            'starttime' value nvl(
                        to_char(
                            e.entry_starttime,
                            'HH24:MI:SS'
                        ),
                        '-'
                    ),
                            'finishtime' value nvl(
                        to_char(
                            e.entry_finishtime,
                            'HH24:MI:SS'
                        ),
                        '-'
                    ),
                            'elapsedtime' value nvl(
                        to_char(
                            e.entry_elapsedtime,
                            'HH24:MI:SS'
                        ),
                        '-'
                    )
                )
            )
              from entry e
              join competitor cm
            on e.comp_no = cm.comp_no
              join event ev
            on e.event_id = ev.event_id
              join eventtype et
            on ev.eventtype_code = et.eventtype_code
             where e.team_id = t.team_id
        )
    format json)
    || ','
  from team t
  join carnival c
on t.carn_date = c.carn_date
  join event ev
on t.event_id = ev.event_id
  join eventtype et
on ev.eventtype_code = et.eventtype_code
 order by t.team_id;