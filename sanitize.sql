-- ********************************************
-- Delete secret data & anonymize personal data
-- ********************************************
UPDATE login SET
                 email = concat(concat('user', id), '@faforever-test.com'),
                 password = sha2('foo', 256),
                 ip = concat('10.0.0.', FLOOR(RAND()*254)),
                 steamid = IF(steamid IS NULL, NULL, id*10000),
                 last_login = now();
UPDATE name_history SET previous_name = CONCAT('name_', user_id);
UPDATE oauth_clients SET client_secret = concat('{noop}', name)
    WHERE client_type = 'confidential';
UPDATE jwt_users SET public_key = CONCAT('ssh-rsa <key>', id);
DELETE FROM oauth_tokens;
DELETE FROM friends_and_foes;
DELETE FROM teamkills;
DELETE FROM user_notes;
DELETE FROM reported_user;
DELETE FROM ban;
DELETE FROM moderation_report;
DELETE FROM unique_id_users;
DELETE FROM uniqueid_exempt;
DELETE FROM vm_exempt;
DELETE FROM voting_answer;
DELETE FROM vote;

-- ******************************
-- Reset user passwords to banana
-- ******************************
ALTER USER 'faf-anope'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-java-api'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-java-server'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-legacy-apps'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-legacy-live-replay-server'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-legacy-secondary-server'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-legacy-updater'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-mautic'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-murmur'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-mysql-exporter'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-phpbb3'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-policy-server'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-postal'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-python-server'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-softvote'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-wiki'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf-wordpress'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf_lobby'@'%' IDENTIFIED BY 'banana';
ALTER USER 'faf_wiki'@'%' IDENTIFIED BY 'banana';
ALTER USER 'root'@'%' IDENTIFIED BY 'banana';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED BY 'banana';
ALTER USER 'root'@'localhost' IDENTIFIED BY 'banana';


-- *****************************************
-- Reduce dataset of games to a limited size
-- *****************************************

-- Collect random games to keep
CREATE TABLE tmp_games
(
    id INT UNSIGNED PRIMARY KEY,
    FOREIGN KEY `games` (id) REFERENCES game_stats (id)
)
SELECT id FROM game_stats
ORDER BY RAND() LIMIT 10000;

-- Clean their references

DELETE FROM coop_leaderboard
WHERE gameuid NOT IN
      (SELECT id FROM tmp_games);
OPTIMIZE TABLE coop_leaderboard;

-- Delete all game-related records we don't need
DELETE FROM matchmaker_queue_game
WHERE game_stats_id NOT IN
      (SELECT id FROM tmp_games);
OPTIMIZE TABLE matchmaker_queue_game;

DELETE FROM game_review
WHERE id NOT IN
      (SELECT id FROM tmp_games);
OPTIMIZE TABLE game_review;

DELETE FROM game_reviews_summary
WHERE game_id NOT IN
      (SELECT id FROM tmp_games);
OPTIMIZE TABLE game_reviews_summary;

DELETE FROM leaderboard_rating_journal
WHERE game_player_stats_id NOT IN
      (SELECT gps.id FROM tmp_games
                              INNER JOIN game_player_stats gps ON tmp_games.id = gps.gameId);
OPTIMIZE TABLE leaderboard_rating_journal;

DELETE FROM game_player_stats
WHERE gameId NOT IN
      (SELECT id
       FROM tmp_games);
OPTIMIZE TABLE game_player_stats;


-- PROBLEM: You don't want to delete all games for 5 hours and then fail because of a new
-- foreign key constraint! Also this causes massive overhead due to InnoDB consistency logs.
-- SOLUTION: Iterate the loop n-times for n-million game stats
SELECT count(*) / 1000000 as n FROM game_stats;

-- ** LOOP BEGIN **
CREATE TEMPORARY TABLE IF NOT EXISTS to_delete_game_stats(
    id int unsigned PRIMARY KEY
)
SELECT id from game_stats
where id not in (SELECT gameId from tmp_games)
    limit 1000000;

DELETE game_stats
FROM game_stats
WHERE id in (SELECT id from to_delete_game_stats);

DROP TEMPORARY table to_delete_game_stats;
-- ** LOOP END **

DROP TABLE tmp_games;

-- *******************************************************
-- Optimize dump size by keeping small sizes of large data
-- *******************************************************
DELETE FROM email_domain_blacklist WHERE RAND() <= 0.01;
OPTIMIZE TABLE email_domain_blacklist;
DELETE FROM uniqueid WHERE RAND() <= 0.01;
OPTIMIZE TABLE uniqueid;

CREATE TEMPORARY TABLE keep_event
SELECT event_id FROM player_events LIMIT 1;

DELETE player_events
FROM player_events INNER JOIN keep_event ON player_events.event_id = keep_event.event_id
WHERE RAND() <= 0.001;
OPTIMIZE TABLE player_events;

DROP TEMPORARY TABLE keep_event;

CREATE TEMPORARY TABLE keep_achievement
SELECT id FROM achievement_definitions LIMIT 1;


CREATE TEMPORARY TABLE keep_achievement
SELECT id FROM achievement_definitions LIMIT 1;

DELETE player_achievements
FROM player_achievements INNER JOIN keep_achievement ON player_achievements.achievement_id = keep_achievement.id
WHERE RAND() <= 0.001;
OPTIMIZE TABLE player_achievements;

DROP TEMPORARY TABLE keep_achievement;


-- *******************************************
-- Reduce dataset of players to a limited size
-- *******************************************

CREATE TEMPORARY TABLE keep_players
(
    id mediumint UNSIGNED PRIMARY KEY
)
SELECT DISTINCT host as id from game_stats UNION
SELECT DISTINCT playerId as id from game_player_stats UNION
SELECT DISTINCT uploader as id FROM `mod` WHERE uploader IS NOT NULL UNION
SELECT DISTINCT author as id FROM map where author IS NOT NULL UNION
SELECT DISTINCT user_id as id FROM map_version_review UNION
SELECT DISTINCT user_id as id FROM mod_version_review UNION
SELECT DISTINCT founder_id as id FROM clan UNION
SELECT DISTINCT player_id as id FROM clan_membership UNION
SELECT DISTINCT idUser FROM avatars UNION
SELECT DISTINCT player_id as id FROM player_achievements UNION
SELECT DISTINCT player_id as id FROM player_events
;

DELETE FROM leaderboard_rating
WHERE login_id NOT IN (SELECT id FROM keep_players);
OPTIMIZE TABLE leaderboard_rating;

DELETE FROM login
WHERE id NOT IN (SELECT id FROM keep_players);

DROP TEMPORARY TABLE keep_players;
