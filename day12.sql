-- datalemur job listings
--input:
--output: duplicate_companies (Interger)
--condition clause: same title, same description, same company id

with job_dulicate_table AS (
SELECT COUNT(JOB_ID) AS JOB_DUPLICATE,title,description, company_id
FROM job_listings 
GROUP BY title,description,company_id
HAVING COUNT(JOB_ID) > 1)

SELECT COUNT(distinct company_id) as duplicate_companies
FROM job_dulicate_table

--DATALEMUR HIGHEST GROSSING 
--input:
--output: category, product, total spend = sum(spend) (group by category, product), Rank 
--condition clause : 2022, 
WITH ranking_total_spend_2022 AS (
    SELECT
        category,
        product,
        SUM(spend) AS total_spend,
        RANK() OVER (
      PARTITION BY category 
      ORDER BY SUM(spend) DESC) AS ranking 
    FROM
        product_spend
    WHERE
        EXTRACT(YEAR FROM transaction_date) = 2022
    GROUP BY
        category,
        product
)

SELECT category, product, total_spend
from ranking_total_spend_2022
WHERE ranking <= 2


--DATALEMUR FREQUENT CALLER
--input:
--ouput:policy holder count (int) = count(case_id)
--condition clause: 3 or more calls
WITH call_holder_count AS(
SELECT policy_holder_id, count(case_id) as call_count
FROM callers 
group by policy_holder_id)

select count(call_count) as policy_holder_count
from call_holder_count
WHERE call_count >= 3

--DATALEMUR-- PAGES WITH NO LIKES
--input:
--output: page_id
--condition clause: that have zero likes.


--input:
--output: page_id
--condition clause: that have zero likes.
SELECT A.page_id  
FROM pages AS A
LEFT JOIN page_likes AS B
ON A.page_id = B.page_id
where B.page_id IS NULL

--Datalemur Active User Retention
--INPUT
--OUTPUT
--CONDITON CLAUSE: 
WITH June2022ActiveUsers AS (
    SELECT DISTINCT user_id
    FROM user_actions
    WHERE event_date >= '2022-06-01' AND event_date < '2022-07-01' -- Users active in June 2022
),
July2022ActiveUsers AS (
    SELECT DISTINCT user_id
    FROM user_actions
    WHERE event_date >= '2022-07-01' AND event_date < '2022-08-01' -- Users active in July 2022
)
SELECT
    7 AS month, -- The target month is July, which is the 7th month
    COUNT(J.user_id) AS monthly_active_users
FROM
    June2022ActiveUsers AS J -- Users active in June
INNER JOIN
    July2022ActiveUsers AS L ON J.user_id = L.user_id; -- Join to find users active in both months

--Leetcode Monthly transactions:
SELECT to_char(trans_date,'YYYY-MM') AS month, country, count(id) as trans_count, 
SUM(CASE WHEN state = 'approved' THEN 1 ELSE 0 END) as approved_count, SUM(amount) as trans_total_amount , SUM(CASE WHEN state = 'approved' THEN amount ELSE 0 END) AS approved_total_amount 
FROM Transactions 
GROUP BY to_char(trans_date,'YYYY-MM'), country

--Leetcode Product sales Analysis 
WITH CTE AS (
    SELECT
        product_id,
        year,
        ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY year ASC) as row_num -- Assign a rank to each year for a product, ordered by year
    FROM
        Sales
)
SELECT
    A.product_id,
    A.year as first_year  ,
    B.quantity,
    B.price
FROM
    CTE as A
LEFT JOIN
    Sales  AS B ON A.product_id = B.product_id AND A.year = B.year
WHERE
    row_num = 1 -- Now, filter for the first year (rank 1) for each product
ORDER BY
    product_id;

--Leetcode Who bought all products
SELECT customer_id 
FROM Customer
GROUP BY customer_id 
HAVING COUNT(DISTINCT product_key) = 
(select count (DISTINCT product_key)
FROM Product)                                 

--Leetcode Employees Whose Manager Left the Company
with cte as (
SELECT employee_id, manager_id 
from Employees 
WHERE salary < 30000)

SELECT employee_id 
FROM cte
where manager_id NOT IN (SELECT employee_id FROM Employees  )

--Leetcode Primary Department for each employees
with cte as (
SELECT employee_id, department_id, primary_flag ,(ROW_NUMBER() OVER (PARTITION BY employee_id ORDER BY primary_flag desc)) AS row_number
FROM Employee)

SELECT employee_id , department_id 
from CTE 
where row_number = 1

--Leetcode Movie Rating. 

--Find the name of the user who has rated the greatest number of movies. In case of a tie, return the lexicographically smaller user name.

SELECT B.name
FROM MovieRating AS A
JOIN Users AS B ON A.user_id = B.user_id
GROUP BY B.name
ORDER BY COUNT(A.user_id) DESC, B.name ASC
Limit 1

--Leetcode who has the most friends
-- Write your PostgreSQL query statement below
with cte as (
SELECT requester_id as id, accepter_id 
FROM RequestAccepted
Union
SELECT accepter_id AS id, requester_id
FROM RequestAccepted
)
select id, count(distinct accepter_id) as num
from cte
group by id
order by num desc
limit 1

