CREATE TABLE country (
  iso_country varchar(40) NOT NULL,
  name varchar(40) DEFAULT NULL,
  continent varchar(40) DEFAULT NULL,
  wikipedia_link varchar(40) DEFAULT NULL,
  keywords varchar(40) DEFAULT NULL,
  PRIMARY KEY (iso_country)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE airport (
  id int(11) NOT NULL,
  ident varchar(40) NOT NULL,
  name varchar(40) DEFAULT NULL,
  type varchar(40) DEFAULT NULL,
  latitude_deg double DEFAULT NULL,
  longitude_deg double DEFAULT NULL,
  elevation_ft int(11) DEFAULT NULL,
  continent varchar(40) DEFAULT NULL,
  iso_country varchar(40) DEFAULT NULL,
  iso_region varchar(40) DEFAULT NULL,
  municipality varchar(40) DEFAULT NULL,
  scheduled_service varchar(40) DEFAULT NULL,
  gps_code varchar(40) DEFAULT NULL,
  iata_code varchar(40) DEFAULT NULL,
  local_code varchar(40) DEFAULT NULL,
  home_link varchar(40) DEFAULT NULL,
  wikipedia_link varchar(40) DEFAULT NULL,
  keywords varchar(40) DEFAULT NULL,
  PRIMARY KEY (ident),
  KEY iso_country (iso_country),
  CONSTRAINT airport_ibfk_1 FOREIGN KEY (iso_country) REFERENCES country (iso_country)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE player(
    ID INT NOT NULL auto_increment,
    name VARCHAR(40) DEFAULT NULL,
    location VARCHAR(40),
    PRIMARY KEY(ID),
    FOREIGN KEY(location) REFERENCES airport(ident)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE chosen_airports(
    ID INT NOT NULL auto_increment,
    ident VARCHAR(40),
    special BOOLEAN DEFAULT 0,
    visited BOOLEAN DEFAULT 0,
    PRIMARY KEY(ID),
    FOREIGN KEY(ident) REFERENCES airport(ident)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE answer(
    ID INT NOT NULL auto_increment,
    choice varchar(1000),
    is_correct BOOLEAN DEFAULT 0,
    PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE task(
    ID INT NOT NULL auto_increment,
    question VARCHAR(1000) DEFAULT NULL,
    points INT,
    level INT,
    PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE task_choices(
    task_ID INT,
    answer_ID INT,
    PRIMARY KEY(task_ID, answer_ID),
    FOREIGN KEY(task_ID) REFERENCES task(ID),
    FOREIGN KEY(answer_ID) REFERENCES answer(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE chosen_tasks(
    ID INT NOT NULL auto_increment,
    player_ID INT,
    task_ID INT,
    answered BOOLEAN DEFAULT 0,
    PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE player_games(
    player_ID INT,
    game_ID INT,
    PRIMARY KEY(player_ID, game_ID),
    FOREIGN KEY(player_ID) REFERENCES player(ID),
    FOREIGN KEY(game_ID) REFERENCES game(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE game(
    ID INT auto_increment NOT NULL,
    player_ID INT NOT NULL,
    start_airport VARCHAR(40),
    end_airport VARCHAR(40),
    is_over BOOLEAN NOT NULL DEFAULT 0,
    co2_consumed INT DEFAULT 0,
    points INT DEFAULT 0,
    PRIMARY KEY(ID),
    FOREIGN KEY(player_ID) REFERENCES player(ID),
    FOREIGN KEY(start_airport) REFERENCES airport(ident),
    FOREIGN KEY(end_airport) REFERENCES airport(ident)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO task (question, points, level)
VALUES ("Mikä on Espanjan pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Barcelona", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Valencia", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Madrid", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Ruotsin pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Göteborg", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Malmö", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tukholma", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka sävelsi 'Für Elise'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Johann Sebastian Bach", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Wolfgang Amadeus Mozart", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ludwig van Beethoven", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kemiallinen merkki hopealle?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Au", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pb", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ag", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka keksi kirjapainotaidon länsimaissa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Thomas Edison", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Benjamin Franklin", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Johannes Gutenberg", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti teoksen 'Sadan vuoden yksinäisyys'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pablo Neruda", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Julio Cortázar", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Gabriel García Márquez", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä planeetta tunnetaan punaisena planeettana?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Venus", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jupiter", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Mars", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä aine on yleisin maapallon ilmakehässä?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Happi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hiilidioksidi", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Typpi", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä kaupungissa järjestettiin vuoden 2012 kesäolympialaiset?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Rio de Janeiro", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Peking", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lontoo", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kehitti evoluutioteorian luonnonvalinnan kautta?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Gregor Mendel", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Louis Pasteur", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Charles Darwin", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä on kemiallinen merkki natriumille?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("N", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nt", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Na", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka maalasi 'Guernican'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Salvador Dalí", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Henri Matisse", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pablo Picasso", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä eläin tunnetaan 'aavikon laiva' nimellä?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Dromedaari", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Seepro", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kameli", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä kaupunki on Italian moda- ja muotikeskus, tunnettu muotitaloistaan?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Rooma", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Napoli", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Milano", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kiinalaisen uudenvuoden eläin vuonna 2024?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tiikeri", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kani", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lohikäärme", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä kemiallinen aine on vedyn ja hapen yhdistelmä, kaavalla H2O?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ammoniakki", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Metaani", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vesi", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti 'Rikos ja rangaistus'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leo Tolstoi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anton Tšehov", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fjodor Dostojevski", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä kaupunki tunnetaan "Syntien kaupunki" nimellä Yhdysvalloissa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Atlantic City", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Reno", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Las Vegas", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä on ihmisen pääasiallinen hapenkuljettaja verenkierrossa?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Plasma", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leukosyytit", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hemoglobiini", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman vanhin tunnettu kirjoitettu kieli (laajalti tunnustettu)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Latina", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kreikka", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sumerin kieli", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä eläin laulaa 'laulullaan' ja rakentaa monimutkaisia pesiä, tunnettu 'laululintu'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tukaani", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Punatulkku", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Satakieli", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä on ohjelmointikieli, jota käytetään laajasti data-analyysissä ja koneoppimisessa (lyhyt nimi)?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Java", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("C++", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Python", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on yleinen nimi ionille, jolla on negatiivinen varaus?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kationi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Neutriini", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anioni", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli muinaisen Kreikan filosofi, joka opetti Platonin ja perusti oman koulun, myös tunnettu systemaattisesta filosofiastaan?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sokrates", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Platon", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Aristoteles", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Iso-Britannian pisin joki?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Thames", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Loire", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Severn", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman suurin makean veden järvi tilavuudeltaan?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Superior", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Victoria", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Baikal", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä ajanjakso tunnetaan renessanssina (maailmankulttuurissa)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("n. 900–1100", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1800–1900", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("n. 1300–1600", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä maa käyttää valuuttana rupiaa (INR on kansallisen valuutan lyhenne)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pakistan", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Indonesia", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Intia", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä kaupunki tunnetaan 'Taivaanlahden helmi' -lempinimellä Kiinassa?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Beijing", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Guangzhou", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Shanghai", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä on elektronin sähkövaraus (merkki ja yksikkö) (absoluuttinen arvo)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("+1 e", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("0 e", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("-1 e", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä on nimenomaan kananmunan kuoren pääasiallinen mineraali?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kalsiumfosfaatti", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Magnesiumoksidi", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kalsiumkarbonaatti", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti 'Odysseian' ja 'Iliasin' (perinteisesti)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Virgil", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sophocles", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Homerus", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman syvin kohta valtameressä?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tonga-kuilu", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kermadec-kuilu", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Mariaanien hauta", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä maa tunnetaan tango-musiikistaan ja Buenos Airesin kaupunkikulttuuristaan?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Chile", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Uruguay", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Argentiina", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli kuuluisa fyysikko, joka löysi painovoiman lait (klassinen mekaniikka)?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Galileo Galilei", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Albert Einstein", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Isaac Newton", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kansalliskieli Brasiliassa?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Espanja", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Inglês", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Portugali", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kemiallinen kaava ruokasuolalle (natriumkloridi)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("KCl", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Na2SO4", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("NaCl", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Kuka oli tunnettu Nerokas keksijä ja kehittäjä, jonka nimi yhdistetään hehkulamppuun ja moniin keksintöihin?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nikola Tesla", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Alexander Graham Bell", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Thomas Edison", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);


INSERT INTO task (question, points, level)
VALUES ("Mikä eläin on tunnettu mustavalkoisista raitaveistään ja kuuluu hevoseläimiin?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leijona", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kirahvi", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Seepra", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman yleisin veriryhmä (maailmanlaajuisesti)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("A (II) positiivinen", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("B (III) positiivinen", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("O (I) positiivinen", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti romaanin 'Anna Karenina'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fyodor Dostoyevsky", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anton Chekhov", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leo Tolstoi", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä vuosi merkitsi toisen maailmansodan alkua?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1914", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1945", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1939", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on pienen planeetan asteroidivyöhykkeen sisällä kuuluisa planeetta?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vesta", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pallas", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ceres", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Italian kuuluisan autonvalmistajan Ferrari kotipaikka (kaupunki)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Turin", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Milan", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Maranello", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on yleinen syy tulivuorenpurkaukseen maantieteellisesti?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ilmastonmuutos", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Auringon aktiivisuus", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tekttonisten laattojen liike", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on vaakasuora mittayksikkö, joka on 100 senttimetriä?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kilometri", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Millimetri", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Metri", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on tunnettu ranskalainen leivos, jonka nimi tarkoittaa 'pieni leivos'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Croissant", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Éclair", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Macaron", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka sävelsi 'Swan Lake'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sergei Rachmaninov", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Dmitri Shostakovich", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pjotr Tšaikovski", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman laajin metsäalue (sademetsä)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kongo", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kaakkois-Aasian metsät", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Amazon", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä eläin on Australian tunnettu marsupiali, jolla on pussielin?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Koala", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Wombat", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kenguru", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä sana kuvaa 'maailmanlaajuista lämpenemistä' englanniksi?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Acid rain", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ozone depletion", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Global warming", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Euroopan unionin virallinen pääkaupunki (komission sijainti)?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Strasbourg", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Luxembourg", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bryssel", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli kuuluisa renessanssiajan monialainen nero, joka maalasi mm. 'Viimeisen ehtoollisen'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Michelangelo", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Raphael", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leonardo da Vinci", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kansainvälinen lentokenttäkoodi Helsingin lentoasemalle?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("HSL", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("HFI", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("HEL", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kemiallinen merkki kullalle?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ag", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pt", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Au", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on tärkein polttoaine autoissa, joita ei käytetä sähköllä (perinteisesti)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vety", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kaasu", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bensiini", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Yhdysvaltojen itsenäisyyspäivän päivämäärä?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1. tammikuuta 1776", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("25. joulukuuta 1776", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("4. heinäkuuta 1776", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on perinteinen Japanilainen taidemuoto, jossa käytetään viestintää musteella ja harjalla?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Origami", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ikebana", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Shodō (kalligrafia)", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä lintu on kansallislintu Yhdysvalloissa?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Amerikanhuuhkaja", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Maakotka", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Valkopäämerikotka", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on perinteinen peruselintarike Italiassa, jota käytetään pizza- ja pastakastikkeissa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Peruna", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Maissi", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tomaatti", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on yleinen tapa ehkäistä influenssaa vuosittain?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Antibiootit", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vitamiinit", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Rokotukset", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Tanska pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Älborg", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Esbjerg", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kööpenhamina", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä tapahtuma aloitti ensimmäisen maailmansodan vuonna 1914?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Versailles'n sopimus", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Saksan hyökkäys Belgiaan", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Herttua Franz Ferdinandin murha", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Bulgarian pääkaupunki?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Burgas", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sofia", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Varna", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti teoksen 'Anna Karenina'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anton Tšehov", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leo Tolstoi", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fjodor Dostojevski", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä planeetta tunnetaan 'sinisenä planeettana'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Maa", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Uranus", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Neptunus", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka sävelsi sinfonian nro. 9 'Oodi ilolle'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Haydn", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Mozart", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ludwig van Beethoven", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kemiallinen merkki hiilelle?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("C", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("H", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("O", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä instrumentti on klassisesti puhallinsoitin,jossa on avaimet?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Viulu", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Saksofoni", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Trumpetti", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuinka monta pelaajaa on koripallojoukkueessa kentällä per joukkue?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("6", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("4", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("5", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä yritys teki ensimmäisen kaupallisen henkilökohtaisen tietokoneen?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Microsoft", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("IBM", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Apple", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Saksan pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("München", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Berliini", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Frankfurt", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuinka monta pelaajaa on jääkiekkojoukkueessa kentällä per joukkue?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("5", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("6", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("7", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti 'Mestarikertomuksia'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Dostojevski", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hemingway", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tolstoi", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuinka monta pelaajaa on lentopallojoukkueessa kentällä per joukkue?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("5", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("7", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("6", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Turkin pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ankara", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Istanbul", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Izmir", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on maailman korkein vuori Mt. Everestin jälkeen?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lhotse", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("K2", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kangchenjunga", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on HTTP-protokollan tarkoitus verkossa?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tiedostojen lataus", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sähköpostin lähetys", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Web-sivujen siirto", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Serbian pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Belgrad", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Novi sad", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nis", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on yleinen yksikkö etäisyyden mittaamiseen avaruudessa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Valovuosi", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kilometri", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Astronominen yksikkö", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä energia on liikkeen energiaa?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Potentiaalienergia", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kinetiikkaenergia", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lämpöenergia", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä valtio on pinta-alaltaan maailman suurin?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kanada", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Venäjä", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kiina", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä maassa sijaitsee Salar de Uyuni -suolatasanko?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Peru", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Chile", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bolivia", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä maassa järjestettiin Baltian itsenäisyyspäivät 1991 vahvistuneessa järjestyksessä? (yksi maa)", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Viro", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Latvia", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Liettua", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Kroatian pääkaupunki?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Zadar", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Zagreb", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Rijeka", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Unkarin pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pecs", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Gyor", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Budapest", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä tunnettu kirjailija loi Sherlock Holmes -hahmon?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Agatha Christie", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Arthur Conan Doyle", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Edgar Allan Poe", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Australian suurin kaupunki väkiluvultaan?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Brisbane", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sydney", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Melbourne", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on planeetta, jolla on renkaat näkyvästi?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jupiter", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Neptunus", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Saturnus", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka on säveltänyt Suomen kansallishymnin (Maamme-laulu)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jean Sibelius", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fredrik Pacius", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Elias Lönnrot", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti 'Mestarikertomuksia'?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tolstoi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hemingway", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Dostojevski", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mitä lajia pelaa tunnettu urheiija Serena Williams?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Golfia", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sulkapalloa", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tennistä", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä elokuva voitti parhaan elokuvan Oscarin vuonna 1994?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Forrest Gump", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Shawshank Redemption", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pulp Fiction", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on sähkön yksikkö SI-järjestelmässä?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Watti", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ampeeri", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Voltti", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mitä lajia pelaa tunnettu urheilija Tom Brady?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Amerikkalaista jalkapalloa", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("koripalloa", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jääkiekkoa", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka ohjasi elokuvan 'E.T. the Extra-Terrestrial'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Steven Spielberg", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("George Lucas", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("James Cameron", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti 'Sota ja rauha'?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anton Tšehov", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leo Tolstoi", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fjodor Dostojevski", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä kaupungissa allekirjoitettiin Euroopan unionin peruskirja?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Maastricht", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Strasbourg", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Brussels", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Egyptin pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kairo", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Alexandria", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Giza", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mitä lajia pelaa uhrjeilija Michael Jordan?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jalkapalloa", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Koripalloa", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Amerkkalaista jalkapallloa", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Romanian pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bucuresti", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Timisoara", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Clij-Napoca", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli hollantilainen postimpressionistinen maalari, joka maalasi 'Tähdenlento' ja 'Irikkaat pellot'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vincent van Gogh", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Claude Monet", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pablo Picasso", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä juhla Suomessa vietetään kesäkuussa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Juhannus", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Pääsiäinen", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vappu", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Euroopan unionin lippujen väri ja kuinka monta tähtiä siinä on?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vihreä ja 10 tähteä", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Punainen ja 27 tähteä", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sininen lipussa ja 12 tähteä", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli Neuvostoliiton johtaja toisen maailmansodan aikaan?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Josif Stalin", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vladimir Lenin", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nikita Hruštšov", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä maa tunnetaan viinintuotannostaan Bordeaux'n alueella?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Espanja", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ranska", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Italia", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on GPS-järjestelmässä käytettävä lyhenne (englanniksi)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Global Position Satellite", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Global Positioning System", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Geosynchronous Positioning System", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on fotosynteesin päätytuote kasveille (sokeri tyyppinen)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Happea", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Karboksyylihappo", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Glukoosi", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä maassa sijaitsee Machu Picchu?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Peru", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bolivia", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Chile", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuinka monta pelaajaa on jalkapallojoukkueessa kentällä kerrallaan per joukkue?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("10", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("12", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("11", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Norjan pisin vuono?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sognefjord", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hardangerfjord", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Geirangerfjord", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli Rooman ensimmäinen keisari?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nero", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Augustus", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Cicero", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka tunnettu tiedemies liitetään nimeen 'penisilliinin löytäjä'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Louis Pasteur", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Edward Jenner", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Alexander Fleming", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on kudoksen perusyksikkö elimistössä?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Solu", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kudos", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Elin", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka on kaikkien aikojen ennätysmies miesten 100 metrin juoksussa (maailmanennätys 9.58)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Usain Bolt", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Carl Lewis", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Justin Gatlin", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on ihmisen kehon suurin luu?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Reisi", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Selkäranka", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sääri", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on japanin kirjoitusjärjestelmä, joka käyttää kolmea eri merkistöä?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kanji", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Hangul", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Cyrillica", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuinka monta kierrosta on täydessä Formula 1 -kilpailussa yleensä (vaihtelee)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("50", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("20", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Riippuu radasta", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on yleinen tiedonsiirtoprotokolla verkossa turvallisena versioisena? (https)", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Telnet", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("TLS/SSL", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("FTP", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Irlanti pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Dublin", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Galway", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Cork", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on korkein rakennus Euroopassa (2020-luvulla)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Commerzbank Tower", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Shard", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lakhta Center", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Missä maassa järjestettiin vuoden 2016 kesäolympialaiset?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Brasilia (Rio de Janeiro)", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Yhdysvallat (Los Angeles)", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kiina (Beijing)", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Albania pääkaupunki?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vlore", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Golem", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tirana", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä suomalainen elokuvaohjaaja tunnetaan elokuvasta 'Tuntematon sotilas' (uusinta versio)?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Renny Harlin", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Aki Kaurismäki", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Aku Louhimies", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka johti Neuvostoliittoa 1920-luvulla ja oli vallankumouksen tärkeä hahmo?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Josef Stalin", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leon Trotski", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vladimir Lenin", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä kaupunki sijaitsee useamman saaren päällä ja on Alaskan osavaltiossa? (USA)", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Fairbanks", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Anchorage", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Juneau", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä instrumentti on pianon sukulainen ja koskettimilla varustettu?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Flyygeli/Urut", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Trumpetti", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Viulu", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä kaupunki tunnetaan vapaudenpatsaan sijaintikaupunkina?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("New York", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Paris", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("London", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Liettua pääkaupunki?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Klaipeda", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vilna", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kaunas", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä vitamiini tunnetaan A-vitamiinina?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tokoferoli", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Retinoli", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Askorbiini", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kehitti painokoneen länsimaissa (keksintö 1400-luvulla)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Benjamin Franklin", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Johannes Gutenberg", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Alexander Graham Bell", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä merivirta vaikuttaa Länsi-Euroopan ilmastoon lämmittävästi?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kuroshio", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Gulf Stream", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Canary Current", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka tunnettu tiedemies liittyy merkittävästi: vuorovaikutukset sähkömagneettisessa tutkimuksessa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Guglielmo Marconi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Thomas Edison", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Nikola Tesla", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on tietokoneen tallennuslaite, joka käyttää magneettista levyä ja pyörivää alustaa?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Kiintolevy (HDD)", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("SSD", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("USB-muistitikku", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on älypuhelimissa yleisesti käytetty kosketusnäytön tekniikkaa kuvaava sana?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Capacitive (kapasitiivinen) näyttö", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Resistiivinen näyttö", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("OLED (on display tech)", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka on suomalainen kirjailija, joka kirjoitti 'Kalevala' -runoteoksen? (kokoelma koostui)", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Elias Lönnrot", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("J.L. Runeberg", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Aleksis Kivi", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä italialainen näyttelijä ja ohjaaja tunnetaan elokuvasta 'La Dolce Vita'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Vittorio De Sica", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Federico Fellini", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Sergio Leone", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka on maailman paras jalkapallon pelaaja", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lionel Messi", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Cristiano Ronaldo", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Neymar", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Norja pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Bergen", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Oslo", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Trondheim", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Linnunradan galaksin nimi englanniksi?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Triangulum", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Andromeda", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Milky Way", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka tunnettu tiedemies liittyy radiumin tutkimiseen?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Marie Curie", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ada Lovelace", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Rosalind Franklin", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Minä vuonna Berliinin muuri murtui?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1991", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1989", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1987", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Yhdysvaltojen pääkaupunki?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("New York", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Los Angeles", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Washington D.C.", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Pythagoraan lauseessa tunnettu suhde kolmion sivuilla?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("a + b = c", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("a^2 + b^2 = c^2", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("a^2 - b^2 = c^2", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Milloin Ranskan suuri vallankumous alkoi Bastiljin valtauksella?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1789", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1776", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1799", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka kirjoitti romaanin 'Pieni prinsessa' (The Little Prince) alkuperäiskielellä?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Jules Verne", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Victor Hugo", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Antoine de Saint-Exupéry", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Portugali pääkaupunki?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Lissabon", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Porto", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Aveiro", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka näytteli pääosaa elokuvassa 'Titanic' (miespääosa)?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Brad Pitt", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Leonardo DiCaprio", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Tom Cruise", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on matematiikassa luvun pi likiarvo kahdella desimaalilla?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("3.14", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1.62", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("2.72", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on Star Wars -elokuvien alkuperäinen ohjaaja?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("George Lucas", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("J.J. Abrams", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Irvin Kershner", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Milloin Yhdysvallat laskeutui kuuhun (Apollo 11)?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1969", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1972", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("1965", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä on internetin alkuperäinen lyhenne 'WWW' englanniksi?", 50, 1);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("World Web Wide", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("World Wide Web", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Wide World Web", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka ohjasi elokuvan 'Inception'?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Steven Spielberg", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("James Cameron", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Christopher Nolan", 1);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Mikä ohjelmointikieli on yleisesti käytössä web-kehityksessä front-endissä?", 75, 2);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("JavaScript", 1);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("C#", 0);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Python", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);

INSERT INTO task (question, points, level)
VALUES ("Kuka oli Ranskan kuuluisin kuningas, joka hallitsi 1700-luvulla ja tunnetaan suurvalta-ajasta?", 100, 3);
SET @task_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ludvig XVI", 0);
SET @answer1_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Ludvig XIV", 1);
SET @answer2_id = LAST_INSERT_ID();

INSERT INTO answer (choice, is_correct) VALUES ("Henrik IV", 0);
SET @answer3_id = LAST_INSERT_ID();

INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer1_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer2_id);
INSERT INTO task_choices (task_ID, answer_ID) VALUES (@task_id, @answer3_id);