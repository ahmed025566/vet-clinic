-- The following command is to find all elemnts that its name ends with mon
SELECT * FROM animals WHERE name LIKE '%mon';

-- The following command is for listing all the names of animals where date of birth between 2016 and 2019
SELECT name FROM animals WHERE (EXTRACT(YEAR FROM CAST(date_of_birth AS DATE))) BETWEEN 2016 AND 2019;

-- The following command is to list all the names where neuetred and escape_attempts < 3
SELECT name FROM animals WHERE neutered AND escape_attempts < 3;

-- The following command is for listing date of birth for Augmon and Pikachu
SELECT date_of_birth  FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

-- The following command is for listing name and date of birth where weight > 10.5 kg
SELECT name, date_of_birth FROM animals WHERE weight_kg > 10.5;

-- The following commands is for listing all animals that are neutered
SELECT * FROM animals WHERE neuetred;

-- The following command is for listing all animals that its name is not equal to Gabumon
SELECT * FROM animals WHERE name != 'Gabumon';

-- The following command is for listing animals where weight is >= 10.4 kg and less than or equal to 17.3kg
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- The following commands of for updating species field and then rollback: 
BEGIN;
UPDATE animals  SET species = 'unspecified';
ROLLBACK;

-- The following command is for updateing species column based on some conditions:
BEGIN;
UPDATE animals   SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals   SET species = 'pokemon' WHERE species = '';
COMMIT;

-- The following command is for deleting everything and then back to the original table: 
BEGIN;
DELETE FROM animals;
ROLLBACK;

-- The following command is for making savepoints and then roll back to it;
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE aniamls SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

-- The following commands is for answring query questions : 

-- How many animals are there ?
SELECT COUNT(name) FROM animals;

-- How many animals never tried to escape:
SELECT COUNT(name) FROM aniamls WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM aniamls;

-- Who escapes the most, neutered or not neutered animals?
SELECT neuetred, MAX(escape_attempts) FROM animals GROUP BY neuetred;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;

--What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT AVG(escape_attempts) FROM aniamls WHERE (EXTRACT(YEAR FROM CAST(date_of_birth AS DATE))) BETWEEN 1990 AND 2000;


-- What animals belong to Melody Pond?
SELECT full_name, name AS animals
FROM animals JOIN owners
ON animals.owner_id = owners.id
WHERE owners.id = 4;
--List of all animals that are pokemon (their type is Pokemon).
SELECT species.name AS species,
animals.name 
FROM animals JOIN species
ON animals.species_id = species.id
WHERE species.name = 'Pokemon';
--List all owners and their animals, remember to include those that don't own any animal.
SELECT
  full_name AS owner,
  animals.name AS animal
FROM owners LEFT JOIN animals
ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT
  species.name AS species,
  COUNT (species_id)
FROM animals JOIN species
ON animals.species_id = species.id
GROUP BY species;

--List all Digimon owned by Jennifer Orwell.
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

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT
animals.name AS animal_name,
owners.full_name AS owner_name,
escape_attempts
FROM animals
JOIN owners
ON owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester'
AND escape_attempts = 0;
-- Who owns the most animals?
SELECT full_name AS owner_name,
COUNT(owner_id) AS animals
FROM owners JOIN animals
ON owner_id = owners.id
GROUP BY full_name
ORDER BY COUNT(owner_id) DESC
LIMIT 1;

--Who was the last animal seen by William Tatcher?
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

--How many different animals did Stephanie Mendez see?
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

--List all vets and their specialties, including vets with no specialties.
SELECT
  vets.name AS vet_name,
  species.name AS specialty
FROM vets
LEFT JOIN specializations ON vets.id = vet_id
LEFT JOIN species ON specialization_id = species.id;

--List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT
  animals.name AS animal,
  vets.name AS vet_name,
  visit_date
FROM animals
JOIN visits ON animal_id = animals.id
JOIN vets ON vet_id = vets.id
WHERE vets.name = 'Stephanie Mendez'
AND visit_date > '2020-04-01' and visit_date < '2020-08-30';

--What animal has the most visits to vets?
SELECT
  animals.name AS animal,
  COUNT(visits.animal_id) AS number_of_visits
FROM animals
JOIN visits ON visits.animal_id = animals.id
GROUP BY animals.name
ORDER BY COUNT(visits.animal_id) DESC
LIMIT 1;

--Who was Maisy Smith's first visit?
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

--Details for most recent visit: animal information, vet information, and date of visit.
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

--How many visits were with a vet that did not specialize in that animal's species?
SELECT
  COUNT(visits.animal_id) AS visits
FROM visits
JOIN animals ON visits.animal_id = animals.id
JOIN vets ON visits.vet_id = vets.id
JOIN specializations ON vets.id = specializations.vet_id
JOIN species ON specialization_id = species.id
WHERE specialization_id != animals.species_id;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
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