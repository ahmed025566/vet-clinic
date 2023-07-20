/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth between '2016-01-01' and '2019-01-01';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight >= 10.4 AND weight <= 17.3;

BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals
ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon';
SELECT * FROM animals;

UPDATE animals
SET species = 'pokemon'
WHERE species IS NULL;
SELECT * FROM animals;

COMMIT;

BEGIN;

DELETE FROM animals;
SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

DELETE FROM animals
WHERE date_of_birth > '2022-01-01';

SAVEPOINT sp1;

UPDATE animals
SET weight = weight * -1;

ROLLBACK TO sp1;

UPDATE animals
SET weight = weight * -1
WHERE weight < 0;

COMMIT;

SELECT COUNT(*) FROM animals;

SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

SELECT AVG(weight) FROM animals;

SELECT AVG(escape_attempts) as Avg_Escape_Attempts,
neutered
FROM animals
GROUP BY neutered;

SELECT species,
MIN(weight) as Min_Weight,
MAX(weight) as Max_Weight
FROM animals
GROUP BY species;

SELECT species,
AVG(escape_attempts) as Avg_Escape_Attempts
FROM animals
WHERE
date_of_birth >= '1990-01-01' AND
date_of_birth <= '2000-12-31'
GROUP BY species;

SELECT full_name, name AS animals
FROM animals JOIN owners
ON animals.owner_id = owners.id
WHERE owners.id = 4;

SELECT species.name AS species,
animals.name 
FROM animals JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

SELECT
  full_name AS owner,
  animals.name AS animal
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id;

SELECT
  species.name AS species,
  COUNT (species_id)
FROM animals JOIN species
ON animals.species_id = species.id
GROUP BY species;

SELECT
species.name AS species,
animals.name AS animal_name,
owners.full_name as owner_name
FROM owners
JOIN animals
ON owner_id = owners.id
JOIN species
ON species_id = species.id
WHERE species.name = 'Digimon'
AND full_name = 'Jennifer Orwell';

SELECT
animals.name AS animal_name,
owners.full_name AS owner_name,
escape_attempts
FROM animals
JOIN owners
ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND escape_attempts = 0;

SELECT full_name AS owner_name,
COUNT(owner_id) AS animals
FROM owners JOIN animals
ON owner_id = owners.id
GROUP BY full_name
ORDER BY COUNT(owner_id) DESC
LIMIT 1;

SELECT vets.name AS vet_name,
  animals.name AS animal_name,
  visit_date AS last_visit
FROM vets
JOIN visits ON vets.id = vet_id
JOIN animals ON animal_id = animals.id
WHERE vets.name = 'William Tatcher'
GROUP BY vets.name, animals.name, visit_date
ORDER BY MAX(visit_date) DESC
LIMIT 1;

SELECT vet_name,
SUM(count) AS number_of_animals
FROM (
  SELECT vets.name AS vet_name,
  COUNT(animal_id) AS count
  FROM vets
  JOIN visits ON vet_id = vets.id
  WHERE vets.name = 'Stephanie Mendez'
  GROUP BY vets.name, animal_id
) AS subquery
GROUP BY vet_name;

SELECT
  vets.name AS vet_name,
  species.name AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = vet_id
LEFT JOIN species ON specialization_id = species.id;

SELECT
  animals.name AS animal,
  vets.name AS vet_name,
  visit_date
FROM animals
JOIN visits ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visit_date > '2020-04-01' and visit_date < '2020-08-30';

SELECT
  animals.name AS animal,
  COUNT(visits.animal_id) AS number_of_visits
FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

SELECT
  vets.name AS vet_name,
  visit_date,
  animals.name AS animal_name
FROM vets
JOIN visits ON vet_id = vets.id
JOIN animals ON animal_id = animals.id
WHERE vets.name = 'Maisy Smith'
GROUP BY vets.name, animals.name, visit_date
ORDER BY visit_date ASC
LIMIT 1;

SELECT
  animals.name AS animal,
  animals.date_of_birth AS animal_DOB,
  animals.neutered AS neutered,
  species.name AS species,
  vets.name AS vet,
  species.name AS specialty,
  visit_date
FROM animals
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON vets.id = visits.vet_id
JOIN species ON animals.species_id = species.id
JOIN specializations ON vets.id = specializations.vet_id
GROUP BY animals.name, animals.date_of_birth, animals.neutered, species.name, vets.name, visit_date
ORDER BY visit_date DESC
LIMIT 1;

SELECT
  COUNT(visits.animal_id) AS visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN specializations ON vets.id = specializations.vet_id
JOIN species ON specialization_id = species.id
WHERE specialization_id != animals.species_id;

SELECT
  species.name AS recomended_specialty
FROM species
JOIN animals ON species.id = animals.species_id
JOIN visits ON animals.id = visits.animal_id
JOIN vets ON visits.vet_id = vets.id
WHERE vets.name = 'Maisy Smith'
GROUP BY species.name
ORDER BY COUNT(species.name) DESC
LIMIT 1;