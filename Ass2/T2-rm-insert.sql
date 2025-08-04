/*****PLEASE ENTER YOUR DETAILS BELOW*****/
--T2-rm-insert.sql

--Student ID: 33521026
--Student Name: Er Jun Yet

/*

I declared that the following test data was generated with the assistance of GitHub Copilot.

*/

/* Comments for your marker:



*/

-- Task 2 Load the COMPETITOR, ENTRY and TEAM tables with your own
-- test data following the data requirements expressed in the brief

-- =======================================
-- COMPETITOR
-- =======================================

-- Monash competitors
insert into competitor values ( 1,
                                'Charmander',
                                'Chin',
                                'M',
                                to_date('15-JAN-1995','DD-MON-YYYY'),
                                'charmander.chin@student.monash.edu',
                                'Y',
                                '0412345678' );

insert into competitor values ( 2,
                                'Hokaido',
                                'Okada',
                                'M',
                                to_date('22-MAR-1998','DD-MON-YYYY'),
                                'hokaido.okada@student.monash.edu',
                                'Y',
                                '0423456789' );

insert into competitor values ( 3,
                                'Blastoise',
                                'Noctis',
                                'M',
                                to_date('05-JUL-1990','DD-MON-YYYY'),
                                'blastoise.noctis@student.monash.edu',
                                'Y',
                                '0434567890' );

insert into competitor values ( 4,
                                'Articuno',
                                'Vale',
                                'F',
                                to_date('12-SEP-1993','DD-MON-YYYY'),
                                'articuno.vale@student.monash.edu',
                                'Y',
                                '0445678901' );

insert into competitor values ( 5,
                                'Charizard',
                                'Faulkner',
                                'M',
                                to_date('30-NOV-1988','DD-MON-YYYY'),
                                'charizard.faulkner@student.monash.edu',
                                'Y',
                                '0456789012' );

-- Non-Monash competitors
insert into competitor values ( 6,
                                'Eevee',
                                'Ellison',
                                'F',
                                to_date('18-FEB-2000','DD-MON-YYYY'),
                                'eevee.ellison@gmail.com',
                                'N',
                                '0467890123' );

insert into competitor values ( 7,
                                'Pikachu',
                                'Palmer',
                                'M',
                                to_date('25-APR-1997','DD-MON-YYYY'),
                                'pikachu.palmer@outlook.com',
                                'N',
                                '0478901234' );

insert into competitor values ( 8,
                                'Gengar',
                                'Graves',
                                'M',
                                to_date('08-JUN-1992','DD-MON-YYYY'),
                                'gengar.graves@yahoo.com',
                                'N',
                                '0489012345' );

insert into competitor values ( 9,
                                'Bulbasaur',
                                'Bennett',
                                'M',
                                to_date('14-AUG-1985','DD-MON-YYYY'),
                                'bulbasaur.bennett@gmail.com',
                                'N',
                                '0490123456' );

insert into competitor values ( 10,
                                'Gardevoir',
                                'Virelli',
                                'F',
                                to_date('03-OCT-1999','DD-MON-YYYY'),
                                'gardevoir.virelli@outlook.com',
                                'N',
                                '0411223344' );

insert into competitor values ( 11,
                                'Lucario',
                                'Cruz',
                                'M',
                                to_date('19-DEC-1994','DD-MON-YYYY'),
                                'lucario.cruz@gmail.com',
                                'N',
                                '0412334455' );

insert into competitor values ( 12,
                                'Mew',
                                'Fontaine',
                                'F',
                                to_date('27-JAN-1991','DD-MON-YYYY'),
                                'mew.fontaine@yahoo.com',
                                'N',
                                '0413445566' );

insert into competitor values ( 13,
                                'Rayquaza',
                                'Skye',
                                'M',
                                to_date('09-MAR-1987','DD-MON-YYYY'),
                                'rayquaza.skye@gmail.com',
                                'N',
                                '0414556677' );

insert into competitor values ( 14,
                                'Mimikyu',
                                'Morrin',
                                'U',
                                to_date('17-MAY-1996','DD-MON-YYYY'),
                                'mimikyu.morrin@outlook.com',
                                'N',
                                '0415667788' );

insert into competitor values ( 15,
                                'Sylveon',
                                'Lisa',
                                'F',
                                to_date('23-JUL-2001','DD-MON-YYYY'),
                                'sylveon.lisa@yahoo.com',
                                'N',
                                '0416778899' );

insert into competitor values ( 16,
                                'Wartortle',
                                'Warles',
                                'M',
                                to_date('11-SEP-1995','DD-MON-YYYY'),
                                'wartortle.warles@gmail.com',
                                'N',
                                '0417889999' );

