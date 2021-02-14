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
DELETE FROM email_domain_blacklist;
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
    id INT NOT NULL,
    PRIMARY KEY (id)
)
SELECT id FROM game_stats
ORDER BY RAND() LIMIT 10000;

-- Delete all game-related records we don't need
DELETE FROM matchmaker_queue_game
WHERE game_stats_id NOT IN
      (SELECT id FROM tmp_games);

DELETE FROM game_review
WHERE id NOT IN
      (SELECT id FROM tmp_games);

DELETE FROM game_reviews_summary
WHERE game_id NOT IN
      (SELECT id FROM tmp_games);

DELETE FROM leaderboard_rating_journal
WHERE game_player_stats_id NOT IN
      (SELECT gps.id FROM tmp_games
                              INNER JOIN game_player_stats gps ON tmp_games.id = gps.gameId);

DELETE FROM game_player_stats
WHERE gameId NOT IN
      (SELECT id
       FROM tmp_games);

DELETE FROM game_stats
WHERE id NOT IN
      (SELECT id
       FROM tmp_games);

DROP TABLE tmp_games;

-- **********************************************
-- Optimize dump size by throwing away large data
-- **********************************************
TRUNCATE TABLE player_achievements;
TRUNCATE TABLE player_events;
