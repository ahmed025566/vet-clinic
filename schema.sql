-- First thing : I wrote the following command to use sql commands : 
sudo su - postgres
-- then I created my database using the following command : 
createdb vit_clinic
-- THNE I got access to my data base using the following command : 
psql vit_clinic
-- And Finally I created a table using the following command : 
CREATE TABLE animals( id                INT,
                      name              VARCHAR(100),   
                      date_of_birth     DATE,  
                      escape_attempts   INT,   
                      neutered          BOOLEAN,    
                      weight_kg         FLOAT      
                    );
-- Add a new column
ALTER TABLE animals   ADD COLUMN species VARCHAR(100);

-- Create Owners table:
CREATE TABLE owners (
    id INT PRIMARY KEY,
    full_name VARCHAR(150),
    age INT
);

-- Create species table:
CREATE TABLE species (
    id INT PRIMARY KEY,
    name VARCHAR(150)
); 

-- Deleting species column
ALTER TABLE animals
DROP COLUMN species;
-- Adding species_id column
ALTER TABLE animals
ADD COLUMN species_id INT;
-- Make species_id foreign key column
ALTER TABLE animals
ADD CONSTRAINT fk_species
FOREIGN KEY (species_id)
REFERENCES species (id);
-- Adding owner_id column
ALTER TABLE animals
ADD COLUMN owner_id INT;
-- Make owner_id forign key column
ALTER TABLE animals
ADD CONSTRAINT fk_owner
FOREIGN KEY (owner_id)
REFERENCES owners (id);
