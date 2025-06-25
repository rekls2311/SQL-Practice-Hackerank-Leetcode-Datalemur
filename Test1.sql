--Question 1:Task: Tạo danh sách tất cả chi phí thay thế (replacement costs )  khác nhau của các film. Question: Chi phí thay thế thấp nhất là bao nhiêu?

SELECT DISTINCT (FILM_ID), REPLACEMENT_COST
FROM FILM
ORDER BY REPLACEMENT_COST ASC
--Answer: 9.99

--Question 2: Task: Viết một truy vấn cung cấp cái nhìn tổng quan về số lượng phim có chi phí thay thế trong các phạm vi chi phí sau
--low: 9.99 - 19.99
--medium: 20.00 - 24.99
--high: 25.00 - 29.99
--Question: Có bao nhiêu phim có chi phí thay thế thuộc nhóm “low”?
SELECT 
	CASE 
		WHEN REPLACEMENT_COST BETWEEN 9.99 AND 19.99 THEN 'Low'
		WHEN REPLACEMENT_COST BETWEEN 20.00 AND 24.99 THEN 'Medium'
		WHEN REPLACEMENT_COST BETWEEN 25.00 AND 29.99 THEN 'High'
	END as CATEGORY,
	COUNT(*) AS "TOTAL_NUMBER"
FROM FILM
GROUP BY CATEGORY
ORDER BY "TOTAL_NUMBER" DESC
-- Answer:514
  
--Question 3
--Task: Tạo danh sách các film_title  bao gồm tiêu đề (title), độ dài (length) và tên danh mục (category_name) được sắp xếp theo độ dài giảm dần. Lọc kết quả để chỉ các phim trong danh mục 'Drama' hoặc 'Sports'.
--Question: Phim dài nhất thuộc thể loại nào và dài bao nhiêu?
SELECT * FROM FILM

SELECT * FROM public.film_category

SELECT * FROM public.category

select f.title, f.length, c.name
FROM
	public.film AS f
INNER JOIN public.film_category AS fc ON f.film_id = fc.film_id
INNER JOIN public.category AS c ON fc.category_id = c.category_id
order by f.length desc
-- answer: Sport 184

--Question 4:Task: Đưa ra cái nhìn tổng quan về số lượng phim (tilte) trong mỗi danh mục (category). Question:Thể loại danh mục nào là phổ biến nhất trong số các bộ phim?
select c.name, COUNT(f.title) AS "TOTAL_NUMBER" 
FROM
	public.film AS f
INNER JOIN public.film_category AS fc ON f.film_id = fc.film_id
INNER JOIN public.category AS c ON fc.category_id = c.category_id
GROUP BY c.name
ORDER BY COUNT(f.title) desc

--Answer: Sports :74 titles
--Question 5 :Task: Đưa ra cái nhìn tổng quan về họ và tên của các diễn viên cũng như số lượng phim họ tham gia. Question: Diễn viên nào đóng nhiều phim nhất?
select CONCAT(a.first_name ,' ', a.last_name) as NAME, COUNT(*) AS "Total_numer"
FROM
	public.film AS f
INNER JOIN public.film_actor AS fa ON f.film_id = fa.film_id
INNER JOIN public.actor AS a ON fa.actor_id = a.actor_id
GROUP BY a.first_name, a.last_name
ORDER BY COUNT(*) DESC

--Question 6: Task: Tìm các địa chỉ không liên quan đến bất kỳ khách hàng nào.
SELECT COUNT(c.address_id) 
FROM public.address as c
LEFT JOIN public.customer  as a
ON c.address_id = a.address_id
WHERE a.address_id IS NULL
--Answer:4

--question 7: Task: Danh sách các thành phố và doanh thu tương ừng trên từng thành phố. Question: Thành phố nào đạt doanh thu cao nhất ?
SELECT city.city, SUM(payment.amount) AS "total_amount"
FROM public.payment AS payment
JOIN public.customer AS customer ON   payment.customer_id = customer.customer_id 
JOIN public.address AS address ON customer.address_id = address.address_id
JOIN public.city AS city ON address.city_id = city.city_id
GROUP BY city.city
ORDER BY SUM(payment.amount) desc
--Answer: Cape Coral : 221.55

--question 8: Task: Tạo danh sách trả ra 2 cột dữ liệu: Question: Thành phố của đất nước nào đat doanh thu thấp nhất ?
SELECT CONCAT(country.country, ' , ', city.city) AS "Thanh Pho va Dat Nuoc", SUM(payment.amount) AS "total_amount"
FROM public.payment AS payment
JOIN public.customer AS customer ON   payment.customer_id = customer.customer_id 
JOIN public.address AS address ON customer.address_id = address.address_id
JOIN public.city AS city ON address.city_id = city.city_id
JOIN public.country AS country ON city.country_id = country.country_id
GROUP BY CONCAT(country.country, ' , ', city.city)
ORDER BY SUM(payment.amount) asc
--Answer: United States, Tallahassee : 50.85.


