6 lesson homework

Finding Distinct Values
Question: Explain at least two ways to find distinct values based on two columns.

**Input table (`InputTbl`):**
```
| col1 | col2 |
|------|------|
| a    | b    |
| a    | b    |
| b    | a    |
| c    | d    |
| c    | d    |
| m    | n    |
| n    | m    |
```
**Result should be like this:**
```
| col1 | col2 |
|------|------|
| a    | b    |
| c    | d    |
| m    | n    |
```

```sql
CREATE TABLE InputTbl (
    col1 VARCHAR(10),
    col2 VARCHAR(10)
);
    INSERT INTO InputTbl (col1, col2) VALUES 
('a', 'b'),
('a', 'b'),
('b', 'a'),
('c', 'd'),
('c', 'd'),
('m', 'n'),
('n', 'm'); 

select * from InputTbl

select distinct col1, col2 
from InputTbl  

SELECT DISTINCT
    LEAST(col1, col2) AS val1,
    GREATEST(col1, col2) AS val2
FROM InputTbl;

## Puzzle 2: Removing Rows with All Zeroes
**Question: If all the columns have zero values, then don’t show that row. In this case, we have to remove the 5th row while selecting data.**

### Table Schema:
```sql
CREATE TABLE TestMultipleZero (
    A INT NULL,
    B INT NULL,
    C INT NULL,
    D INT NULL
);

INSERT INTO TestMultipleZero(A,B,C,D)
VALUES 
    (0,0,0,1),
    (0,0,1,0),
    (0,1,0,0),
    (1,0,0,0),
    (0,0,0,0),
    (1,1,1,0); 

	SELECT *
FROM TestMultipleZero
WHERE NOT (A = 0 AND B = 0 AND C = 0 AND D = 0);


## Puzzle 3: Find those with odd ids

create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro') 

	   SELECT *
FROM section1
WHERE id % 2 = 1;

```
## Puzzle 4: Person with the smallest id (use the table in puzzle 3)
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro') 
SELECT *
FROM section1
WHERE id = (SELECT MIN(id) FROM section1);

---

## Puzzle 5: Person with the highest id (use the table in puzzle 3) 
 
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro') 
	   SELECT *
FROM section1
ORDER BY id DESC

---

## Puzzle 6: People whose name starts with b (use the table in puzzle 3) 
create table section1(id int, name varchar(20))
insert into section1 values (1, 'Been'),
       (2, 'Roma'),
       (3, 'Steven'),
       (4, 'Paulo'),
       (5, 'Genryh'),
       (6, 'Bruno'),
       (7, 'Fred'),
       (8, 'Andro') 
SELECT *
FROM section1
WHERE name LIKE 'B%'; 


---

## Puzle 7: Write a query to return only the rows where the code contains the literal underscore _ (not as a wildcard).
```sql 
CREATE TABLE ProductCodes (
    Code VARCHAR(20)
);

INSERT INTO ProductCodes (Code) VALUES
('X-123'),
('X_456'),
('X#789'),
('X-001'),
('X%202'),
('X_ABC'),
('X#DEF'),
('X-999'); 

SELECT *
FROM ProductCodes
WHERE Code LIKE '%\_%' ESCAPE '\';  













