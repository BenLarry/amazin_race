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
    points INT DEFAULT NULL,
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

CREATE TABLE highscore(
    ID INT NOT NULL auto_increment,
    score INT NOT NULL DEFAULT 0,
    PRIMARY KEY(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE player_highscore(
    player_ID INT,
    highscore_ID INT,
    PRIMARY KEY(player_ID, highscore_ID),
    FOREIGN KEY(player_ID) REFERENCES player(ID),
    FOREIGN KEY(highscore_ID) REFERENCES highscore(ID)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE game(
    ID INT auto_increment NOT NULL,
    player_ID INT NOT NULL,
    start_airport VARCHAR(40),
    end_airport VARCHAR(40),
    is_over BOOLEAN NOT NULL DEFAULT 0,
    PRIMARY KEY(ID),
    FOREIGN KEY(player_ID) REFERENCES player(ID),
    FOREIGN KEY(start_airport) REFERENCES airport(ident),
    FOREIGN KEY(end_airport) REFERENCES airport(ident)
)ENGINE=InnoDB DEFAULT CHARSET=latin1;