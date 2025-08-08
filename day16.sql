
-- Leetcode Immediate Food Delivery II
WITH CTE AS (
SELECT *, ROW_NUMBER() OVER (PARTITION BY CUSTOMER_ID ORDER BY order_date ASC ) AS RANK
FROM Delivery
),

 CTE1 AS (
SELECT SUM(CASE WHEN ORDER_DATE = customer_pref_delivery_date  THEN 1 ELSE 0 END) AS IMMEDIATE, COUNT(*) AS TOTAL
FROM CTE
WHERE RANK = 1)

SELECT ROUND((IMMEDIATE*1.0/TOTAL) * 100,2) AS immediate_percentage 
FROM CTE1 

--Game Play Analysis IV
-- Write your PostgreSQL query statement below
WITH CTE AS (
select *, lead(event_date) over (partition by player_id) as next_login_date,  ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date) AS login_rank
from activity),

CTE2 as (
SELECT player_id, (CASE WHEN (next_login_date - event_date = 1) then 1 else 0 END) AS CONSECUTIVE_LOGIN
FROM CTE 
where login_rank = 1

)
SELECT ROUND(SUM(CONSECUTIVE_LOGIN)*1.0 / COUNT(PLAYER_ID),2) AS fraction
from cte2

--Restaurant Growth
-- Write your PostgreSQL query statement below
WITH CTE AS (
SELECT  visited_on, SUM(AMOUNT) AS total_amount
from Customer
GROUP BY visited_on
order by visited_on asc),
CTE2 AS (
SELECT VISITED_ON, ROUND(SUM(TOTAL_AMOUNT) OVER (ORDER BY VISITED_ON ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS AMOUNT, ROUND(AVG(TOTAL_AMOUNT) OVER (ORDER BY VISITED_ON ROWS BETWEEN 6 PRECEDING AND CURRENT ROW),2) AS AVERAGE_AMOUNT, ROW_NUMBER() OVER (ORDER BY VISITED_ON) AS DAY
FROM CTE )

SELECT VISITED_ON, AMOUNT, AVERAGE_AMOUNT
FROM CTE2
WHERE DAY >=7

-- Investment in 2016
-- Write your PostgreSQL query statement below
with cte as (
select *,
count(*) over(partition by tiv_2015) as firstsame,
count(*) over(partition by lat,lon) as secondunique
from insurance
order by pid asc)

SELECT ROUND(SUM(TIV_2016)::numeric, 2) AS TIV_2016 
FROM CTE
WHERE FIRSTSAME !=1 AND SECONDUNIQUE = 1

