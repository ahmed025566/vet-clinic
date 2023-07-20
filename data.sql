/* Populate database with sample data. */

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight)
VALUES
('Agumon', '2020-02-03', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, true, 8),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, weight, neutered, escape_attempts)
VALUES
('Charmander', '2020-02-08', -11, false, 0),
('Plantmon', '2021-11-15', -5.7, true, 2),
('Squirtle', '1993-04-02', -12.13, false, 3),
('Angemon', '2005-06-12', -45, true, 1),
('Boarmon', '2005-06-07', 20.4, true, 7),
('Blossom', '1998-10-13', 17, true, 3),
('Ditto', '2022-05-14', 22, true, 4);

INSERT INTO owners 
    (full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

SELECT * FROM owners;

INSERT INTO species
    (name)
VALUES
    ('Pokemon'),
    ('Digimon');

SELECT * FROM species;

UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

SELECT * FROM animals;

UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

SELECT * FROM animals;

UPDATE animals
SET owner_id = 
    CASE 
        WHEN name IN ('Agumon') THEN 1
        WHEN name IN ('Gabumon', 'Pikachu') THEN 2
        WHEN name IN ('Devimon', 'Plantmon') THEN 3
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
        WHEN name IN ('Angemon', 'Boarmon') THEN 5
    END;

SELECT * FROM animals;

INSERT INTO vets
    (name, age, date_of_graduation)
VALUES
    ('William Tatcher', 45, '2000-04-23'),
    ('Maisy Smith', 26, '2019-01-17'),
    ('Stephanie Mendez', 64, '1981-05-04'),
    ('Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations
    (vet_id, specialization_id)
VALUES
    (1, 1),
    (3, 1),
    (3, 2),
    (4, 2);

SELECT * FROM specializations;

INSERT INTO visits (
    animal_id,
    vet_id,
    visit_date
)
VALUES (
    (SELECT id FROM animals WHERE animals.name = 'Agumon'),
    (SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
    '2020-05-24'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Agumon'),
    (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
    '2020-07-22'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Gabumon'),
    (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
    '2021-02-02'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Pikachu'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2020-01-05'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Pikachu'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2020-03-08'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Pikachu'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2020-05-14'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Devimon'),
    (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
    '2021-05-04'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Charmander'),
    (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
    '2021-02-24'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Plantmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2019-12-21'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Plantmon'),
    (SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
    '2020-08-10'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Plantmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2021-04-07'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Squirtle'),
    (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
    '2019-09-29'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Angemon'),
    (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
    '2020-10-03'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Angemon'),
    (SELECT id FROM vets WHERE vets.name = 'Jack Harkness'),
    '2020-11-04'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Boarmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2019-01-24'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Boarmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2019-05-15'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Boarmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2020-02-27'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Boarmon'),
    (SELECT id FROM vets WHERE vets.name = 'Maisy Smith'),
    '2020-08-03'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Blossom'),
    (SELECT id FROM vets WHERE vets.name = 'Stephanie Mendez'),
    '2020-05-24'
),
(
    (SELECT id FROM animals WHERE animals.name = 'Blossom'),
    (SELECT id FROM vets WHERE vets.name = 'William Tatcher'),
    '2021-01-11'
);