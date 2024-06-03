create database Insurance_Analytics;

use Insurance_Analytics
Select * from Brokerage1;

select Count(*) From Brokerage1;

select p.income_class, i.income_class, p.amount,i.amount from placeachivement1 as p
inner join invoice1 as i
on p.branch_name = i.branch_name
inner join individual_budgets1 as ib
on i.branch_name = ib.branch
group by ib.Renewal;

SELECT 
    p.income_class AS placeachivement_income_class, 
    i.income_class AS invoice_income_class, 
    p.amount AS placeachivement_amount, 
    i.amount AS invoice_amount
FROM 
    placeachivement1 AS p
INNER JOIN 
    invoice1 AS i ON p.branch_name = i.branch_name
INNER JOIN 
    individual_budgets1 AS ib ON i.branch_name = ib.branch
GROUP BY 
    p.income_class, i.income_class, p.amount, i.amount;


SELECT 
    p.income_class AS placeachivement_income_class, 
    i.income_class AS invoice_income_class, 
    p.amount AS placeachivement_amount, 
    i.amount AS invoice_amount,ib.cross_sell_bugdet
 
FROM 
    placeachivement1 AS p
INNER JOIN 
    invoice1 AS i ON p.branch_name = i.branch_name
INNER JOIN 
    individual_budgets1 AS ib ON i.branch_name = ib.branch
GROUP BY 
    p.income_class, i.income_class, p.amount, i.amount, ib.cross_sell_bugdet;
    
    
    
    
    SELECT SUM(p.amount) AS total_placeachivement_amount, 
    SUM(i.amount) AS total_invoice_amount,
    sum(ib.cross_sell_bugdet)
    FROM 
    placeachivement1 AS p
INNER JOIN 
    invoice1 AS i ON p.branch_name = i.branch_name
INNER JOIN 
    individual_budgets1 AS ib ON i.branch_name = ib.branch
GROUP BY 
    p.income_class, i.income_class,ib.cross_sell_bugdet;


select sum(cross_sell_bugdet) from individual_budgets1 as ib;
select sum(amount)  from invoice1;


SELECT 
    SUM(i.amount) AS Invoice_Mn, 
    SUM(p.amount) AS Achieved_Mn, 
    SUM(ib.cross_sell_bugdet) AS Target_Mn,
    ib.cross_sell_bugdet
FROM 
    invoice1 AS i
INNER JOIN 
    placeachivement1 AS p ON i.branch_name = p.branch_name
INNER JOIN 
    individual_budgets1 AS ib ON i.branch_name = ib.branch
group by i.amount,p.amount,ib.cross_sell_bugdet;

---------------------------------------------------------------------------------------------

--------------------------------------------------------------------------


/*NO OF MEETINGS BY ACCOUNT EXECUTIVE */

CREATE VIEW meeting_1 AS
SELECT `Account Executive`, COUNT(*) as Meetings_Count
FROM meeting1
GROUP BY `Account Executive`;
 select * from meeting_1;
 ------------------------------------------------------------------------------------------
 /*NO OF INVOICE BY ACCOUNT EXECUTIVE */ 

select * from no_of_invoice_by_executive;

CREATE VIEW no_of_invoice_by_executive AS
SELECT `Account Executive`, COUNT(*) as `Invoice Count`
FROM invoice1
GROUP BY `Account Executive`;
-----------------------------------------------------------------------------------------

/*OPPORTUNITY BY REVENUE TOP-4*/ 

select * from opportunities_by_revenue_top_4;

CREATE VIEW opportunities_by_revenue_top_4 AS
SELECT opportunity_name,revenue_amount
FROM opportunity1
ORDER BY revenue_amount DESC
LIMIT 4;
------------------------------------------------------------------------------------------

/*STAGE FUNNEL BY REVENUE */

select * from stage_funnel_by_revenue;

CREATE VIEW stage_funnel_by_revenue AS
SELECT 
    stage,
    SUM(revenue_amount) AS total_revenue,
    COUNT(*) AS total_opportunities
FROM 
    opportunity1
GROUP BY 
    stage;
--------------------------------------------------------------------------------------
/*OPEN OPPORTUNITY TOP -4 */

select * from open_opportunities_top_4;

