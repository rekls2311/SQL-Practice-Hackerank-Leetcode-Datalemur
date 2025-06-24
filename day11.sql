-- Hackerank Average Population of Each Continent
SELECT b.continent, floor(AVG(a.population))
FROM CITY AS a
INNER JOIN COUNTRY AS b
ON a.countrycode = b.code
GROUP BY b.continent


-- Datalemur Signup Activation Rate
--input: 
--output: activation rate
--condition clause: round the percentage to 2 decimals places
SELECT round(
    (SUM(CASE WHEN b.signup_action ='Confirmed' THEN 1 ELSE 0 END) * 1.0) / COUNT(b.*) * 100
,2) AS confirm_percentage
FROM emails AS a
LEFT JOIN texts AS b
ON a.email_id = b.email_id;

--Datalemur time spent snaps
--input:
--ouput: age_bucket.send_percentage,open_percentage ** multiply by 100.0 /// SEND PERCENTAGE = time_spent sending / (time_spent sending + time_spent opening) --> logic: (time_spent sending + time_spent opening) =  a.activity_type != 'chat' 
--condition clause: Round the percentage to 2 decimal places             /// OPEN PERCENTAGE = time_spent opening / (time_spent sending + time_spent opening) --> logic: (time_spent sending + time_spent opening) =  a.activity_type != 'chat' 

SELECT b.age_bucket,
ROUND(100.0*(SUM(CASE WHEN a.activity_type = 'send' then time_spent END)   / 
SUM(CASE WHEN a.activity_type != 'chat' then time_spent END)),2) AS send_perc,
ROUND(100.0*(SUM(CASE WHEN a.activity_type = 'open' then time_spent END)/
SUM(CASE WHEN a.activity_type != 'chat' THEN time_spent END)),2) AS open_perc
FROM activities AS a
LEFT JOIN age_breakdown as b
ON a.user_id = b.user_id
GROUP BY age_bucket

--datalemur supercloud customer

--input:
--output: customer_id
--condition clause: has buy every service from product catergory

SELECT c.customer_id
FROM customer_contracts as c
INNER JOIN products as p
ON c.product_id = p.product_id
where product_category IN ('Analytics','Containers','Compute')
GROUP BY c.customer_id
HAVING COUNT (DISTINCT product_category) = 3 

--leetcode The Number of Employees Which Report to Each Employee
--input:
--ouput: employee_id, name ,reports_count, Average_age
--condition clause: no null, employee who has at least 1 other employee reporting to them.
-- big tip : to use self join use paper to draw so can visualize make it easier to understand

SELECT
    manager.employee_id AS employee_id,
    manager.name AS name  ,
    COUNT(employee.employee_id) AS reports_count,
    ROUND(AVG(employee.age)) AS average_age
FROM
    Employees AS employee
JOIN
    Employees AS manager
ON
    employee.reports_to = manager.employee_id
GROUP BY
    manager.employee_id,
    manager.name
HAVING 
    COUNT(employee.employee_id) >=1
ORDER BY
    manager.employee_id;

--Leetcode-- list-the-products-ordered-in-a-period
--input
--output: names of products (product_name), unit
--condition clause: in February 2020, have at least 100 units

SELECT
    a.product_name, SUM(b.unit) as unit
FROM 
    Products as a
LEFT JOIN
    Orders as b
ON
    a.product_id  = b.product_id
WHERE
    b.order_date >= '2020-02-01' AND b.order_date < '2020-03-01'
GROUP BY 
    a.product_name
HAVING
    SUM(b.unit) >= 100


--datalemure pages with no likes
--input
--output: page_id
--condition clause: pages that have zero likes. sort in asc order based on pages id

SELECT a.page_id
FROM
    pages AS a
LEFT JOIN
    page_likes AS b 
ON
    a.page_id = b.page_id
WHERE 
    b.page_id IS NULL
ORDER BY 
    a.page_id ASC

