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
