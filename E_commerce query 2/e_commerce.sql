create database Lizzy_trade
use lizzy_trade
select * from [dbo].[Customer_table]
select * from [dbo].[order_table]

-- Combined Tables
select c.name,
c.gender,
c.city,
o.order_id,
o.customer_id,
o.amount
from customer_table c inner join order_table o 
on c.order_id = o.order_id

-- 1. Total spend per customer
select c.name, sum(o.amount) [Total Spend] from customer_table c join order_table o
on c.order_id = o.order_id
group by c.name

-- 2. Customers with no orders
select c.name,o.order_id
from Customer_table c left join order_table o 
on c.order_id = o.order_id
where o.order_id is null

-- 3. Total Customers with no orders
select count (c.name) [Total Missing ID], o.order_id 
from Customer_table c left join order_table o 
on c.order_id = o.order_id
group by   o.order_id
having  o.order_id is null

-- 4. Total orders per city
select
c.city,
count(o.order_id) [Total Orders]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by c.city

-- 5. Average order value per customer
select c.name,
avg(o.amount) [Average order value]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by c.name


--6. Highest single order per customer
select c.name,
max(o.amount) [Highest order]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by c.name

-- 7. Orders with missing customer's detail
select c.name,o.order_id
from Customer_table c right join order_table o 
on c.order_id = o.order_id
where c.name is null

-- 8. Total Orders with missing customer's details
select c.name, count (o.order_id) [Total count]
from Customer_table c right join order_table o 
on c.order_id = o.order_id
group by c.name 
having c.name is null

 -- 9. Group Empty customers as 'Guest Customers'
 select 
 case when c.name is null
 then 'Guest customer'
 else c.name
 end [name],
 count (o.order_id) [order count]
 from  Customer_table c right join order_table o 
on c.order_id = o.order_id
group by 
case when c.name is null
 then 'Guest customer'
 else c.name
 end

-- 10.  Customers with total spend > 50000
select * from 
(select c.name,
sum(o.amount) [Total_spend]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by c.name)t
where [Total_spend] > 50000

-- or 
Select c.name, SUM(o.amount) [total_spend]
from customer_table c inner join order_table o
on c.order_id = o.order_id
group by c.name
Having SUM(o.amount) > 50000


-- 11. Customers with more than 10 orders
select c.name,
count(o.order_id) [Total Orders]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by c.name
having count(o.order_id) > 10

-- 12. Monthly revenue

select  month (date) [month],
sum (amount) [revenue]
from order_table
group by month (date)
order by  revenue desc

--13.  Best performing month
select top 1 month, revenue from 
(select  month (date) [month],
sum (amount) [revenue]
from order_table
group by month (date))t
order by  revenue desc

--14. Top city by revenue
select top 1 city,revenue from 
(select c.city [city],
sum(o.amount) [revenue]
from customer_table c inner join order_table o 
on c.order_id = o.order_id
group by city)t
order by revenue desc

--15. Find duplicate customers (same name)

SELECT name, COUNT(*) [Duplicate count]
FROM customer_table
GROUP BY name
HAVING COUNT(*) > 1
 


 



