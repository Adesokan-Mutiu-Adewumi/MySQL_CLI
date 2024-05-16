-- 1 What is the name of the company that supplied the product with ProductID 1?
select s.companyname, p.productid
from suppliers s
join products p on p.SupplierID = s.SupplierID
where p.productid = 1;

-- 2 What is the name of the employee who made the sale with OrderID 10248?
select concat(e.lastname,' ',e.firstname) as Fullname, o.OrderID
from employees e
join orders o on o.EmployeeID = e.EmployeeID
where o.OrderID = '10248';

-- 3 How many products does the category with CategoryID 1 have?
select count(quantityperunit), categoryid
from products
where CategoryID = 1;

-- 4 What is the total price of the products ordered in OrderID 10248?
select sum(p.unitprice), od.orderid
from products p
join `order details` od on od.ProductID = p.ProductID
where od.OrderID = 10248
group by od.OrderID;

-- 5 What is the name of the customer with CustomerID ALFKI?
select companyname, customerid
from customers
where CustomerID = 'ALFKI';

-- 6 What is the total number of orders placed by the customer with CustomerID ALFKI?
select sum(od.quantity), o.customerid
from `order details` od
join orders o on o.OrderID = od.OrderID
where o.CustomerID = 'ALFKI';

-- 7 What is the name of the supplier that supplied the product with ProductID 1?
select s.companyname, p.productid
from suppliers s
join products p on p.SupplierID = s.SupplierID
where p.productid = 1;

-- 8 What is the name of the employee with EmployeeID 5?
select concat(lastname,' ',firstname) as `Employee Name`, employeeid
from employees
where EmployeeID = 5;

-- 9 What is the total number of customers in the Customers table?
select distinct companyname
from customers;

-- 10 What is the total number of employees in the Employees table?
select count(employeeid)
from employees;

-- 11 What is the total number of orders in the Orders table?
select count(orderid) as `Total number of order`
from orders;

-- 12 What is the total number of products in the Products table?
select count(productname)
from products;

-- 13 What is the total number of categories in the Categories table?
select distinct count(categoryname)
from categories;

-- 14 What is the total number of suppliers in the Suppliers table?
select count(SupplierID)
from suppliers;

-- 15 What is the total number of shippers in the Shippers table?
select count(companyname)
from shippers;

-- 16 What is the total number of territories in the Territories table?
select count(territoryid)
from territories;

-- 17 What is the total number of regions in the Regions table?
select count(regionid)
from region;

-- 18 What is the name of the shipper with ShipperID 2?
select companyname, shipperid
from shippers
where ShipperID = 2;

-- 19 What is the phone number of the customer with CustomerID ANATR?
select phone, customerid
from customers
where CustomerID = 'ANATR';


-- 20 What is the city of the customer with CustomerID ANATR?
select city, customerid
from customers
where customerid = 'ANATR';

-- 21 What is the postal code of the customer with CustomerID ANATR?
select PostalCode, customerid
from customers
where customerid = 'ANATR';

-- 22 What is the name of the contact person for the customer with CustomerID ANATR?
select ContactName, customerid
from customers
where customerid = 'ANATR';

-- 23 What is the name of the product with ProductID 1?
select productname as `Product Name`, productid
from products
where ProductID = 1;

-- 24 What is the unit price of the product with ProductID 1?
select UnitPrice, productid
from products
where ProductID = 1;

-- 25 What is the quantity of the product with ProductID 1 in stock?
select UnitsInStock, QuantityPerUnit, productid
from products
where ProductID = 1;

-- 26 What is the name of the category with CategoryID 1?
select Categoryname, CategoryID
from categories
where CategoryID = 1;

-- 27 What is the name of the supplier with SupplierID 1?
select companyname, SupplierID
from suppliers
where SupplierID = 1;

-- 28 What is the name of the shipper with ShipperID 1?
select companyname, shipperid
from shippers
where ShipperID = 1;

