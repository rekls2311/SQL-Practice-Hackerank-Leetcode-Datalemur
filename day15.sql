--Datalemur Y-on-Y Growth Rate
SELECT  
      EXTRACT(YEAR FROM transaction_date) AS transaction_year, product_id, spend AS curr_year_spend, 
      LAG(spend) OVER(PARTITION BY PRODUCT_ID ORDER BY transaction_date ASC) as prev_year_spend,
      Round(((spend - LAG(spend) OVER(PARTITION BY PRODUCT_ID ORDER BY transaction_date ASC)) / (LAG(spend) OVER(PARTITION BY PRODUCT_ID ORDER BY transaction_date ASC)) * 100),2)
FROM user_transactions

--Datalemur Card launch success
WITH CTE AS (
  SELECT 
    CARD_NAME, FIRST_VALUE(issued_amount) OVER(PARTITION BY card_name ORDER BY ISSUE_YEAR ASC) AS issued_amount,ISSUE_MONTH, ISSUE_YEAR, 
    ROW_NUMBER() OVER(PARTITION BY card_name ORDER BY ISSUE_YEAR ASC, ISSUE_MONTH ASC) AS rn
FROM monthly_cards_issued)

SELECT 
    CARD_NAME, issued_amount
FROM 
    CTE
WHERE 
    rn = 1
ORDER BY 
    issued_amount DESC

--Datalemur Third Transaction
WITH CTE AS (
  SELECT USER_ID, SPEND, TRANSACTION_DATE, 
  ROW_NUMBER() OVER(PARTITION BY USER_ID ORDER BY TRANSACTION_DATE ASC) AS rn
  FROM TRANSACTIONS)

SELECT 
  USER_ID, SPEND, TRANSACTION_DATE
FROM 
  CTE
WHERE 
  RN = 3

--Datalemur Histogram of Users and Purchases
WITH CTE AS(
  SELECT  
      transaction_date, user_id, 
      count(*) OVER(PARTITION BY user_id ORDER BY transaction_date desc ) as purchase_count, ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY TRANSACTION_DATE DESC) AS rn 
FROM user_transactions)

SELECT 
    transaction_date, user_id, purchase_count
FROM 
    cte
WHERE 
    rn = 1 
order by 
    transaction_date asc

--Datalemur Tweets Rolling Average
SELECT user_id, tweet_date, 
ROUND(AVG(tweet_count) OVER(PARTITION BY USER_ID ORDER BY tweet_date ASC
ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) as rolling_avg_3d
FROM tweets;

--Datalemur Repeated Transactions:
WITH CTE AS (
SELECT *, LAG(transaction_timestamp) OVER(PARTITION BY MERCHANT_ID,CREDIT_CARD_ID,AMOUNT ORDER BY TRANSACTION_TIMESTAMP ASC) AS PREVIOUS_TRANSACTION_TIME 
FROM transactions)

SELECT COUNT(TRANSACTION_ID) AS PAYMENT_COUNT
FROM CTE
WHERE EXTRACT(EPOCH FROM TRANSACTION_TIMESTAMP - PREVIOUS_TRANSACTION_TIME) /60 <=10

--Datalemur Highest Grossing Item.
WITH CTE AS (
    SELECT
        CATEGORY,
        PRODUCT,
        SUM(SPEND) AS total_spend,
        ROW_NUMBER() OVER(PARTITION BY CATEGORY ORDER BY SUM(SPEND) DESC) AS rn
    FROM
        product_spend
    WHERE EXTRACT(YEAR FROM TRANSACTION_DATE) = 2022
    GROUP BY
        CATEGORY,
        PRODUCT
    
)
SELECT
    CATEGORY,
    PRODUCT,
    total_spend
    
FROM
    CTE
WHERE RN <= 2

--Datalemur Spotify rank
WITH CTE AS(
    SELECT
        A.ARTIST_NAME,
        COUNT(*) AS NUMBER_OF_TIMES
    FROM
        artists AS A
    JOIN
        songs AS B ON A.ARTIST_ID = B.ARTIST_ID
    JOIN
        global_song_rank AS C ON B.SONG_ID = C.SONG_ID
    WHERE
        C.RANK <= 10
    GROUP BY
        A.ARTIST_NAME
),
   CTE2 AS (
  SELECT *, DENSE_RANK() OVER(ORDER BY NUMBER_OF_TIMES DESC) AS ARTIST_RANK
  FROM CTE
)

SELECT ARTIST_NAME, artist_rank
FROM CTE2
where artist_rank <=5
