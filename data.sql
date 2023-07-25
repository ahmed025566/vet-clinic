-- Insert some animals date:
INSERT INTO aniamls VALUES (1, 'Agumon', '2020-02-03', true, 10.23, 0), (2, 'Gabumon', '2018-11-15', true, 8, 2),
(3, 'pikachuo', '2021-01-07', false, 15.04, 1), (4, 'Devimon', '2017-05-12', true, 11, 5);

-- Inseret some animals data:
INSERT INTO aniamls VALUES (5, 'Charmander', '2020-02-08', false, 11, 0), (6, 'Plantmon', '2021-11-15', true, 5.7, 2),
(7, 'Squirtle', '1993-04-02', false, 12.13, 3), (8, 'Angemon', '2017-05-12', true, 45, 1),
(9, 'Boarmon','2005-06-07', true, 20.4, 7),(10, 'Blossom', '1998-10-13', true, 17, 3),
(11, 'Ditto', '2022-05-14', true, 22, 4);

-- Insert owners date:
INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19),
('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

-- Insert species data:
INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

-- Update species_id column: 
UPDATE animals SET species_id = 2 WHERE name LIKE '%mon';
UPDATE animals SET species_id = 1 WHERE species_id IS NULL;

-- Update owner_id column:
UPDATE animals SET owner_id = 1 WHERE id = 1;
UPDATE animals SET owner_id = 2 WHERE id = 2 OR id = 3;
UPDATE animals SET owner_id = 3 WHERE id = 4 OR id = 6;
UPDATE animals SET owner_id = 4 WHERE id = 5 OR id = 7 OR id = 10;
UPDATE animals SET owner_id = 5 WHERE id = 8 OR id = 9;