-- 29 What is the name of the region with RegionID 1?
select regiondescription, regionid
from region
where regionid = 1;

-- 30 What is the name of the territory with TerritoryID 1?
select territorydescription, territoryid
from territories
where TerritoryID = 1;

-- 31 What is the total revenue earned by the company in the year 1997?
select sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1997;

-- 32 What are the names of all the products that have been discontinued?
select productname
from products
where Discontinued > 0;

-- 33 What is the total quantity of each product that has been ordered?
Select od.productid, sum(od.quantity) as `Product that has been ordered`, p.productname as `Product name`
from `order details` od
join products p on p.ProductID = od.ProductID
group by ProductID
order by `Product that has been ordered` desc;

-- 34 Which customer has placed the most number of orders?
select c.companyname, sum(od.quantity) as `Number of Order`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
group by c.CompanyName
order by `Number of Order` desc
limit 1;

-- 35 What is the total amount spent by each customer in the year 1998?
select c.CompanyName, sum(od.unitprice * od.quantity) as `Total Amount Spent`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
Where year(o.orderdate) = 1998
group by c.CompanyName
order by `Total Amount Spent` desc;


-- 36 What are the names of all the employees who have sold products to customers in France?
select distinct concat_ws(' ',e.Lastname,e.firstname) as Fullname
from employees e
join orders o on o.EmployeeID = e.EmployeeID
join customers c on c.CustomerID = o.CustomerID
where c.country = 'France'
order by Fullname;


-- 37 What is the average number of days it takes for an order to be shipped after it is placed?
select avg(datediff(shippeddate, orderdate)) as `Average number of days for an order to be shipped`
from orders;

-- 38 What are the names of all the customers who have not placed any orders?
select distinct c.companyname, o.OrderID
from customers c
left join orders o on o.CustomerID = c.CustomerID
where o.OrderID is null;


select distinct CompanyName
from customers
where not customerid in (
	select distinct CustomerID
    from orders
);

-- 39 What is the total quantity of each product that has been ordered by customers in Germany?
select p.productname, sum(od.quantity) as `Total Quantity of Product Ordered from Germany`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where c.Country = 'Germany'
group by p.ProductName
order by `Total Quantity of Product Ordered from Germany` desc;

-- 40 What is the average price of all the products in the database?
select avg(unitprice * Unitsinstock) as `average price of all the products`
from products;

-- 41 What are the names of all the employees who have sold products to customers in Germany?
select distinct concat_ws(' ',e.Lastname,e.firstname) as Fullname
from employees e
join orders o on o.EmployeeID = e.EmployeeID
join customers c on c.CustomerID = o.CustomerID
where c.country = 'Germany'
order by Fullname;

-- 42 What is the total quantity of each product that has been ordered by customers in the year 1998?
select p.Productname, sum(od.quantity) as `Total Quantity`
from `order details` od 
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1998
group by p.ProductName
order by `Total Quantity` desc;

-- 43 What is the total revenue earned by each category of products?
select c.categoryname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join products p on p.ProductID = od.ProductID
join categories c on c.CategoryID = p.CategoryID
group by c.CategoryName
order by `Total Revenue` desc;

-- 44 What is the total quantity of each product that has been ordered by customers in the year 1997?
select p.Productname, sum(od.quantity) as `Total Quantity`
from `order details` od 
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1997
group by p.ProductName
order by `Total Quantity` desc;

