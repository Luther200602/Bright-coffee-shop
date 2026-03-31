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