insert into competitor values ( 17,
                                'Snorlax',
                                'Sullivan',
                                'M',
                                to_date('29-NOV-1989','DD-MON-YYYY'),
                                'snorlax.sullivan@gmail.com',
                                'N',
                                '0418900000' );
                                

-- =======================================
-- ENTRY
-- =======================================

-- Entries for RM Spring Series Clayton 2024 
insert into entry values ( 1,
                           1,
                           to_date('09:30:00','HH24:MI:SS'),
                           to_date('10:05:15','HH24:MI:SS'),
                           to_date('00:35:15','HH24:MI:SS'),
                           1,
                           null,
                           1 );

insert into entry values ( 1,
                           2,
                           to_date('09:30:00','HH24:MI:SS'),
                           to_date('10:12:45','HH24:MI:SS'),
                           to_date('00:42:45','HH24:MI:SS'),
                           2,
                           null,
                           2 );

insert into entry values ( 1,
                           3,
                           to_date('09:30:00','HH24:MI:SS'),
                           to_date('10:08:45','HH24:MI:SS'),
                           to_date('00:38:45','HH24:MI:SS'),
                           8,
                           null,
                           4 );

insert into entry values ( 2,
                           1,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:50:30','HH24:MI:SS'),
                           to_date('01:20:30','HH24:MI:SS'),
                           3,
                           null,
                           3 );

insert into entry values ( 2,
                           2,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:45:15','HH24:MI:SS'),
                           to_date('01:15:15','HH24:MI:SS'),
                           4,
                           null,
                           4 );

insert into entry values ( 2,
                           3,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:55:00','HH24:MI:SS'),
                           to_date('01:25:00','HH24:MI:SS'),
                           9,
                           null,
                           1 );

-- Entries for RM Spring Series Caulfield 2024 
insert into entry values ( 3,
                           1,
                           to_date('09:00:00','HH24:MI:SS'),
                           to_date('09:38:22','HH24:MI:SS'),
                           to_date('00:38:22','HH24:MI:SS'),
                           5,
                           null,
                           1 );

insert into entry values ( 3,
                           2,
                           to_date('09:00:00','HH24:MI:SS'),
                           to_date('09:42:10','HH24:MI:SS'),
                           to_date('00:42:10','HH24:MI:SS'),
                           6,
                           null,
                           2 );

insert into entry values ( 3,
                           3,
                           to_date('09:00:00','HH24:MI:SS'),
                           to_date('09:40:00','HH24:MI:SS'),
                           to_date('00:40:00','HH24:MI:SS'),
                           1,
                           null,
                           1 );

insert into entry values ( 3,
                           4,
                           to_date('09:00:00','HH24:MI:SS'),
                           to_date('09:45:30','HH24:MI:SS'),
                           to_date('00:45:30','HH24:MI:SS'),
                           10,
                           null,
                           2 );

insert into entry values ( 4,
                           1,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:55:45','HH24:MI:SS'),
                           to_date('01:25:45','HH24:MI:SS'),
                           7,
                           null,
                           3 );

insert into entry values ( 4,
                           2,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:48:30','HH24:MI:SS'),
                           to_date('01:18:30','HH24:MI:SS'),
                           8,
                           null,
                           4 );

insert into entry values ( 4,
                           3,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:52:15','HH24:MI:SS'),
                           to_date('01:22:15','HH24:MI:SS'),
                           2,
                           null,
                           2 );

insert into entry values ( 4,
                           4,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:58:15','HH24:MI:SS'),
                           to_date('01:28:15','HH24:MI:SS'),
                           11,
                           null,
                           3 );

insert into entry values ( 5,
                           1,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('10:30:15','HH24:MI:SS'),
                           to_date('02:30:15','HH24:MI:SS'),
                           9,
                           null,
                           1 );

insert into entry values ( 5,
                           2,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('10:35:30','HH24:MI:SS'),
                           to_date('02:35:30','HH24:MI:SS'),
                           3,
                           null,
                           3 );

insert into entry values ( 5,
                           5,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('10:40:00','HH24:MI:SS'),
                           to_date('02:40:00','HH24:MI:SS'),
                           12,
                           null,
                           4 );

-- Entries for RM Summer Series Caulfield 2025 
insert into entry values ( 6,
                           1,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('08:55:45','HH24:MI:SS'),
                           to_date('00:25:45','HH24:MI:SS'),
                           10,
                           null,
                           2 );

insert into entry values ( 6,
                           2,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('08:58:30','HH24:MI:SS'),
                           to_date('00:28:30','HH24:MI:SS'),
                           1,
                           null,
                           1 );

insert into entry values ( 6,
                           3,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:02:30','HH24:MI:SS'),
                           to_date('00:32:30','HH24:MI:SS'),
                           4,
                           null,
                           4 );

