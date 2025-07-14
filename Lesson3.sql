
-- 1. Purpose of BULK INSERT
-- Used to quickly import large volumes of data from a file into a SQL Server table.
-- 2. File formats that can be imported:
-- CSV, TXT, XML, JSON
-- 3. Create Products table
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(50),
    Price DECIMAL(10),    
	)

-- 4. Insert 3 records into Products
INSERT INTO Products (ProductID, ProductName, Price) VALUES
(1, 'Laptop', 1200.50),
(2, 'Mouse', 25.00),
(3, 'Keyboard', 45.99);
-- 5. NULL vs NOT NULL
-- NULL means missing/unknown; NOT NULL enforces that the column must have a value.
-- 6. Add UNIQUE constraint to ProductName
ALTER TABLE Products
ADD CONSTRAINT UQ_ProductName UNIQUE (ProductName);
-- 7. SQL comment example
-- This query gets all products with price over 100
SELECT * FROM Products WHERE Price > 100;
-- 8. Add CategoryID column
ALTER TABLE Products
ADD CategoryID INT;
-- 9. Create Categories table
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE
);
-- 10. IDENTITY purpose
-- Automatically generates unique values for a column, usually for primary key.
-- Example: IDENTITY(1,1)
-- 1. BULK INSERT example
BULK INSERT Products
FROM 'C:\data\products.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
-- 2. Add FOREIGN KEY to Products
ALTER TABLE Products
ADD CONSTRAINT FK_Category FOREIGN KEY (CategoryID)
REFERENCES Categories (CategoryID);
-- 3. PRIMARY KEY vs UNIQUE KEY
-- PRIMARY KEY = unique + not null, only one per table
-- UNIQUE = allows null, many per table
-- 4. CHECK constraint: Price must be > 0
ALTER TABLE Products
ADD CONSTRAINT CHK_Price_Positive CHECK (Price > 0);
-- 5. Add Stock column (NOT NULL)
ALTER TABLE Products
ADD Stock INT NOT NULL DEFAULT 0;
-- 6. Use ISNULL to handle NULL in Price
SELECT ProductName, ISNULL(Price, 0) AS Price FROM Products;
-- 7. FOREIGN KEY purpose
-- Ensures referential integrity; links child table column to primary key in parent tabl
-- 1. Customers table with Age >= 18
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    Name VARCHAR(50),
    Age INT CHECK (Age >= 18)
);
-- 2. Table with IDENTITY starting at 100, increment by 10
CREATE TABLE InvoiceNumbers (
    InvoiceID INT IDENTITY(100,10) PRIMARY KEY,
    Amount DECIMAL(10,2)
);
-- 3. Composite PRIMARY KEY
CREATE TABLE OrderDetails (
    OrderID INT,
    ProductID INT,
    Quantity INT,
    PRIMARY KEY (OrderID, ProductID)
);
-- 4. COALESCE vs ISNULL
-- COALESCE returns first non-null value in list
-- ISNULL returns replacement if first value is null
-- Example: COALESCE(NULL, NULL, 5) → 5
-- 5. Employees table with PRIMARY KEY and UNIQUE Email
CREATE TABLE Employees (
    EmpID INT PRIMARY KEY,
    FullName VARCHAR(100),
    Email VARCHAR(100) UNIQUE
)
-- 6. FOREIGN KEY with ON DELETE/UPDATE CASCADE
ALTER TABLE Products
ADD CONSTRAINT FK_Category_Cascade FOREIGN KEY (CategoryID)
REFERENCES Categories (CategoryID)
ON DELETE CASCADE
ON UPDATE CASCADE;