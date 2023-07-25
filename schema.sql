-- Creating animals table:
CREATE TABLE aniamls (
    id INT PRIMARY KEY,
    name VARCHAR,
    date_of_birth DATE,
    neutered BOOLEAN,
    weight_kg Float
);

-- Add species column to animals table:
ALTER TABLE animals ADD COLUMN species VARCHAR;

-- Create owners Table:
CREATE TABLE owners(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR;
    age INT
);

-- Creating species table:
CREATE TABLE species(
    id INT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR
);

-- set id column in animals table to be auto incremented column:
ALTER TABLE animals ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY;

-- Removing species column from animals:
ALTER TABLE animals DROP COLUMN species;
-- Adding species_id column to be a foreign key referencing id column in species table:
ALTER TABLE animals ADD COLUMN species_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_species FOREIGN KEY (species_id) REFERENCES species(id);

-- Adding owner_id column to be a foreign key referencing id column owner table:
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_animals_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

-- Create vets table:
CREATE TABLE vets(
id INT GENERATED ALWAYS AS IDENTITY,
name VARCHAR,
age INT,
date_of_graduation DATE
);

-- Create specializations table:
CREATE TABLE specializations(
    vet_id INT,
    species_id,
    CONSTRAINT fk_vets
      FOREIGN KEY (vet_id)
        REFERENCES vets(id),
    CONSTRAINT fk_species
        FOREIGN KEY (species_id)
            REFERENCES species(id),
    PRIMARY KEY (vet_id, species_id)
);

-- Create visits table:
CREATE TABLE visits(
    animal_id INT,
    vet_id INT,
    date DATE,
    CONSTRAINT fk_animals
        FOREIGN KEY (animal_id)
            REFERENCES animals(id),
    CONSTRAINT fk_vets
        FOREIGN KEY (vet_id)
            REFERENCES vets(id),
    PRIMARY KEY (aniaml_id, vet_id)
);