-- 45 What is the average quantity of each product that has been ordered?
select p.productname, avg(od.quantity) as `Average Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
group by p.ProductName
order by `Average Quantity` desc;


-- 46 What are the names of all the customers who have placed orders in the year 1997?
select distinct (c.companyname)
from customers c
join orders o on o.CustomerID = c.CustomerID
where year(o.orderdate) = 1997
order by c.CompanyName;

-- 47 What is the total quantity of each product that has been ordered by customers in the USA?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where c.country = 'USA'
group by p.ProductName
order by `Total Quantity` desc;

-- 48 What are the names of all the employees who have sold products to customers in the year 1997?
select distinct concat_ws(' ',e.lastname,e.firstname) as `Name of Employee` 
from employees e
join orders o on o.EmployeeID = e.EmployeeID
where year(o.orderdate) = 1997
order by `Name of Employee`;


-- 49 What is the total revenue earned by each employee?
select distinct concat_ws(' ',e.lastname,e.firstname) as `Name of Employee`, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
join employees e on e.EmployeeID = o.EmployeeID
group by `Name of Employee`
order by `Total Revenue` desc;

-- 50 What are the names of all the products that have been ordered by customers in the year 1997?
select p.productname
from products p
join `order details` od on od.ProductID = p.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1997
group by p.ProductName;


-- 51 What is the total revenue earned by the company in the year 1998?
select sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1998;

-- 52 What is the average quantity of each product that has been ordered by customers in the year 1998?
select p.productname, avg(od.quantity) as `Average Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1998
group by p.ProductName
order by `Average Quantity` desc;


-- 53 What is the total amount spent by each customer in the year 1997?
select c.companyname, sum(od.unitprice * od.quantity) as `Total Amount Spent`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where year(o.OrderDate) = 1997
group by c.companyname
order by `Total Amount Spent` desc;

-- 54 What are the names of all the employees who have sold products to customers in the year 1998?
select distinct concat_ws(' ', e.Lastname,e.Firstname) as `Employee Name`
from employees e
join orders o on o.EmployeeID = e.EmployeeID
where year(o.OrderDate) = 1998
order by `Employee Name`; 

-- 55 What is the total quantity of each product that has been ordered by customers in the year 1996?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1996
group by p.ProductName
order by `Total Quantity` desc;


-- 56 What is the total revenue earned by each supplier?
select s.companyname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join products p on p.ProductID = od.ProductID
join suppliers s on s.SupplierID = p.SupplierID
group by s.CompanyName
order by `Total Revenue` desc;


-- 57 What is the total quantity of each product that has been ordered by customers in the year 1995?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1995
group by p.ProductName
order by `Total Quantity` desc;


-- 58 What are the names of all the customers who have placed orders in the year 1998?
select distinct c.companyname
from customers c
join orders o on o.CustomerID = c.CustomerID
where year(o.orderdate) = 1998;


-- 59 What is the average price of all the products in each category?
select c.categoryname, avg(p.unitprice) as `Average Price`
from products p
join categories c on c.CategoryID = p.CategoryID
group by c.CategoryName
order by `Average Price` desc;


-- 60 What is the total quantity of each product that has been ordered by customers in the year 1999?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1999
group by p.ProductName
order by `Total Quantity` desc;


-- 61 What are the names of all the customers who have placed orders in the year 1995?
select distinct c.companyname
from customers c
join orders o on o.CustomerID = c.CustomerID
where year(o.orderdate) = 1995;


-- 62 What is the total amount spent by each customer in the year 1996?
select c.companyname, sum(od.unitprice * od.quantity) as `Total Amount Spent`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where year(o.orderdate) = 1996
group by c.CompanyName
order by `Total Amount Spent` desc;

-- 63 What are the names of all the employees who have sold products to customers in the USA?
select distinct concat_ws(' ',e.Firstname,e.Lastname) as Fullname
from employees e
join orders o on o.EmployeeID = e.EmployeeID
join customers c on c.CustomerID = o.CustomerID
where c.Country = 'USA';

-- 64 What is the total revenue earned by each customer in the year 1998?
select c.companyname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where year(o.orderdate) = 1998
group by c.CompanyName
order by `Total Revenue` desc;

-- 65 What is the total quantity of each product that has been ordered by customers in the year 1994?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1994
group by p.ProductName
order by `Total Quantity` desc;


