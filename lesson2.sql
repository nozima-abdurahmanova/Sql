-- 1. Create Employees table
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    Name VARCHAR(50),
    Salary DECIMAL(10,2)
);
-- 2. Insert using different approaches
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (1, 'Alice', 6000.00);
INSERT INTO Employees
VALUES (2, 'Bob', 5500.00);
INSERT INTO Employees (EmpID, Name, Salary)
VALUES (3, 'Charlie', 5000.00), (4, 'David', 4500.00);
-- 3. Update salary for EmpID = 1
UPDATE Employees
SET Salary = 7000
WHERE EmpID = 1;

-- 4. Delete record where EmpID = 2
DELETE FROM Employees
WHERE EmpID = 2;

-- 5. Demonstrate DELETE, TRUNCATE, DROP
CREATE TABLE TestTable (
    ID INT,
    Data VARCHAR(50)
);
INSERT INTO TestTable VALUES (1, 'A'), (2, 'B'), (3, 'C');
DELETE FROM TestTable WHERE ID = 1;
TRUNCATE TABLE TestTable;
DROP TABLE TestTable;

-- 5. Definitions
-- DELETE: Removes specific rows; supports WHERE; rollback possible
-- TRUNCATE: Removes all rows; no WHERE; resets identity; fast
-- DROP: Completely deletes table including structure

-- 6. Modify column Name to VARCHAR(100)
ALTER TABLE Employees
ALTER COLUMN Name VARCHAR(100);
-- 7. Add Department column
ALTER TABLE Employees
ADD Department VARCHAR(50);

-- 8. Change Salary to FLOAT
ALTER TABLE Employees
ALTER COLUMN Salary FLOAT;

-- 11. Create Departments and fill using INSERT INTO SELECT
CREATE TABLE Departments (
    DeptID INT PRIMARY KEY IDENTITY(1,1),
    DeptName VARCHAR(50)
);
CREATE TABLE TempDept (
    DeptName VARCHAR(50)
);
INSERT INTO TempDept VALUES ('HR'), ('IT'), ('Marketing'), ('Finance'), ('Admin');
INSERT INTO Departments (DeptName)
SELECT DeptName FROM TempDept;

-- 12. Update Department to 'Management' where Salary > 5000
UPDATE Employees
SET Department = 'Management'
WHERE Salary > 5000;

-- 13. Delete all records from Employees but keep structure
DELETE FROM Employees;

-- 14. Drop Department column
ALTER TABLE Employees
DROP COLUMN Department;

-- 22. Create Products and back it up
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2)
);
INSERT INTO Products VALUES
(1, 'Laptop', 'Electronics', 1200.00),
(2, 'Phone', 'Electronics', 800.00);
SELECT * INTO Products_Backup
FROM Products;

-- 23. Rename Products to Inventory
EXEC sp_rename 'Products', 'Inventory';

-- 24. Change Price to FLOAT
ALTER TABLE Inventory
ALTER COLUMN Price FLOAT;

-- 25. Add IDENTITY column ProductCode starting at 1000, step 5
ALTER TABLE Inventory
ADD ProductCode INT IDENTITY(1000,5);



