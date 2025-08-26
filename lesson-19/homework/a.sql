create database homework19
use  homework19


--📄 Task 1: Employee Bonus Procedure
--CREATE PROCEDURE GetEmployeeBonus
AS
BEGIN
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with bonus calculation
    INSERT INTO #EmployeeBonus
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * d.BonusPercentage / 100 AS BonusAmount
    FROM Employees e
    JOIN DepartmentBonus d
        ON e.Department = d.Department;

    -- Select final result
    SELECT * FROM #EmployeeBonus;
END;

--📄 Task 2: Update Salary by Department
CREATE PROCEDURE UpdateDepartmentSalary
    @Dept NVARCHAR(50),
    @Increase DECIMAL(5,2)
AS
BEGIN
    -- Update salary
    UPDATE Employees
    SET Salary = Salary * (1 + @Increase / 100)
    WHERE Department = @Dept;

    -- Return updated rows
    SELECT * 
    FROM Employees
    WHERE Department = @Dept;
END;

--✅ Part 2: MERGE Tasks
--📄 Task 3: Merge Products
MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID

-- Update existing
WHEN MATCHED THEN
    UPDATE SET 
        target.ProductName = source.ProductName,
        target.Price = source.Price

-- Insert new
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)

-- Delete missing
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Show final state
SELECT * FROM Products_Current;

--📄 Task 4: Tree Node Classification (LeetCode style)
SELECT 
    id,
    CASE
        WHEN p_id IS NULL THEN 'Root'
        WHEN id NOT IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Leaf'
        ELSE 'Inner'
    END AS type
FROM Tree;

--📄 Task 5: Confirmation Rate (LeetCode style)
SELECT 
    s.user_id,
    CAST(
        ISNULL(AVG(CASE WHEN c.action = 'confirmed' THEN 1.0 ELSE 0 END), 0) 
        AS DECIMAL(3,2)
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;

--📄 Task 6: Employees with Lowest Salary
SELECT *
FROM employees
WHERE salary = (
    SELECT MIN(salary) FROM employees
);

--📄 Task 7: Product Sales Summary Procedure
CREATE PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s
        ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
