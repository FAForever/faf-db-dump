UPDATE login SET login = concat('User_', id), 
email = concat(login, '@example.com'), 
ip = '127.0.0.1', 
password = sha2('foo', 256),
steamid = IF(steamid is null, null,FLOOR(id + (RAND() * ~0)));

# Delete now the games
CREATE TABLE tmp_games (
  id INT NOT NULL,
  PRIMARY KEY (id));

INSERT INTO tmp_games
SELECT id
     FROM game_stats
     ORDER BY RAND() LIMIT 10000;

DELETE FROM game_player_stats
WHERE gameId NOT IN
    (SELECT id
     FROM tmp_games);

DELETE FROM game_stats
WHERE id NOT IN
    (SELECT id
     FROM tmp_games);


TRUNCATE TABLE tmp_games;

INSERT INTO tmp_games
SELECT id
     FROM game_stats_bak
     ORDER BY RAND() LIMIT 50000;

DELETE FROM game_player_stats_bak
WHERE gameId NOT IN
    (SELECT id
     FROM tmp_games);

DELETE FROM game_stats_bak
WHERE id NOT IN
    (SELECT id
     FROM tmp_games);

DROP TABLE tmp_games;

TRUNCATE table unique_id_users;
TRUNCATE table unique_id_users_old;
TRUNCATE table uniqueid;
TRUNCATE table player_achievements;
DELETE FROM achievement_definitions;
TRUNCATE table player_events;

UPDATE jwt_users SET public_key = CONCAT('ssh-rsa <key>', id);
UPDATE name_history SET previous_name = CONCAT('name_', user_id);
UPDATE oauth_clients SET client_secret = CONCAT('secret of ', id);
UPDATE oauth_tokens SET access_token = CONCAT('access token of ', id),
refresh_token = CONCAT('refresh token of ', id);

UPDATE uniqueid_exempt SET reason = CONCAT('uniqueid_exempt.reason  ', user_id);
UPDATE vm_exempt SET reason = CONCAT('vm_exempt.reason  ', idUser);

# Correct checksum of migration
UPDATE `faf`.`schema_version` SET `checksum`='-427051799' WHERE `installed_rank`='18';
