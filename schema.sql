CREATE TABLE animals (
   id integer PRIMARY KEY,
   name TEXT,
   date_of_birth date,
   escape_attempts integer,
   neutered boolean,
   weight_kg decimal
);

ALTER TABLE animals ADD COLUMN species CHAR(50);

CREATE TABLE owners ( 
   id INT GENERATED ALWAYS AS IDENTITY,
   full_name VARCHAR(255), 
   age INT, 
   PRIMARY KEY(id) 
 );

CREATE TABLE species ( 
   id INT GENERATED ALWAYS AS IDENTITY, 
   name VARCHAR(255), 
   PRIMARY KEY(id) 
);

ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;
ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id);