-- 66 What are the names of all the products that have been ordered by customers in the USA?
select distinct p.productname
from products p
join `order details` od on od.ProductID = p.ProductID
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where c.Country = 'USA';

-- 67 What is the average number of days it takes for an order to be shipped after it is placed, for each customer?
select c.companyname, avg(datediff(o.shippeddate, o.orderdate)) as `Average Number of Days`
from orders o
join customers c on c.CustomerID = o.CustomerID
group by c.CompanyName
order by `Average Number of Days` desc;

-- 68 What is the total quantity of each product that has been ordered by customers in the year 1993?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.OrderDate) = 1993
group by p.ProductName
order by `Total Quantity` desc;


-- 69 What is the total revenue earned by each employee in the year 1997?
select distinct concat_ws(' ',e.firstname,e.lastname) as Fullname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
join employees e on e.EmployeeID = o.EmployeeID
where year(o.orderdate) = 1997
group by Fullname
order by `Total Revenue` desc;


-- 70 What is the total revenue earned by each customer in the year 1996?
select distinct c.companyname as Fullname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where year(o.orderdate) = 1996
group by Fullname
order by `Total Revenue` desc;

-- 71 What are the names of all the employees who have sold products to customers in the year 1996?
select distinct concat_ws(' ',e.Firstname,e.Lastname) as Fullname
from employees e
join orders o on o.EmployeeID = e.EmployeeID
where year(o.orderdate) = 1996;


-- 72 What is the total revenue earned by each category of products in the year 1998?
select c.Categoryname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join products p on p.ProductID = od.ProductID
join categories c on c.CategoryID = p.CategoryID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1998
group by c.CategoryName
order by `Total Revenue` desc;

-- 73 What are the names of all the customers who have placed orders in the year 1996?
select distinct c.companyname
from customers c
join orders o on o.CustomerID = c.CustomerID
where year(o.orderdate) = 1996;

-- 74 What is the total quantity of each product that has been ordered by customers in the year 1998 and has not been discontinued?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1998 and p.Discontinued = 0
group by p.ProductName
order by `Total Quantity` desc;


-- What is the total revenue earned by each supplier in the year 1997?
select s.companyname, sum(od.unitprice * od.quantity) as `Total Revenue`
from `order details` od
join products p on p.ProductID = od.ProductID
join suppliers s on s.SupplierID = p.SupplierID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1997
group by s.CompanyName
order by `Total Revenue` desc;

-- What are the names of all the customers who have placed orders in the year 1999?
select distinct c.companyname
from customers c
join orders o on o.CustomerID = c.CustomerID
where year(o.orderdate) = 1999;


-- 77 What is the average price of all the products that have been ordered by customers in the year 1998?
select avg(p.unitprice) as `Average Price`
from products p
join `order details` od on od.ProductID = p.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1998
order by `Average Price` desc;

-- 78 What is the total quantity of each product that has been ordered by customers in the year 1997 and has not been discontinued?
select p.productname, sum(od.quantity) as `Total Quantity`
from `order details` od
join products p on p.ProductID = od.ProductID
join orders o on o.OrderID = od.OrderID
where year(o.orderdate) = 1997 and p.Discontinued = 0
group by p.ProductName
order by `Total Quantity` desc;

-- 79 What are the names of all the employees who have sold products to customers in the year 1995?
select distinct concat_ws(' ',e.Firstname,e.Lastname) as Fullname
from employees e
join orders o on o.EmployeeID = e.EmployeeID
where year(o.orderdate) = 1996;


-- 80 What is the total revenue earned by each customer in the year 1995?
select c.companyname, sum(od.unitprice * od.quantity) as `Total Revenue Earned`
from `order details` od
join orders o on o.OrderID = od.OrderID
join customers c on c.CustomerID = o.CustomerID
where year(o.orderdate) = 1995
group by c.CompanyName
order by `Total Revenue Earned` desc;



