create database homework17
use homework17


--✅ Task 1: Distributor Sales by Region (fill missing with 0)
SELECT r.Region, d.Distributor, ISNULL(rs.Sales,0) AS Sales
FROM (SELECT DISTINCT Region FROM #RegionSales) r
CROSS JOIN (SELECT DISTINCT Distributor FROM #RegionSales) d
LEFT JOIN #RegionSales rs
    ON r.Region = rs.Region AND d.Distributor = rs.Distributor
ORDER BY r.Region, d.Distributor;

--✅ Task 2: Managers with ≥5 Direct Reports
SELECT e.name
FROM Employee e
JOIN Employee sub ON e.id = sub.managerId
GROUP BY e.id, e.name
HAVING COUNT(sub.id) >= 5;

--✅ Task 3: Products with ≥100 Units Ordered in Feb-2020
SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;

--✅ Task 4: Vendor with Most Orders per Customer
SELECT CustomerID, Vendor
FROM (
    SELECT CustomerID, Vendor,
           RANK() OVER(PARTITION BY CustomerID ORDER BY COUNT(*) DESC) AS rnk
    FROM Orders
    GROUP BY CustomerID, Vendor
) t
WHERE rnk = 1;

--✅ Task 5: Check if Number is Prime (WHILE loop)
DECLARE @Check_Prime INT = 91;
DECLARE @i INT = 2, @isPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @isPrime = 0;
        BREAK;
    END
    SET @i += 1;
END

IF @isPrime = 1 AND @Check_Prime > 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';

--✅ Task 6: Device Locations & Signals
WITH cte AS (
    SELECT Device_id, Locations, COUNT(*) AS signals
    FROM Device
    GROUP BY Device_id, Locations
),
summary AS (
    SELECT Device_id,
           COUNT(DISTINCT Locations) AS no_of_location,
           SUM(signals) AS no_of_signals
    FROM cte
    GROUP BY Device_id
)
SELECT s.Device_id, 
       s.no_of_location,
       (SELECT TOP 1 Locations 
        FROM cte c 
        WHERE c.Device_id = s.Device_id 
        ORDER BY signals DESC) AS max_signal_location,
       s.no_of_signals
FROM summary s;

--✅ Task 7: Employees Earning More than Dept Avg
SELECT e.EmpID, e.EmpName, e.Salary
FROM Employee e
JOIN (
    SELECT DeptID, AVG(Salary) AS avg_sal
    FROM Employee
    GROUP BY DeptID
) d ON e.DeptID = d.DeptID
WHERE e.Salary > d.avg_sal;

--✅ Task 8: Lottery Winnings
WITH ticket_summary AS (
    SELECT t.TicketID,
           SUM(CASE WHEN t.Number IN (SELECT Number FROM WinningNumbers) THEN 1 ELSE 0 END) AS matched,
           COUNT(DISTINCT w.Number) AS total
    FROM Tickets t
    CROSS JOIN (SELECT Number FROM WinningNumbers) w
    GROUP BY t.TicketID
)
SELECT SUM(
           CASE 
             WHEN matched = total THEN 100
             WHEN matched > 0 THEN 10
             ELSE 0
           END
       ) AS total_winnings
FROM ticket_summary;


(Expected output: 110)

--✅ Task 9: Spending Summary by Date & Platform
WITH user_summary AS (
    SELECT Spend_date, User_id,
           SUM(CASE WHEN Platform='Mobile' THEN Amount ELSE 0 END) AS mobile_amt,
           SUM(CASE WHEN Platform='Desktop' THEN Amount ELSE 0 END) AS desktop_amt
    FROM Spending
    GROUP BY Spend_date, User_id
)
SELECT Spend_date, 'Mobile' AS Platform,
       SUM(mobile_amt) AS Total_Amount,
       COUNT(*) FILTER (WHERE mobile_amt > 0 AND desktop_amt = 0) AS Total_users
FROM user_summary
GROUP BY Spend_date
UNION ALL
SELECT Spend_date, 'Desktop',
       SUM(desktop_amt),
       COUNT(*) FILTER (WHERE desktop_amt > 0 AND mobile_amt = 0)
FROM user_summary
GROUP BY Spend_date
UNION ALL
SELECT Spend_date, 'Both',
       SUM(mobile_amt + desktop_amt),
       COUNT(*) FILTER (WHERE mobile_amt > 0 AND desktop_amt > 0)
FROM user_summary
GROUP BY Spend_date
ORDER BY Spend_date, Platform;

--✅ Task 10: De-group Table (Expand Quantities)
--;WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
ORDER BY g.Product
OPTION (MAXRECURSION 0);