CREATE VIEW open_opportunities_top_4 AS
SELECT 
    opportunity_name,
    revenue_amount,
    CASE 
        WHEN stage = 'Negotiate' THEN 'Closed'
        ELSE 'Open'
    END AS status
FROM 
    opportunity1
WHERE 
    stage != 'Closed'
ORDER BY 
    revenue_amount DESC
LIMIT 4;
------------------------------------------------------------------------------------------------------------
/*OPPORTUNITY PRODUCT DISTRIBUTION */

select * from opportunity_product_distribution;

CREATE VIEW opportunity_product_distribution AS
SELECT product_group, COUNT(DISTINCT opportunity_name) AS total_opportunities
FROM opportunity1
GROUP BY product_group;
-----------------------------------------------------------------------------------------



-- New Placed  Percentage

Select concat(round((sum(amount)/(select sum(New_Budget) from individual_budgets1)*100),2),"%") as "New Placed  Percentage"
from placeachivement1 where income_class="new";
--------------------------------------------------------------------------------------------------------------------------------------
-- Renewal Placed Percentage

Select concat(round((sum(amount)/(select sum(Renewal_Budget) from individual_budgets1)*100),2),"%") as "Renewal Placed Percentage"
from placeachivement1 where income_class="Renewal";
----------------------------------------------------------------------------------------------------------------------------------------
-- Cross sell Placed Percentage

Select concat(round((sum(amount)/(select sum(Cross_sell_bugdet) from individual_budgets1)*100),2),"%") as "Cross sell Placed Percentage"
from placeachivement1 where income_class="Cross sell";
------------------------------------------------------------------------------------------------------------------------------------
-- New Invoiced Percentage

Select concat(round((sum(amount)/(select sum(New_Budget) from individual_budgets1)*100),2),"%") as "New Invoiced Percentage"
from invoice1 where income_class="new";
-----------------------------------------------------------------------------------------------------------------------------
-- Renewal Invoiced Percentage

Select concat(round((sum(amount)/(select sum(Renewal_Budget) from individual_budgets1)*100),2),"%") as "Renewal Invoiced Percentage"
from invoice1 where income_class="Renewal";
---------------------------------------------------------------------------------------------------------------------------------------------
-- Cross sell Invoiced Percentage

Select concat(round((sum(amount)/(select sum(Cross_sell_bugdet) from individual_budgets1)*100),2),"%") as "Cross sell Invoiced Percentage"
from invoice1 where income_class="Cross sell";
------------------------------------------------------------------------------------------------------------------------------------------------

select income_class,concat("Rs ",round(sum(amount)/1000000,2)," M") from placeachivement1 group by income_class ;
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "New Placed Achievement" from placeachivement1 where income_class="new";
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "Renewal Placed Achievement" from placeachivement1 where income_class="Renewal";
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "Cross sell Placed Achievement" from placeachivement1 where income_class="Cross sell";
--------------------------------------------------------------------------------------------------------------------------------------------------

select income_class,concat("Rs ",round(sum(amount)/1000000,2)," M") from invoice1 group by income_class ;
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "New Invoiced Achievement" from invoice1 where income_class="new";
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "Renewal Invoiced Achievement" from invoice1 where income_class="Renewal";
Select concat("Rs ",round(sum(amount)/1000000,2)," M") as "Cross sell Invoiced Achievement" from invoice1 where income_class="Cross sell"; 
select  Account_executive,
        count(invoice_number) as Total_Invoices from invoice 
group by Account_executive
order by Total_invoices desc;
----------------------------------------------------------------------------------------------------------------------------------------------

select concat("Rs ",round(sum(New_Budget)/1000000,2)," M") as New_Target,
			  concat("RS ",round(sum(Renewal_budget)/1000000,2)," M") as Renewal_Target,
              concat("Rs ",round(sum(Cross_sell_Bugdet)/1000000,2)," M")as Cross_sell_Target from individual_budgets1;

---------------------------------------------------------------------------------------------------------------------------------------------------

SELECT YEAR(meeting_date) AS meeting_year
FROM meeting1;

SELECT meeting_date AS meeting_year
FROM meeting1;

select * from meeting1;

select count(opportunity_Id) from opportunity1;








































































