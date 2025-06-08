--- 1) Hacker rank weather observation 3
SELECT DISTINCT CITY
FROM STATION
WHERE (ID%2) = 0 

--- 2)  Hacker rank weather observation 4

SELECT COUNT(CITY) - COUNT(DISTINCT CITY) AS UNIQUE_CITY
FROM STATION

---3) Hacker rank the blunderer
SELECT CEIL(AVG(Salary)-AVG(REPLACE(SALARY,0,'')))
FROM EMPLOYEES;
--- 4) Datalemur alibaba compressed mean

SELECT ROUND(
    CAST(SUM(ITEM_COUNT * order_occurrences) / SUM(order_occurrences) AS NUMERIC(3,1)),
    1
) AS MEAN
FROM items_per_order;

--5) datalemur matching skills
SELECT candidate_id
FROM candidates
WHERE skill in ('python','Tableau','PostgreSQL')
GROUP BY candidate_id
HA VING COUNT(skill) = 3
ORDER BY candidate_id ASC

--6)  DATALEMUR Average Post Hiatus (Part 1)


---INPUT: FIRST POST OF THE YEAR - LAST POST OF THE YEAR IN 2021
--OUPUT: USER_ID, DAYS_BETWEEN = max(day) - min(day)
--CONDITION

SELECT user_id,
DATE(MAX(post_date))- DATE(MIN(post_date)) AS days_between
FROM posts
WHERE post_date >= '2020-01-01' AND post_date < '2022-01-01'
GROUP BY user_id
HAVING COUNT(POST_ID) >=2

--7) DATALEMUR Cards Issued Difference

---OUTPUT: CARD_NAME, DIFFERENCE ISSUED CARD = MAX - MIN IN EACH MONTH
---INPUT
---CONDITION: BASED ON LARGEST DISPARITY = DESC
SELECT card_name, 
MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC

--8) DATALEMNUR Pharmacy Analytics (Part 2)

SELECT manufacturer,
COUNT(DISTINCT drug) AS drug_count,
ABS(CAST(SUM(cogs - total_sales) AS NUMERIC)) AS total_loss
FROM pharmacy_sales
WHERE total_sales < cogs
GROUP BY manufacturer
ORDER BY total_loss DESC

--9) leetcode not boring filter
--OUTPUT: ODD NUMBER ID AND A DESCRIPTION IS NOT BORING
--INPUT
---CONDITION CLAUSE: DESCRIPTION <> BORING, RATING IN DESC

SELECT *
FROM CINEMA
WHERE id % 2 <> 0 AND DESCRIPTION <> 'boring'
order by rating desc

--10) leetcode number of unique subject
-- Write your MySQL query statement below
-- output: teacher_id, cnt = 
--input:
--condition clause: 

SELECT teacher_id,
count(distinct subject_id) as cnt
FROM Teacher
GROUP BY teacher_id

--11) ex11: leetcode-find-followers-count.


SELECT user_id,
count(distinct follower_id ) as followers_count
FROM Followers 
GROUP BY user_id

--12) leetcode having at least 5 students
select class
from Courses 
group by class
having count(student) >= 5

