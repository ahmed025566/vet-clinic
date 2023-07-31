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

-- Insert data into vets:
INSERT INTO vets (name, age, date_of_graduation) VALUES 
('William Tatcher ', 45, '2000-04-23'), ('Maisy Smith', 26, '2019-01-17')
,('Stephanie Mendez', 64, '1981-05-04'),('Jack Harkness', 38, '2008-06-08');

-- Insert data into specializations:
INSERT INTO specializations (vet_id, species_id) VALUES (1, 1), (3, 1), (3, 2), (4, 2);

-- Insert into data into visits:
INSERT INTO visits (aniaml_id, vet_id, date) VALUES (1, 1, '2020-05-24'),
(1, 3, '2020-07-22'), (2, 4, '2021-02-02'), (3, 2, '2020-01-05'),
(3, 2, '2020-03-08'), (3, 2, '2021-05-14'), (4, 3, '2021-05-04'), (5, 4, '2021-02-24'),
 (6, 2, '2019-12-21'), (6, 1, '2020-08-10'), (6, 2, '2021-04-07'), (7, 3, '2019-09-29')
 , (8, 4, '2020-10-03'), (8, 4, '2020-11-04'), (9 ,2, '2019-01-24'), (9, 2, '2019-05-15')
 , (9, 2, '2020-02-27'), (9, 2, '2020-08-03'), (10, 3, '2020-05-24'), (10, 1, '2021-01-11');

-- Insert data to do the performance audit:
INSERT INTO visits (animal_id, vet_id, date_of_visit) SELECT * FROM (SELECT id FROM animals) animal_ids, (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

insert into owners (full_name, email) select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';