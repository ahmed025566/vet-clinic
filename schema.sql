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
