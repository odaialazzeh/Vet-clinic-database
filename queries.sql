SELECT * FROM animals WHERE name LIKE '%mon%';
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT * FROM animals WHERE neutered is true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon','Pikachu');
SELECT (name,escape_attempts) FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered is true;
SELECT * FROM animals WHERE name NOT IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;
/*  Transaction  start */
/* Set species = unspecified and then Rollback */ 
BEGIN; 
UPDATE animals SET species = 'unspecified';
SELECT * from animals;
ROLLBACK;
SELECT * from animals;

/* update the table to setting the species column and changes persists after commit */

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species is NULL;
COMMIT;
SELECT * from animals;

/* Delete the data from table and then ROLLBACK */
BEGIN;
DELETE FROM animals;
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Delete the specific data and save your point and update the table and ROLLBACK your deleted data from save point */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT date2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO date2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
SELECT * FROM animals;

/*  Transaction  end */

/* Queries */

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT name,AVG(weight_kg) FROM animals GROUP BY name;
SELECT neutered, COUNT(*) FROM animals GROUP BY neutered ORDER BY COUNT(*) DESC LIMIT 1;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name, full_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT A.name, S.name
FROM animals A
JOIN species S ON A.species_id = S.id
WHERE S.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT O.full_name, A.name
FROM owners O
LEFT JOIN animals A ON O.id = A.owner_id;

-- How many animals are there per species?
SELECT S.name, COUNT(A.name)
FROM species S
JOIN animals A ON S.id = A.species_id 
GROUP BY S.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT A.name,O.full_name
FROM animals A
JOIN species S ON A.species_id = S.id
JOIN owners O ON A.owner_id = O.id
WHERE S.name = 'Digimon' AND O.full_name = 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT A.name,O.full_name
FROM animals A
JOIN owners O ON A.owner_id = O.id
WHERE O.full_name = 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT O.full_name, COUNT(A.id)
FROM owners O
JOIN animals A ON O.id = A.owner_id
GROUP BY O.full_name
ORDER BY COUNT(A.id) DESC
LIMIT 1;

-- Who was the last animal seen by William Tatcher?
SELECT A.name 
FROM visits V 
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
WHERE D.name = 'William Tatcher' 
ORDER BY V.visit_date DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(DISTINCT A.name) 
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
WHERE D.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name
FROM vets
LEFT JOIN specializations ON vets.id = specializations.vet_id
LEFT JOIN species ON specializations.species_id = species.id;

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT A.name 
FROM visits V 
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
WHERE D.name = 'Stephanie Mendez' AND V.visit_date 
BETWEEN '2020-04-01' AND '2020-08-30';

-- What animal has the most visits to vets?
SELECT A.name ,COUNT(A.id)
FROM visits V 
JOIN animals A ON V.animal_id = A.id
GROUP BY A.name
ORDER BY COUNT(A.id) DESC
LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT A.name 
FROM visits V 
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
WHERE D.name = 'Maisy Smith' 
ORDER BY V.visit_date ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT A.name as animal_name, D.name as vet_name, V.visit_date
FROM visits V 
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
ORDER BY V.visit_date DESC
LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(V.id)
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets D ON V.vet_id = D.id
LEFT JOIN specializations S ON S.vet_id = D.id
WHERE S.species_id != A.species_id OR S.species_id IS NULL;

-- -- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT S.name, COUNT(S.name)
FROM visits V
JOIN animals A ON V.animal_id = A.id
JOIN vets VE ON V.vet_id = VE.id
JOIN species S ON A.species_id = S.id
WHERE VE.name = 'Maisy Smith'
GROUP BY S.name
ORDER BY COUNT(S.name) DESC
LIMIT 1;