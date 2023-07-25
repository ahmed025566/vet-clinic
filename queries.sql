-- listing all animals that its name ends with mon
SELECT * FROM animals WHERE name LIKE '%mon';
-- listing names of animals that where born between 2016 And 2019:
SELECT name FROM animals WHERE (EXTRACT (YEAR FROM CAST (date_of_birth AS DATE))) BETWEEN 2016 AND 2019;
-- listing name of animals that they tried to escape less than 3 times and neuterde:
SELECT name FROM animals WHERE escape_attempts < 3 AND neutered;
-- Listing date_of_birth Of pickachu and Agumon:
SELECT date_of_birth FROM animals WHERE name = 'Augmon' OR name = 'Pickachu';
-- list name and escape_attempts of animals that weight more than 10.5 kg:
SELECT name, escape_attempts WHERE weight_kg > 10.5;
-- listing all animals that are neutered:
SELECT * FROM animals WHERE neutered;
-- List all animals excepet Gabumon;
SELECT * FROM animals WHERE name != 'Gabumon';
-- list all animals that weight between 10.4 kg and 17.3 kg:
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;
-- Update species column:
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;
-- Update species column:
BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM aniamls;
-- Delete all records then rollback:
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;
--savepoint and roll back transcation :
BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;
-- How many animals are there:
SELECT COUNT (*) FROM animals;
-- How many animals have never tried to escape:
SELECT COUNT (*) FROM aniamls WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG (weight_kg) FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY nueterd;
-- What is the minimum and maximum weight of each type of animal?
SELECT species, MAX(weight_kg) AS max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals WHERE (EXTRACT(YEAR FROM CAST(date_of_birth AS DATE))) BETWEEN 1990 AND 2000 GROUP BY species;

-- What animals belong to Melody Pond?
SELECT name, date_of_birth, neutered, weight_kg, escape_attempts, full_name FROM aniamls JOIN owners 
ON aniamls.owner_id = owners.id WHERE full_name = 'Melody Pond';
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name, date_of_birth, neutered, weight_kg, escape_attempts, species.name FROM animals
JOIN species ON animal.species_id = species.id WHERE species.name = 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name AS owner, name AS animal, date_of_birth, neutered, weight_kg, 
escape_attempts FROM owners LEFT JOIN animals ON animals.owner_id = owners.id;
-- How many animals are there per species?
SELECT species.name AS type, COUNT(aniamls.name) FROM aniamls JOIN species ON aniamls.species_id = 
species.id GROUP BY species.name;
-- List all Digimon owned by Jennifer Orwell.
 SELECT animals.name, date_of_birth, neutered, weight_kg, escape_attempts,
full_name AS owner FROM animals JOIN owners ON animals.owner_id= owners.id 
JOIN species ON animals.species_id = species.id WHERE full_name = 'Jennifer Orwell'
 AND species.name = 'Digimon';

 -- List all animals owned by Dean Winchester that haven't tried to escape.
 SELECT name, date_of_birth, neutered, weight_kg, escape_attempts,
  full_name FROM animals JOIN owners ON animals.owner_id = owners.id 
  WHERE full_name = 'Dean Winchester' AND escape_attempts = 0;
--Who owns the most animals?
SELECT full_name, COUNT(name) AS num_of_animals FROM animals JOIN owners
 ON animals.owner_id = owners.id GROUP BY (full_name) ORDER BY COUNT(name) DESC LIMIT 1;