insert into entry values ( 7,
                           1,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:05:30','HH24:MI:SS'),
                           to_date('00:35:30','HH24:MI:SS'),
                           11,
                           null,
                           3 );

insert into entry values ( 7,
                           2,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:08:45','HH24:MI:SS'),
                           to_date('00:38:45','HH24:MI:SS'),
                           2,
                           null,
                           2 );

insert into entry values ( 7,
                           3,
                           to_date('08:30:00','HH24:MI:SS'),
                           to_date('09:12:15','HH24:MI:SS'),
                           to_date('00:42:15','HH24:MI:SS'),
                           5,
                           null,
                           1 );

insert into entry values ( 8,
                           1,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('09:15:45','HH24:MI:SS'),
                           to_date('01:15:45','HH24:MI:SS'),
                           12,
                           null,
                           4 );

insert into entry values ( 8,
                           2,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('09:20:15','HH24:MI:SS'),
                           to_date('01:20:15','HH24:MI:SS'),
                           3,
                           null,
                           3 );

insert into entry values ( 9,
                           1,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('10:45:30','HH24:MI:SS'),
                           to_date('02:45:30','HH24:MI:SS'),
                           13,
                           null,
                           1 );

insert into entry values ( 9,
                           2,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('10:50:45','HH24:MI:SS'),
                           to_date('02:50:45','HH24:MI:SS'),
                           4,
                           null,
                           4 );

-- Entries for RM Autumn Series Clayton 2025 
insert into entry values ( 10,
                           1,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('08:22:15','HH24:MI:SS'),
                           to_date('00:22:15','HH24:MI:SS'),
                           14,
                           null,
                           null );

insert into entry values ( 10,
                           2,
                           to_date('08:00:00','HH24:MI:SS'),
                           to_date('08:25:30','HH24:MI:SS'),
                           to_date('00:25:30','HH24:MI:SS'),
                           5,
                           null,
                           null );

insert into entry values ( 11,
                           1,
                           to_date('07:45:00','HH24:MI:SS'),
                           to_date('12:30:45','HH24:MI:SS'),
                           to_date('04:45:45','HH24:MI:SS'),
                           15,
                           null,
                           null );

-- Entries for RM Winter Series Caulfield 2025 (Jun 29)
-- Uncompleted entries
insert into entry values ( 12,
                           1,
                           null,
                           null,
                           null,
                           6,
                           null,
                           null );

insert into entry values ( 13,
                           1,
                           null,
                           null,
                           null,
                           7,
                           null,
                           null );

-- =======================================
-- TEAM
-- =======================================

-- Team 1 
insert into team values ( 1,
                          'Girl Gang',
                          to_date('22/SEP/2024','DD/MON/YYYY'),
                          1,
                          3 );

-- Team 2 
insert into team values ( 2,
                          'Champion 101',
                          to_date('05/OCT/2024','DD/MON/YYYY'),
                          2,
                          3 );

-- Team 3 
insert into team values ( 3,
                          'The Fantastic 4',
                          to_date('02/FEB/2025','DD/MON/YYYY'),
                          6,
                          1 );

-- Team 4 
insert into team values ( 4,
                          'Marathoners',
                          to_date('15/MAR/2025','DD/MON/YYYY'),
                          10,
                          1 );

-- Team 5 (reused name)
insert into team values ( 5,
                          'Girl Gang',
                          to_date('29/JUN/2025','DD/MON/YYYY'),
                          12,
                          1 );

-- Update all entries to add team members
-- Team 1 members
update entry
   set
    team_id = 1
 where event_id = 1
   and entry_no = 3;

update entry
   set
    team_id = 1
 where event_id = 1
   and entry_no = 1;

update entry
   set
    team_id = 1
 where event_id = 1
   and entry_no = 2;

update entry
   set
    team_id = 1
 where event_id = 2
   and entry_no = 1;

-- Team 2 members 
update entry
   set
    team_id = 2
 where event_id = 2
   and entry_no = 3;

update entry
   set
    team_id = 2
 where event_id = 2
   and entry_no = 2;

-- Team 3 members 
update entry
   set
    team_id = 3
 where event_id = 6
   and entry_no = 1;

update entry
   set
    team_id = 3
 where event_id = 7
   and entry_no = 1;

update entry
   set
    team_id = 3
 where event_id = 8
   and entry_no = 1;

update entry
   set
    team_id = 3
 where event_id = 9
   and entry_no = 1;

-- Team 4 members 
update entry
   set
    team_id = 4
 where event_id = 10
   and entry_no = 1;

update entry
   set
    team_id = 4
 where event_id = 11
   and entry_no = 1;

-- Team 5 members 
update entry
   set
    team_id = 5
 where event_id = 12
   and entry_no = 1;

update entry
   set
    team_id = 5
 where event_id = 13
   and entry_no = 1;


commit;