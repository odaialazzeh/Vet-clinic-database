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

-- Create a table named vets with the following columns:
CREATE TABLE vets ( 
   id INT GENERATED ALWAYS AS IDENTITY,
   name VARCHAR(255), 
   age INT, 
   date_of_graduation date,
   PRIMARY KEY(id) 
 );

 -- Create the specializations table:
 CREATE TABLE specializations (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vet_id INT REFERENCES vets(id) ON UPDATE CASCADE ON DELETE CASCADE,
    species_id INT REFERENCES species(id) ON UPDATE CASCADE ON DELETE CASCADE
);

-- Create the visits table:
CREATE TABLE visits (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    animal_id INT REFERENCES animals(id) ON UPDATE CASCADE ON DELETE CASCADE,
    vet_id INT REFERENCES vets(id) ON UPDATE CASCADE ON DELETE CASCADE,
    visit_date DATE NOT NULL
);

-- optimise
CREATE INDEX vet_id_index ON visits(vet_id ASC);
CREATE INDEX email_index ON owners(email ASC);
CREATE INDEX animal_id_index ON visits(animal_id ASC);

