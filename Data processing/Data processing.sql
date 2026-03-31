select * 
from `workspace`.`default`.`bright_coffee_shop_analysis`
 limit 1000;
select distinct store_id, store_location
from `workspace`.`default`.`bright_coffee_shop_analysis`;
--------------------------------------------------------
Checking how many sales occured
----------------------------------------------------------

SELECT SUM(transaction_qty) AS total_qty
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

SELECT DISTINCT product_detail
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

------------------------------------------------------
Checking openning time and closiing time
------------------------------------------------------

SELECT MIN(transaction_time) AS earliest_transaction_time
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

SELECT MAX(transaction_time) AS latest_transaction_time
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

--------------------------------------------------------------------
Checking sales against prices
---------------------------------------------------------------------

SELECT DISTINCT product_id
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

---------------------------------------------------------------
Checking prices of our products
---------------------------------------------------------------

SELECT MIN(unit_price) AS cheapest_price
FROM `workspace`.`default`.`bright_coffee_shop_analysis`


SELECT MAX(unit_price) AS expensive_price
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

----------------------------------------------------------------------
Checking number of rows, number of products and of different stores
-----------------------------------------------------------------------

SELECT COUNT(*) AS number_of_rows, COUNT(DISTINCT product_id) AS number_0f_products, COUNT(DISTINCT store_id) AS number_of_stores
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

SELECT*
FROM `workspace`.`default`.`bright_coffee_shop_analysis`
limit 10

---------------------------------------------------------------------------------------------------
IMPORTANTLINE: CHECKING EACH DAY, MONTH AND DATE OF WHICH TRANSACTION OCCURED AND THEIR REVENUES
---------------------------------------------------------------------------------------------------
SELECT transaction_id, transaction_date, Dayname(transaction_date) AS Day_name, Monthname(transaction_date),transaction_qty*unit_price AS revenue_per_transacion
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

-----------------------------------------------------------------------------------------------------
CHECKING DIFFERENT STORE LOCATIONS
-------------------------------------------------------------------------------------------------------

SELECT DISTINCT store_location
FROM `workspace`.`default`.`bright_coffee_shop_analysis`
 
 ---------------------------------------------------------------------------------------------------
 checking sales on each store
 ---------------------------------------------------------------------------------------------------
 SELECT COUNT(DISTINCT store_id) AS number_of_stores
 FROM `workspace`.`default`.`bright_coffee_shop_analysis`

 -------------------------------------------------------------------------------------------------------
 checking how many details product that are sold
 --------------------------------------------------------------------------------------------------------

 SELECT DISTINCT product_detail
 FROM `workspace`.`default`.`bright_coffee_shop_analysis`
-----------------------------------------------------------------------------------------------------------
there are 80 product details
------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------
checking how many types of products sold at the store
------------------------------------------------------------------------------------------------------------------

 SELECT DISTINCT product_type
 FROM `workspace`.`default`.`bright_coffee_shop_analysis`

----------------------------------------------------------------------------------------------------------------------
there are 29 types of products
--------------------------------------------------------------------------------------------------------------------------

---------------------------------------------------------------------------------------------------------------------------
understanding the stores and what do they actually offer? and classify pruduct_type, product_category and product_details
---------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT product_category, product_type, product_detail AS product_name
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

--------------------------------------------------------------------------------------------------------------------------
Checking how many sales each store locaton holds in total sales
---------------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(transaction_id) AS number_of_sales, store_location
FROM `workspace`.`default`.`bright_coffee_shop_analysis`
GROUP BY store_location;
--------------------------------------------------------------------------------------------------------------------------------
Lower Manhattan holds 47782 sales
Hell's Kitchen holds 50735
Astoria holds 50599
----------------------------------------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------------------------------------
Checking if there is any null in various columns
----------------------------------------------------------------------------------------------------------------------------------

SELECT*
FROM `workspace`.`default`.`bright_coffee_shop_analysis`
WHERE store_location IS NULL OR transaction_qty IS NULL OR transaction_date IS NULL

---------------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------------
SELECT unit_price, transaction_qty, transaction_qty* unit_price AS Total_Amount
FROM `workspace`.`default`.`bright_coffee_shop_analysis`

-----------------------------------------------------------------------------------------------------
Combining function to get a clean enhanced data set
------------------------------------------------------------------------------------------------------
SELECT transaction_id, transaction_date, transaction_time, transaction_qty, store_id, store_location, product_id, unit_price, product_category, product_type, product_detail,

-----Adding columns to enhance the table for better insights------------

Dayname(transaction_date) AS Day_name, Monthname(transaction_date) AS Month_name, Dayofmonth(transaction_date) AS Day_of_month,

----New column transaction time bucket

CASE
     WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '05:00:00' AND '07:59:00' THEN 'early morning'
     WHEN date_format(transaction_time,'HH:mm:ss')BETWEEN '08:00:00' AND '10:59:00' THEN 'morning rush' 
     WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN'11:00:00' AND '13:59:00' THEN 'late morning' 
     WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN '14:00:00' AND '16:59:00' THEN 'afternoon' 
     WHEN date_format(transaction_time,'HH:mm:ss') BETWEEN'17:00:00' AND '19:59:00' THEN 'Evening start' 
     ELSE 'night' 
 END AS transaction_time_bucket,
    CASE 
        WHEN Dayname(transaction_date) IN ('Sunday','Saturday') THEN'Weekend' ELSE 'Weekday' END AS day_classification,
-----Casting ofunit_price
CAST(REPLACE(Unit_price,',','.') AS DECIMAL(10,2)) AS unit_Price_Clean,
-----new column-total revenue
(transaction_qty*Unit_Price_Clean) AS total_revenue,
----New column spend bucket
CASE
    WHEN(transaction_qty*Unit_Price_Clean) <50 THEN 'low spender'
    WHEN(transaction_qty*Unit_Price_Clean) BETWEEN 51 AND 200 THEN 'medium spender'
    WHEN(transaction_qty*Unit_Price_Clean) BETWEEN 201 AND 300 THEN 'large spender'
    ELSE 'the most'
    END AS spend_bucket
FROM `workspace`.`default`.`bright_coffee_shop_analysis`





