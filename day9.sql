--- ex1: datalemur-laptop-mobile-viewership.
---input: laptop, tablet and iphone
---output: laptop_reviews, mobile_views
---condition: mobile => sum = tablet + iphone
SELECT 
    SUM(CASE
            WHEN device_type = 'laptop' THEN 1
            ELSE 0
            END) AS laptop_reviews,
     SUM(CASE
            WHEN device_type IN ('tablet','phone') THEN 1
            ELSE 0
            END) AS mobile_views
      FROM viewership

---ex2: datalemur-triangle-judgement.
-- Write your PostgreSQL query statement below
-- Write your PostgreSQL query statement below
---INPUT:
---OUTPUT: YES, NO
---CONDITION:  Triangle = X+Y < Z

SELECT X,Y,Z,
    CASE 
        when x+y>z and x+z>y and y+z>x then 'Yes'
        ELSE 'No'
        END AS TRIANGLE
FROM Triangle 

---ex3: datalemur-uncategorized-calls-percentage.
--input:
--output: PERCENTAGE uncategorised_call_pct = SUM(NULL OR N/A) / TONG COUNT CALL * 100 
-- condition: round your answer to 1 decimal place

SELECT
  ROUND(100.0 * 
    SUM(CASE WHEN call_category IS NULL OR call_category = 'n/a'
      THEN 1
      ELSE 0
      END)
    /COUNT(*), 1) AS uncategorised_call_pct
FROM callers

---ex4: LEETCODE-find-customer-referee.
-- Write your PostgreSQL query statement below
---INPUT:
---OUTPUT: NAME
---CONDITION:  names of the customer that are not referred by the customer with id = 2.

SELECT NAME
FROM Customer
WHERE referee_id <> 2 OR referee_id IS NULL;

---ex5: stratascratch the-number-of-survivors.
SELECT
    sex,
    SUM(CASE WHEN pclass = 1 THEN survived ELSE 0 END) AS first_class,
    SUM(CASE WHEN pclass = 2 THEN survived ELSE 0 END) AS second_class,
    SUM(CASE WHEN pclass = 3 THEN survived ELSE 0 END) AS third_class
FROM
    titanic
GROUP BY
    sex;


