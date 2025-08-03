
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

