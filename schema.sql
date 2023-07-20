/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id INT GENERATED BY DEFAULT AS IDENTITY
    (START WITH 1 INCREMENT  BY 1),
    name       VARCHAR(24),
    date_of_birth      DATE,
    escape_attempts    INT,
    neutered   BOOLEAN,
    weight     DECIMAL,
    PRIMARY KEY (id)
);

ALTER TABLE animals
ADD COLUMN species VARCHAR(24);

CREATE TABLE owners (
    id SERIAL PRIMARY KEY,
    full_name VARCHAR,
    age INT
);

CREATE TABLE species (
    id SERIAL PRIMARY KEY,
    name VARCHAR
);

ALTER TABLE animals
DROP COLUMN species;

ALTER TABLE animals
ADD COLUMN species_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id);

ALTER TABLE animals
ADD COLUMN owner_id INT;

ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners (id);

CREATE TABLE vets (
    id      SERIAL PRIMARY KEY,
    name    VARCHAR(40),
    age     INT,
    date_of_graduation  DATE
);

CREATE TABLE specializations (
    specialization_id   INT,
    vet_id      INT,
    FOREIGN KEY (specialization_id)
    REFERENCES species(id),
    FOREIGN KEY (vet_id)
    REFERENCES vets(id)
);

CREATE TABLE visits (
    animal_id   INT,
    vet_id      INT,
    visit_date  DATE,
    FOREIGN KEY (animal_id)
    REFERENCES animals(id),
    FOREIGN KEY (vet_id)
    REFERENCES vets (id)
);