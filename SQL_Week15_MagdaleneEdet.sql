-- CTEs

 with CTE_Employee as (
 select FirstName, LastName, Gender, Salary,
 count(gender) over (partition by Gender) as TotalGender,
 avg(Salary) over (partition by Gender) as AvgSalary
 from employeedemographics emp
 join employeesalary sal
	on emp.EmployeeID = sal.EmployeeID
where Salary > '45000')
select *
from CTE_Employee;

with CTE_Employee as (
 select FirstName, LastName, Gender, Salary,
 count(gender) over (partition by Gender) as TotalGender,
 avg(Salary) over (partition by Gender) as AvgSalary
 from employeedemographics emp
 join employeesalary sal
	on emp.EmployeeID = sal.EmployeeID)
select Firstname, AvgSalary
from CTE_Employee;

-- Temp Table
create Table temp_Employee (
EmployeeID int,
JobTitle varchar (100),
Salary int);

select * from temp_employee;

insert into temp_Employee values(
'1001', 'HR', '45000');

insert into temp_employee
SELECT *
FROM employeesalary;

select * FROM temp_employee;

create Table temp_Employee2 (
JobTitle varchar (100),
EmployeesPerJob int,
AvgAge int,
AvgSalary int);

insert into temp_employee2
select JobTitle, count(JobTitle), avg(age), avg(Salary)
from employeedemographics emp
 join employeesalary sal
on employeedemographics.EmployeeID = employeesalary.EmployeeID)
Group by JobTitle;

-- Subquaries
-- Subquary in select

select EmployeeID, Salary, (select avg(Salary) from employeesalary) AS AllAvgSalary
from employeesalary as AllAvgSalary;

-- How to do it with Partition By

select EmployeeID, Salary, avg(Salary) over() AllAvgSalary
from employeesalary as AllAvgSalary;

-- Why Group By Doesn't Work?
select EmployeeID, Salary, avg(Salary) AllAvgSalary
from employeesalary as AllAvgSalary
group by EmployeeID, Salary
order by 1,2;

-- Subquery in From
select a.EmployeeID, AllAvgSalary
from (select EmployeeID, Salary, avg(Salary) over() AllAvgSalary
from employeesalary) a;

-- Subquery in Where
select EmployeeID, JobTitle, Salary
from employeesalary
where EmployeeID in (
	select EmployeeID
    from employeedemographics
    where age > 30)