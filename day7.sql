--- EX 1: hackerrank-more-than-75-marks.
--- ORDER BY CAN SORT BY POSITION
SELECT NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY RIGHT(NAME,3), ID ASC

-- EX2: leetcode Fix name in a tables
-- USE CONCAT 
SELECT user_id, CONCAT(Upper(LEFT(name,1)) , '' , Lower(substring(name from 2 for 10))) AS name
FROM USERS
ORDER BY user_id ASC

--EX 3: DATALEMUR TOTAL DRUG SALES
--KEY TO FOCUS IN : ROUND, CONCAT, /1000000 (TO CONVERT IT INTO MILLIONS)
SELECT  manufacturer,  CONCAT('$',ROUND(SUM(total_sales)/1000000),' million') as sale_mil
FROM pharmacy_sales
group by manufacturer
ORDER BY SUM(total_sales) DESC, manufacturer;

--- EX 4: DATALEMUR AVG REVIEW RATING
-- OUTPUT: AVG STAR RATING FOR EACH PRODUCT: AVG(STARS), GROUP BY MONTH
--- CONDITION: DISPLAY MONTH AS A NUMERICAL VALUE, PRODUCT ID AND AVG STAR, ROUND UP TO 
--- 2 DECIMAL, SORT OUTPUT BY MONTH AND PRODUCT ID
--- *** Key to focus in GROUP BY 2 VALUES
SELECT 
  EXTRACT(MONTH FROM submit_date) AS mth, 
  product_id AS product, 
  ROUND(AVG(stars),2) AS avg_stars
FROM reviews 
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY EXTRACT(MONTH FROM submit_date) ASC, product ASC

--- EX 5: datalemur: teams-power-users.
-- output: sender_id, message_count
-- condition: top 2 power users ( limit 2), August 2022, the message count DESC
--- KEY TO FOCUS in between and
SELECT sender_id, COUNT(message_id) AS message_count
FROM messages 
WHERE sent_date BETWEEN '2022-08-01' AND '2022-09-01'
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
limit 2

SELECT sender_id, COUNT(message_id) AS message_count
FROM messages 
WHERE EXTRACT(MONTH FROM sent_date) = 8 and extract(year from sent_date) = 2022
GROUP BY sender_id
ORDER BY COUNT(message_id) DESC
limit 2

  --EX6: leetcode invalid tweet
select tweet_id
from Tweets 
where length(content) > 15

--EX 7 : leetcode user-activity-for-the-past-30-days.
-- count distinct ID for active user
-- 
SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users
FROM Activity
WHERE (activity_date > "2019-06-27" AND activity_date <= "2019-07-27")
GROUP BY activity_date;

-- ex8: number-of-hires-during-specific-time-period.
select COUNT(id) as number
from employees
WHERE extract(month from joining_date) between 1 and 7 and extract(year from joining_date0 = 2022

  --- ex 9 : position from letter a
  select
  position('a' from first_name) as position
  from worker
  where first_name = 'Amitah'

  -- ex 10 macedonian-vintages.
  --- Focus key, + 2 because we have a space so need to + 2
  select substring(title, length(winery) + 2, 4)
  from winemag_p2
  where country = 'Macedonia'
