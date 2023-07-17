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