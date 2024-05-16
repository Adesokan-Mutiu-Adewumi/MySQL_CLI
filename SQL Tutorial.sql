-- getting started with SQL for data analysis

-- 1. query that returns the names, hiredate, and birthdate of our employees
select firstname, lastname, hiredate, birthdate
from employees;

-- 2. query that returns the name the our customers, their countries and the name of their representative.
select companyname, contactname, country
from customers;

-- 3. Query that returns all the information about the companies handling our deliveries.
select shipperid, companyname, phone
from shippers;

select *
from shippers;

-- Retruns the names, city and representatives of our USA customers.
select companyname, city, contactname, country
from customers
where country = 'USA';

-- retruns the names; date of birth of employees earning above 2000 dollars. Also include their employment data
select lastname, firstname, birthdate, hiredate, salary
from employees
where salary > 2000;

-- retruns the order ID, country and freight cost for all orders shipped in 1997
select orderid, shipcountry, freight, shippeddate
from orders
where shippeddate between '1997-01-01' and '1997-12-31';

-- returns the names, date of birth, and country of employees hired in 1992
select lastname, firstname, birthdate, country, hiredate
from employees
where hiredate between '1992-01-01' and '1992-12-31';

-- returns the all orders shipped to the USA in 1997 
select orderid, shipcountry, shippeddate
from orders
where (shippeddate between '1997-01-01' and '1997-12-31') and (shipcountry = 'USA');

-- returns the details of the orders with freight cost above $300 sent to USA and the UK
select orderid, orderdate, shippeddate, shipname, freight, shipcountry
from orders
where freight > 300 and (shipcountry = 'USA' or shipcountry = 'UK');

-- returns the names of our customers and their representatives for customers in the USA, Mexico and the city of London
select companyname, contactname, country, city
from customers
where country in ('USA','Mexico') or city = 'London'; 

-- returns the details of products that must be restocked as a matter of priorty
select productname, QuantityPerUnit, UnitsInStock, UnitsOnOrder, ReorderLevel
from products
where (UnitsInStock - UnitsOnOrder) <= ReorderLevel;

use northwind;

-- returns the names, hiredate, and birthdate of employees that are married or that has a doctorate 


select firstname, lastname, hiredate, birthdate, titleofcourtesy
from employees
where TitleOfCourtesy in ('Dr.','Mr.','Mrs.'); 

-- pattern matching or wildcard.
-- returns the details of orders of sent to customers living in avenue.
select orderid, ShipAddress 
from orders
where shipaddress like '%ave%';

-- returns the names of employees starting with N
select firstname, lastname
from employees
where FirstName like 'N%' or LastName like 'N%';

-- return the names of the top 4 highest paid employees
select firstname, lastname, salary
from employees
order by salary desc
limit 4;

-- A company supplies products in Oyo State, write a query that returns the orders sent to GRAs in Sango Ibadan. 
-- Note, Ibadan is not the only city with a street named sango
/*
table -- orders
columns
address --
street -- bodija, sango, ojoo,
city -- ibadan
*/

select address, street, city
from orders
where (street = 'sango' and city = 'ibadan') or address like '%GRA.%';

-- write a query that returns the name of the employees that sold the top 7 orders with the most expensive fright cost
select employeeid, orderid, freight
from orders
order by freight desc
limit 7;

select concat(e.firstname, ' ',e.lastname) as fullnames, o.orderid, o.freight
from orders as o
join employees as e on e.EmployeeID = o.EmployeeID
order by o.freight
limit 7;

select concat_ws(' ',e.firstname, ' ',e.lastname) as fullnames, o.orderid, o.freight
from orders as o
join employees as e on e.EmployeeID = o.EmployeeID
order by o.freight
limit 7;

-- what is the total revenue earned by the company in the year 1997?
select sum(od.unitprice * od.quantity) as `total revenue in 1997`
from `order details` as od
join orders as o on o.orderid = od.orderid
where year(o.orderdate) = 1997;

-- What is the total quantity of each product that has been ordered by customers in the year 1996?
select pro.productname as `Prodct Name`, sum(ord.quantity) as `Total Quantity`
from `order details` ord
join orders o on o.OrderID = ord.OrderID
join products pro on pro.productid = ord.ProductID
where year(o.orderdate) = 1996
group by pro.Productname
order by 'Total Quantity' desc;

-- What the name
select distinct e.firstname, e.lastname
from orders o
join employees e on e.employeeid = o.EmployeeID
where o.shipcountry = 'Germany';

-- retruns the top 3 best performing employees in terms of revenue and number of order processed
select concat_ws(' ', e.firstname,e.lastname) as Fullname, sum(od.unitprice * od.quantity) as revenue, count(o.orderid) as `Number of Order`
from `order details` od
join orders o on o.orderid = od.orderid
join employees e on e.employeeid = o.employeeid
group by Fullname
order by revenue desc, `Number of Order` desc
limit 3;

-- retruns our top 7 best performing customers in term of total amount spent 
select c.companyname, sum(od.unitprice * od.quantity) as Amount
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
group by c.CompanyName
order by amount desc
limit 7;

-- returns the top 3 employees with most late orders
select concat_ws(' ',e.firstname,e.lastname) as Fullname, count(datediff(o.requireddate, o.shippeddate)) as no_times
from orders o
join employees e on e.EmployeeID = o.EmployeeID
where datediff(o.requireddate, o.shippeddate) < 0
group by fullname
order by no_times desc
limit 3;

-- returns the employees with most late orders
select concat_ws(' ',e.firstname,e.lastname) as Fullname, count(datediff(o.requireddate, o.shippeddate)) as no_times
from orders o
join employees e on e.EmployeeID = o.EmployeeID
where datediff(o.requireddate, o.shippeddate) < 0
group by fullname
order by no_times desc;

-- Create a reprot that showes the employeeid, the lastname and firstname as employee, and the lastname and firstname of who they
-- report to as manager from the employee table sorted by employee
select e.employeeid, concat_ws(' ',e.lastname, e.firstname) as Employee, concat_ws(' ',m.lastname, m.firstname) as Manager
from employees e
join employees m on m.EmployeeID = e.ReportsTo;
 
 
select e.employeeid, concat_ws(' ',e.lastname, e.firstname) as Employee, concat_ws(' ',m.lastname, m.firstname) as Manager
from employees e
left join employees m on m.EmployeeID = e.ReportsTo;

-- the top perforing countries in term of number of orders around the end of the year
select shipcountry, count(orderid) as No_order
from orders
where month(OrderDate) > 8
group by shipcountry
order by No_order desc;