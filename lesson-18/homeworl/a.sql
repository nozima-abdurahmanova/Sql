create database homework19
use homework19

--? TASKS on Stored Procedures and MERGE
--?? Part 1: Stored Procedure Tasks
--Tables to use:
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName NVARCHAR(50),
    LastName NVARCHAR(50),
    Department NVARCHAR(50),
    Salary DECIMAL(10,2)
);

--CREATE TABLE DepartmentBonus (
--    Department NVARCHAR(50) PRIMARY KEY,
--    BonusPercentage DECIMAL(5,2)
--);

--INSERT INTO Employees VALUES
--(1, 'John', 'Doe', 'Sales', 5000),
--(2, 'Jane', 'Smith', 'Sales', 5200),
--(3, 'Mike', 'Brown', 'IT', 6000),
--(4, 'Anna', 'Taylor', 'HR', 4500);

INSERT INTO DepartmentBonus VALUES
('Sales', 10),
('IT', 15),
('HR', 8);
--?? Task 1:
--Create a stored procedure that:

--Creates a temp table #EmployeeBonus
--Inserts EmployeeID, FullName (FirstName + LastName), Department, Salary, and BonusAmount into it
--(BonusAmount = Salary * BonusPercentage / 100)
--Then, selects all data from the temp table.
-- Вставляем данные (FullName = FirstName + ' ' + LastName)
CREATE TABLE #EmployeeBonus (
    EmployeeID INT,
    FullName VARCHAR(100),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    BonusAmount DECIMAL(10,2)
);
INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
VALUES
(1, 'Anna Smith',   'HR',      3000, 3000 * 10 / 100),
(2, 'James Brown',  'IT',      4500, 4500 * 15 / 100),
(3, 'David Johnson','Finance', 5000, 5000 * 12 / 100);
select*from  #EmployeeBonus
--?? Task 2:
--Create a stored procedure that:

--Accepts a department name and an increase percentage as parameters
--Update salary of all employees in the given department by the given percentage
--Returns updated employees from that department.
create proc UpdateDepartmentSalary
    @department VARCHAR(50),
    @increasingpercentage DECIMAL(5,2)
as
begin
     update #EmployeeBonus
    set Salary = Salary + (Salary * @increasingpercentage / 100)
    where Department=@department
    select EmployeeID, FirstName, LastName, Department, Salary
    from Employees
    where Department = @Department;
END;
GO
select*from #EmployeeBonus
where UpdateDepartmentSalary ='IT', 20
    
