DROP DATABASE IF EXISTS foodPlanner;
CREATE DATABASE foodPlanner;

\c foodPlanner;

DROP TABLE IF EXISTS Recipes;
DROP TABLE IF EXISTS Cuisines;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS UserTypes;

CREATE TABLE UserTypes(
    utid SERIAL PRIMARY KEY, 
    name TEXT
);

CREATE TABLE Users (
  uid SERIAL PRIMARY KEY,
  name TEXT,
  utid INT,
  FOREIGN KEY (utid) references UserTypes(utid)
);

-- CREATE TABLE User_N(
--     uid  INT PRIMARY KEY,
--     name     TEXT, 
--     tid  INT, 
--     );


CREATE TABLE Cuisines (
  cid SERIAL PRIMARY KEY,
  name TEXT
);

CREATE TABLE Recipes (
  rid SERIAL PRIMARY KEY,
  name TEXT,
  cid INT,
  instructions TEXT[],
  FOREIGN KEY (cid) references Cuisine(cid)
);

INSERT INTO UserTypes (name)
  VALUES ('Regular');

INSERT INTO UserTypes (name)
  VALUES ('Admin');

INSERT INTO Cuisine (name)
  VALUES ('American');

INSERT INTO Recipes (name, cid, instructions)
  VALUES ('Scrambled Eggs', '1', ARRAY['Crack eggs in hot oil', 'Scramble a bit when it starts setting', 'Add salt to taste', 'Serve hot']);