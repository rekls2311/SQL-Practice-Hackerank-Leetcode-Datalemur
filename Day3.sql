-- Question 1 Hacker Rank Revising the Select Query
SELECT * FROM CITY
WHERE population > 100000 
AND CountryCode = 'USA'

-- Question 2 Hackerank Japanese Cities Attributes

SELECT * FROM CITY
WHERE COUNTRYCODE = 'JPN'

-- Question 3 Hackerank weather observation station 1

SELECT CITY, STATE FROM STATION

--Question 4 hackerank weather observartion station 6

SELECT DISTINCT(CITY)
FROM STATION 
WHERE (CITY LIKE "A%") 
    OR (CITY LIKE "E%")
    OR (CITY LIKE "I%")
    OR (CITY LIKE "O%")
    OR (CITY LIKE "U%");

-- Question 5 hackerank weather observartion station 7

SELECT DISTINCT(CITY)
FROM STATION 
WHERE (CITY LIKE "%A") 
    OR (CITY LIKE "%E")
    OR (CITY LIKE "%I")
    OR (CITY LIKE "%O")
    OR (CITY LIKE "%U");

-- Question 6 hackerank weather observartion station 9

SELECT DISTINCT(CITY)
FROM STATION 
WHERE (CITY NOT LIKE "A%") 
    and (CITY NOT LIKE "E%")
    and (CITY NOT LIKE "I%")
    and (CITY NOT LIKE "O%")
    and (CITY NOT LIKE "U%");

-- Question 7  hackerank employee name

SELECT name FROM Employee
ORDER BY name ASC

-- Question 8 hackerank employee salaries

SELECT name FROM Employee
WHERE salary > 2000 AND months < 10
ORDER BY employee_id ASC

-- Question 9 leetcode recycles and low fat products

SELECT product_id FROM Products
WHERE low_fats ='Y' 
AND recyclable = 'Y'

--Question 10 leetcode customer referee

SELECT name FROM Customer
WHERE referee_id != 2
OR referee_id IS NULL

--Question 11 leetcode big countries

SELECT name, population, area FROM World
WHERE area >= 3000000 
OR population >= 25000000

--Question 12 leetcode article views
SELECT Distinct author_id as id FROM Views
WHERE author_id = viewer_id
ORDER BY id ASC

--Question 13 datalemur Tesla unfinished part

SELECT part, assembly_step FROM parts_assembly
WHERE finish_date ISNULL

--Question 14 datalemur driver wages

select * from lyft_drivers
WHERE yearly_salary <= 30000
OR yearly_salary >= 70000

--Question 15 datalemur 

select * from uber_advertising
WHERE money_spent > 100000
AND year = 2019
