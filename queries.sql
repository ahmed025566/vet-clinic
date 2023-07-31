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

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, vets.name, visits.date FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'William Tatcher' ORDER BY visits.date DESC LIMIT 1;
-- How many different animals did Stephanie Mendez see?
SELECT vets.name, COUNT (animals.name) AS num_of_animals FROM animals JOIN 
visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id 
WHERE vets.name = 'Stephanie Mendez' GROUP BY vets.name;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name AS vets, species.name AS species FROM vets LEFT JOIN specializations
 ON vets.id = specializations.vet_id LEFT JOIN species ON species.id = specializations.
 species_id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name AS animal, vets.name AS vet, visits.date FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name 
= 'Stephanie Mendez' AND visits.date BETWEEN '2020-08-01' AND '2020-08-30';
--What animal has the most visits to vets?
SELECT animals.name AS animal, COUNT(vets.name) AS num_of_visits FROM animals JOIN visits 
ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id GROUP BY animals.name 
ORDER BY COUNT(vets.name) DESC LIMIT 1; 
-- Who was Maisy Smith's first visit?
SELECT animals.name AS animal, vets.name AS vet, Visits.date FROM animals JOIN visits ON 
animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id WHERE vets.name = 
'Maisy Smith' ORDER BY visits.date ASC LIMIT 1;
-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT animals.name AS animal, animals.date_of_birth, neutered, escape_attempts, weight_kg, 
vets.name AS vet,vets.age,vets.date_of_graduation, Visits.date AS date_of_visit FROM animals 
JOIN visits ON animals.id = visits.animal_id JOIN vets ON vets.id = visits.vet_id ORDER BY 
visits.date DESC LIMIT 1; 

--How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*) AS num_visits
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
JOIN animals a ON v.animal_id = a.id
LEFT JOIN specializations s ON vt.id = s.vet_id AND a.species_id = s.species_id
WHERE s.vet_id IS NULL;
--What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT a.species_id, COUNT(*) AS visit_count, sp.name AS species_name
FROM visits v
INNER JOIN vets ve ON ve.id = v.vet_id
INNER JOIN animals a ON a.id = v.animal_id
INNER JOIN species sp ON sp.id = a.species_id
WHERE ve.name = 'Maisy Smith'
GROUP BY a.species_id, sp.name
ORDER BY visit_count DESC
LIMIT 1;

--- performance audit:

Explain ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
Explain ANALYZE SELECT * FROM visits where vet_id = 2;
Explain ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';
