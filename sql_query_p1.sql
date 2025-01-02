#data cleaning- finding and deleting null/missing values
select * from retailsales
order by transactions_id;

select * from retailsales
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
 age is null
or
 category is null
or
 quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

delete from retailsales
where
transactions_id is null
or
sale_date is null
or
sale_time is null
or
customer_id is null
or
gender is null
or
 age is null
or
 category is null
or
 quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;




#Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT 
    *
FROM
    retailsales
WHERE
    sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT 
    transactions_id, quantity, category
FROM
    retailsales
WHERE
    category = 'clothing' AND quantity > 10
        AND transactions_id BETWEEN '2022-11-01' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

SELECT 
    SUM(total_sale), category
FROM
    retailsales
GROUP BY category;

-- Q.4  find the average age of customers who purchased items from the 'Beauty' category.here ROUND FUNCTION is used by myself not asked in the question.
SELECT 
    ROUND(AVG(age), 2)
FROM
    retailsales
WHERE
    category = 'beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

SELECT 
    transactions_id
FROM
    retailsales
WHERE
    total_sale > 1000
ORDER BY transactions_id;

#Q.6  find the total number of transactions (transaction_id) made by each gender in each category.

SELECT 
    COUNT(transactions_id) AS total_transactions,
    category,
    gender
FROM
    retailsales
GROUP BY category , gender
ORDER BY category , gender;


#Q.7 calculate the average sale for each month. Find out best selling month in each year 

with retailsales as (
select year(sale_date) as sale_year, month(sale_date) as sale_month,avg(total_sale) as avg_sale
from retailsales
group by year(sale_date), month(sale_date)
),
bestsellingmonth as (
select sale_year,sale_month,avg_sale,
RANK() OVER (PARTITION BY Sale_Year ORDER BY Avg_Sale DESC) AS Ranks
from retailsales)
select sale_year, sale_month, avg_sale
from bestsellingmonth
where ranks = 1;

 
#Q.8 find the top 5 customers based on the highest total sales- here find those customers who have purcesd maximum times/rupees

SELECT 
    customer_id, SUM(total_sale) AS max_sale
FROM
    retailsales
GROUP BY customer_id
ORDER BY max_sale DESC
LIMIT 5;


#Q.9 find the number of unique customers who purchased items from each category.

SELECT 
    category, COUNT(DISTINCT (customer_id)) AS a
FROM
    retailsales
GROUP BY category; 

#Q.10  create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    sale_time,
    customer_id,
    CASE
        WHEN sale_time <= '12' THEN 'morning'
        WHEN sale_time BETWEEN '12' AND '17' THEN 'afternoon'
        WHEN sale_time > '17' THEN 'evening'
        ELSE 'days'
    END AS shift
FROM
    retailsales;

SELECT 
    sale_time
FROM
    retailsales
WHERE
    sale_time BETWEEN '17' AND '23';






