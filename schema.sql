CREATE TABLE animals (
   id integer PRIMARY KEY,
   name TEXT,
   date_of_birth date,
   escape_attempts integer,
   neutered boolean,
   weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species CHAR(50);