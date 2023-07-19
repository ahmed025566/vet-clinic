-- I used the following commands to inseret date into my data base :
INSERT INTO animals VALUES (1, 'Augmon',  '2020-02-03', 0, true, 10.23);
INSERT INTO animals VALUES (2, 'Gabumon', '2018-11-15', 2, true, 8);
INSERT INTO animals VALUES (3, 'Pikachu', '2021-01-07', 1, false, 15.04);
INSERT INTO animals VALUES (4, 'Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Ditto', '2022-05-14', 4, true, 22);    

-- I used the following commands to inseret some new date into my data base :
INSERT INTO animals VALUES (5, 'Charmander', '2020-02-08', 0, false, 11);
INSERT INTO animals VALUES (6, 'Plantmon', '2021-11-15', 2, true, 5.7);
INSERT INTO animals VALUES (7, 'Squirtle', '1993-04-02', 3,false, 12.13);
INSERT INTO animals VALUES (8, 'Angemon', '2005-06-12', 1, true, 45);
INSERT INTO animals VALUES (9, 'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO animals VALUES (10, 'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO animals VALUES (11, 'Ditto', '2022-05-14', 4, true, 22);

-- Inser data into owners table:
INSERT INTO owners 
    (full_name, age)
VALUES 
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

-- Insert data into species table : 

INSERT INTO species
    (name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Updating species_id column in animals table : 
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';
UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

-- Updating owner_id column in animals table : 
UPDATE animals
SET owner_id = 
    CASE 
        WHEN name IN ('Agumon') THEN 1
        WHEN name IN ('Gabumon', 'Pikachu') THEN 2
        WHEN name IN ('Devimon', 'Plantmon') THEN 3
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN 4
        WHEN name IN ('Angemon', 'Boarmon') THEN 5
    END;
    