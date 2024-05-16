-- query that returns the orderid, name of employee responsible for the order, the date it was shipped and whether or not it was 
-- shipped early, late or on same day
select concat_ws(' ',e.firstname,e.lastname) as Fullname, o.orderid, o.requireddate, o.ShippedDate,
case
	when o.requireddate > o.shippeddate then 'Early'
    when o.requireddate = o.shippeddate then 'Same Day'
    else 'Late'
end as `Shipment Remark`
from orders o
join employees e on e.EmployeeID = o.EmployeeID;

-- Return the names of employees, when they were hired and their retirement  status. People who have not exceed 30 years 
-- of service are the only ones not due for retirement
select concat_ws(' ',firstname,lastname) as Fullname, hiredate, year(now()) - year(hiredate)  as `Service Year`,
case
	when year(now()) - year(hiredate) > 30 then 'Due'
    else 'Not Due'
end as `Retirement Status`
from employees;


select o.customerid,
	case
		when sum(od.unitprice * od.quantity) <= 1000 then 'Group 1'
        when sum(od.unitprice * od.quantity) <= 5000 then 'Group 2'
        when sum(od.unitprice * od.quantity) <= 10000 then 'Group 3'
        else 'Group 4' 
	end as `Customers' Group`, sum(od.unitprice * od.quantity) as `Total Spent`
from `order details` od
join orders o on o.OrderID = od.OrderID 
where year(o.orderdate) = 1997
group by o.CustomerID;


-- Returns the names of employees that earns above average salary
select firstname, lastname, salary
from employees
where salary > (
	select avg(salary)
    from employees
);

-- returns the number of orders sold by the employee with the highest salary
select count(orderid) as no_of_orders
from orders
where employeeid = (
	select employeeid
    from employees
    where salary = (
		select max(salary)
        from employees)
	);


-- returns all the orders processed by the oldest employee
select *
from orders
where employeeid in (
	select EmployeeID
    from employees
    where year(now()) - year(hiredate) = (
		select max(year(now()) - year(hiredate))
        from employees
	));
    
select o.OrderID, o.CustomerID, e.EmployeeID, o.orderdate, o.RequiredDate, o.Freight
from orders o
join employees e on e.EmployeeID = o.EmployeeID
where year(now()) - year(hiredate) = (
	select max(year(now()) - year(hiredate))
		from employees
	);

-- retruns the countries of customers with no orders
select distinct companyname, country 
from customers
where not customerid in (
	select distinct customerid
	from orders
);

-- returns the total number of orders sold by sales representative
select count(orderid) as no_of_orders
from orders
where EmployeeID in (
	select distinct EmployeeID
    from employees
    where Title = 'Sales Representative'
);

select count(o.orderid) as no_of_orders
from orders o
join employees e on e.EmployeeID = o.EmployeeID
where e.Title = 'Sales Representative';
