Use [Danny's Dinner]
GO
-- 1. What is the total amount each customer spent at the restaurant?
select customer_id, sum(price) as customer_spent
from sales s, menu  m
where s.product_id = m.product_id
group by customer_id;

--2. How many days has each customer visited the restaurant?
select customer_id, count(distinct order_date) as visits
from sales 
group by customer_id;

--3. What was the first item from the menu purchased by each customer?
with customer_order_cte as (
	select 	customer_id,
			order_date,
			product_name,
			rank() over(partition by customer_id order by order_date) as rank
	from sales s, menu m
	where s.product_id = m.product_id
	)
select customer_id,
		product_name
from customer_order_cte
where rank=1;

--4. What is the most purchased item on the menu and how many times was it purchased by all customers?
select top(1) product_name,
	count(s.product_id) as purchased
from sales s, menu m
where s.product_id = m.product_id
group by product_name
order by purchased;

--5. Which item was the most popular for each customer?
with fav_item_cte as (
	select customer_id,
			product_name,
			count(s.product_id) as ordered,
			DENSE_RANK() over(partition by customer_id order by count(s.product_id) desc) as rank	
	from menu m, sales s
	where m.product_id = s.product_id
	group by product_name, customer_id
)
select customer_id,
		product_name,
		ordered
from fav_item_cte
where rank = 1;

--6. Which item was purchased first by the customer after they became a member?
with cte_order_members as (
	select order_date, join_date, s.customer_id, s.product_id,
		ROW_NUMBER() over(partition by s.customer_id order by s.order_date) as rank
	from sales s, members mem
	where s.customer_id = mem.customer_id
	and s.order_date >= mem.join_date
)
select customer_id, cte_order_members.product_id, product_name, order_date, join_date
from cte_order_members, menu
where cte_order_members.product_id = menu.product_id 
and rank =1;

--7. Which item was purchased just before the customer became a member?
with cte_order_members as (
	select order_date, join_date, s.customer_id, s.product_id,
		ROW_NUMBER() over(partition by s.customer_id order by s.order_date) as rank
	from sales s, members mem
	where s.customer_id = mem.customer_id
	and s.order_date < mem.join_date
)
select customer_id, cte_order_members.product_id, product_name, order_date, join_date
from cte_order_members, menu
where cte_order_members.product_id = menu.product_id 
and rank =1;

--8. What is the total items and amount spent for each member before they became a member?
select	s.customer_id,
		COUNT(s.product_id) as item,
		SUM(me.price) as spent
from sales s, members mem, menu me
where s.customer_id = mem.customer_id 
and s.product_id = me.product_id
group by s.customer_id;

--9. If each $1 spent equates to 10 points and sushi has a 2x points multiplier - 
-- how many points would each customer have?

