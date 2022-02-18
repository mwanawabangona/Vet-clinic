/*Find all animals whose name ends in "mon".*/
SELECT * FROM animals WHERE name LIKE '%mon';
--  id |  name   | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+---------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon  | 2020-02-03    |               0 | t        |     10.23 | digimon
--   2 | Gabumon | 2018-11-15    |               2 | t        |         8 | digimon
--   4 | Devimon | 2017-05-12    |               5 | t        |        11 | digimon
--   9 | Boarmon | 2005-06-07    |               7 | t        |      20.4 | digimon
--   8 | Angemon | 2005-06-12    |               1 | t        |        45 | digimon
-- (5 rows)



/* List the name of all animals born between 2016 and 2019.*/
SELECT name FROM  animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
--   name   
-- ---------
--  Gabumon
--  Devimon
-- (2 rows)



/* List the name of all animals that are neutered and have less than 3 escape attempts.*/

SELECT name FROM animals WHERE neutered = TRUE AND escape_attempts < 3;
--   name   
-- ---------
--  Agumon
--  Gabumon
--  Angemon
-- (3 rows)



/*List date of birth of all animals named either "Agumon" or "Pikachu". */

SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR  name = 'Pikachu';
--  date_of_birth 
-- ---------------
--  2020-02-03
--  2021-01-07
-- (2 rows)



/*List name and escape attempts of animals that weigh more than 10.5kg */

SELECT name, escape_attempts FROM animals WHERE weight_kg < 10.5;
--   name   | escape_attempts 
-- ---------+-----------------
--  Agumon  |               0
--  Gabumon |               2
-- (2 rows)



/*Find all animals that are neutered. */

SELECT *  FROM animals WHERE neutered = TRUE;

-- id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   1 | Agumon     | 2020-02-03    |               0 | t        |     10.23 | digimon
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   9 | Boarmon    | 2005-06-07    |               7 | t        |      20.4 | digimon
--   8 | Angemon    | 2005-06-12    |               1 | t        |        45 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.08 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
-- (8 rows)




/* Find all animals not named Gabumon.*/

SELECT *  FROM animals WHERE name <> 'Gabumon';

/* Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)
*/

SELECT * FROM animals WHERE weight_kg >=10.4 AND weight_kg <=17.3;

--  id |    name    | date_of_birth | escape_attempts | neutered | weight_kg | species 
-- ----+------------+---------------+-----------------+----------+-----------+---------
--   4 | Devimon    | 2017-05-12    |               5 | t        |        11 | digimon
--   3 | Pikachu    | 2021-01-07    |               1 | f        |     15.08 | pokemon
--  10 | Blossom    | 1998-10-13    |               3 | t        |        17 | pokemon
--   5 | Charmander | 2020-02-08    |               0 | f        |        11 | pokemon
--   7 | Squirtle   | 1993-04-02    |               3 | f        |     12.13 | pokemon
-- (5 rows)


-- How many animals are there?
SELECT COUNT(*) AS ANIMALS_NBR FROM animals;
--  animals_nbr 
-- -------------
--            9
-- (1 row)



-- How many animals have never tried to escape?
SELECT COUNT(*) AS NEVER_ESCAPED_ANIMALS FROM animals WHERE escape_attempts = 0;
--  never_escaped_animals 
-- -----------------------
--                      2
-- (1 row)



-- What is the average weight of animals?
SELECT AVG(weight_kg) AS AVG_WEIGHT FROM animals;
--      avg_weight      
-- ---------------------
--  16.6488888888888889
-- (1 row)



-- Who escapes the most, neutered or not neutered animals?
SELECT neutered,SUM(escape_attempts) AS TOTAL_ESCAPE FROM animals GROUP BY neutered;
--  neutered | total_escape 
-- ----------+--------------
--  f        |            4
--  t        |           18
-- (2 rows)



-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg) AS MINIMUM_WEIGHT , MAX(weight_kg) as MAXIMUM_WEIGHT 
FROM animals GROUP BY species;
--  species | minimum_weight | maximum_weight 
-- ---------+----------------+----------------
--  pokemon |             11 |             17
--  digimon |              8 |             45
-- (2 rows)



-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) AS AVG_ESCAPE_NBR 
FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;
--  species |   avg_escape_nbr   
-- ---------+--------------------
--  pokemon | 3.0000000000000000
-- (1 row)



--Write queries (using JOIN) to answer the following questions:
--What animals belong to Melody Pond?
SELECT animals.name FROM animals JOIN owners ON animals.owner_id=owners.id WHERE full_name='Melody Pond';

--List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals JOIN species ON animals.species_id=species.id WHERE species_id=1;

--List all owners and their animals, remember to include those that don't own any animal.
SELECT animals.name,full_name FROM owners LEFT JOIN animals ON animals.owner_id=owners.id;

--How many animals are there per species?
SELECT species.name, COUNT(*) from animals JOIN species ON animals.species_id=species.id GROUP BY species.name;

--List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id=owners.id WHERE owners.full_name='Jennifer Orwell' AND species_id=2;

--List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals JOIN owners ON animals.owner_id=owners.id 
WHERE owners.full_name='Dean Winchester' AND escape_attempts=0;

--Who owns the most animals?
SELECT owners.full_name, COUNT(animals.name) AS total FROM owners LEFT JOIN animals ON animals.owner_id=owners.id 
GROUP BY owners.full_name ORDER BY total DESC LIMIT 1;