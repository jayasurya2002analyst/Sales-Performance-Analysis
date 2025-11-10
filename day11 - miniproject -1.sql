--  createing a database -- 
create database Sales_project ;

-- useing the datebase --
use Sales_project ;

-- createing the Table --

create Table sales( OrderID	int ,
                    ProductName	 varchar(20) ,
                    Category varchar(20) ,
                    Region varchar(20) ,
                    Quantity int ,
                    Sales  int ,
                    Profit int ,	
                    OrderDate date);     
                    
-- impoortng the values to the tables by import method --                     

-- Tasks --

/*  1. Category performance 

     --> Each Category of Total sales & Total Profit  */
 select category ,
 sum(Sales) as Total_sales,
 sum(Profit) as Total_profit 
 from sales
 group by Category ;
           
--   --> profit % (profit/Sales) compare chesi , best category identify --      
Select 
       Category,
       sum(Sales) as Total_sales ,
       sum(profit) as Total_profit ,
       (sum(Profit) * 100.0 / sum(Sales)) as profit_percentage 
from Sales 
group by Category 
order by Profit_percentage DESC 
LIMIT 1 ;

/*  2.Region performance 
    
     --> Region-wise Total Sales & Profit  */
     
  select
         Region ,
         sum(Sales) as Total_sales ,
         sum(profit) as Total_sales
from sales
group by Region ;         


--   --> Top Region (highest profit %) & weak region (lowset profit) -- 


With region_perf as (
 Select 
       Region,
       sum(Sales) as Total_sales ,
	   sum(profit) as Total_profit,
       round( sum(Profit) * 100.0 / 
       NULLIF(sum(Sales),0),2) as profit_percentage 
from Sales 
group by Region
),
ranked as (
select * , 
       dense_rank() over (order by profit_percentage desc) as rnk_top,
       dense_rank() over (order by profit_percentage asc )as rnk_weak
from region_perf )       
select 
       'Top Region' as label ,
        Region , 
        Total_sales ,
        Total_profit ,
        profit_percentage 
 from 
       ranked where rnk_top = 1
       
union all

select  
         'Weak Region' as label , 
		  Region , 
          Total_sales ,
          Total_profit ,
		  profit_percentage 
from  ranked  
where rnk_weak = 1 ;

/* 3.Top Products 
	
    --> Top 5 products by total sales    */
    
select 
       ProductName ,
       sum(Sales) as Total_sales
from sales 
group by ProductName 
order by Total_sales desc 
limit  5 
;       

--   Most Profitable 5 profits by total profit --

select 
       ProductName ,
       sum(Profit) as Total_Profit
from sales 
group by ProductName 
order by Total_Profit  desc 
limit  5 
;  

--  Product-wise average selling value (sales/quantity)  -- 

select 
	   ProductName ,
       sum(Profit) as Total_Profit,
       sum(Quantity) as Total_quantity ,
       round(sum(sales) /
       NULLIF(sum(Quantity), 0), 2) as Avg_selling_value
from 
     sales 
group by ProductName 
order by Avg_selling_value desc 
limit 5 ;  


/*  4. Monthly Trend 

   --> Month wisr Total sales   */
 
 select 
          date_format(OrderDate , '%b') as Month ,
          sum(Sales) as Monthly_sales
from 
      sales
group by date_format(OrderDate , '%b')
order by MIN(OrderDate) ;      

--   ---> Best month &  Worst month identify  -- 

With month_perf as (
 Select 
	   date_format(OrderDate , '%b') as Month,
       sum(Sales) as Total_sales 
from Sales 
group by date_format(OrderDate , '%b') 
),
ranked as (
select 
       Month,
       Total_sales ,
       dense_rank() over (order by Total_sales  desc) as rnk_top,
       dense_rank() over (order by Total_sales  asc )as rnk_weak
from 
month_perf )       
select 
	   'Best month' as label ,
        Month , 
        Total_sales 
 from 
       ranked where rnk_top = 1
       
union all

select   'Worst month ' as label , 
		  Month, 
          Total_sales 
from  ranked  
where rnk_weak = 1 ;

/* 5. Mix checks 
        --> Each Category–Region pair Sales & Profit (i.e., matrix view). */
        
 select 
        Category ,
        Region ,
        sum(Sales) as Total_sales,
        sum(Profit) as Total_profit
from 
     sales 
group by Category ,
		 Region
order by Category ,
         Region       ;
         
--   ---> Quantity chāla undi kani Profit takkuga unna leak areas find (high volume, low margin)         
         
         
SELECT 
	Category,
    ProductName,    
    Region,
    SUM(Quantity) AS Total_Quantity_Sold,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit) / SUM(Quantity)) AS Profit_Per_Unit
FROM
    sales
GROUP BY
	Category,
	ProductName ,
    Region
ORDER BY
    Total_Quantity_Sold DESC, -- Prioritize high volume
    Total_Profit asc ,
    Profit_Per_Unit ASC;      -- Prioritize low profit margin        

/*  6 . Outliers / sanity 
      ---> Very high Sales orders (top 5) list out → business check. */ 
      
select 
        * 
from 
        sales 
order by 
        sales desc
        limit 5  ;       

--  ----> Zero or negative Profit cases count (should be near zero). -- 

select 
       count(*)
from 
       sales 
where       
profit  <= 0 ;


/*    7. Where to focus to improve profit?

		---> Low Profit % unna Category/Region pairs list & reason guess (pricing/discounts/logistics). */

SELECT
    Category,
    ProductName ,
    Region,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit) * 100.0 / SUM(Sales)) AS Profit_Percentage
FROM
    sales
GROUP BY
    Category,
    ProductName,
    Region
ORDER BY
    Profit_Percentage ASC -- Lowest profit margins at the top
LIMIT 10; -- Focus on the bottom 10 pairs


/*   8.  Which products to promote?

     ---> High Profit % + decent Sales  products = promote list. */
     
SELECT
    ProductName,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit) * 100.0 / SUM(Sales)) AS Profit_Percentage
FROM
    sales
GROUP BY
    ProductName
HAVING
    SUM(Sales) > (SELECT AVG(Sales) FROM sales) -- Filter for decent sales volume (above average)
    AND (SUM(Profit) * 100.0 / SUM(Sales)) > 15 -- Adjust to your target "High Profit %" (e.g., > 15%)
ORDER BY
    Total_Profit DESC;    
    
/*   9 . Stock planning hint

 High quantity but low Sales value items → bundle offers idea.  */
 
 SELECT
    ProductName,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales
FROM
    sales
GROUP BY
    ProductName
ORDER BY
    Total_Quantity DESC,  -- High Quantity first
    Total_Sales ASC;      -- Low Sales Value first  
    
--   --> Quantity takkuva kani high revenue unna items → premium strategy --

SELECT
    ProductName,
    SUM(Quantity) AS Total_Quantity,
    SUM(Sales) AS Total_Sales
FROM
    sales
GROUP BY
    ProductName
ORDER BY
	Total_Quantity ASC ,  -- Low Quantity first
    Total_Sales DESC ;  -- High Revenue first
    

    