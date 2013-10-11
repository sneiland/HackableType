DROP TABLE IF EXISTS users;
CREATE TABLE `hackableType`.`users` (`userid` INT NOT NULL AUTO_INCREMENT, `username` VARCHAR(50) NOT NULL, `password` VARCHAR(255) NOT NULL, `first_name` VARCHAR(50) NOT NULL, `last_name` VARCHAR(50) NOT NULL,`state` VARCHAR(2) NOT NULL,PRIMARY KEY (`userid`));
INSERT INTO `hackableType`.`users` (userid, username, password, first_name, last_name, state) VALUES (1, 'jdean', 'fcgh5', 'Jason', 'Dean', 'MN');
INSERT INTO `hackableType`.`users` (userid, username, password, first_name, last_name, state) VALUES (2, 'pfreitag', 'cgeht', 'Pete', 'Freitag', 'NY');
INSERT INTO `hackableType`.`users` (userid, username, password, first_name, last_name, state) VALUES (3, 'bforta', 'cdgwrh', 'Ben', 'Forta', 'MI');
DROP TABLE IF EXISTS creditcards;
CREATE TABLE `hackableType`.`creditcards` (`cc_id` INT NOT NULL, `cardholder_name` VARCHAR(50) NOT NULL, `card_no` VARCHAR(50), PRIMARY KEY (`cc_id`));
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (7999, 'Bob Silverberg', '2222222222222222');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8000, 'Jason Dean', '3333333333333333');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8001, 'Marc Esher', '4444444444444444');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8002, 'Peter Freitag', '5555555555555555');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8003, 'Bill Shelton', '6666666666666666');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8004, 'Scott Stroz', '7777777777777777');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8005, 'Ray Camden', '8888888888888888');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8006, 'Ben Forta', '9999999999999999');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8007, 'Jason Dean', '1111111111111111');
INSERT INTO `hackableType`.`creditcards` (cc_id, cardholder_name, card_no) VALUES (8015, 'Jason Dean', '0000000000000000');
DROP TABLE IF EXISTS user_cards;
CREATE TABLE `hackableType`.`user_cards` (`userid` INT NOT NULL,`cc_id` INT NOT NULL, PRIMARY KEY (`userid`,`cc_id`));
INSERT INTO `hackableType`.`user_cards` (userid, cc_id) VALUES (1,8000);
INSERT INTO `hackableType`.`user_cards` (userid, cc_id) VALUES (1,8007);
INSERT INTO `hackableType`.`user_cards` (userid, cc_id) VALUES (1,8015);
INSERT INTO `hackableType`.`user_cards` (userid, cc_id) VALUES (2,8002);
INSERT INTO `hackableType`.`user_cards` (userid, cc_id) VALUES (3,8006);