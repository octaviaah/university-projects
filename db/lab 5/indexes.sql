--tableA(aid, a2, …)
CREATE TABLE tableA(
	aid INT PRIMARY KEY IDENTITY(1, 1),
	a2 INT UNIQUE,
	columnA VARCHAR(50)
)

INSERT INTO tableA VALUES (1, 'smth'), (2, 'other'), (3, 'this'), (199, 'that'), (177, 'and'), (12, 'the')

--tableB(bid, b2, …)
CREATE TABLE tableB(
	bid INT PRIMARY KEY IDENTITY(1, 1),
	b2 INT
)

INSERT INTO tableB VALUES (5), (2), (17), (25), (1), (84), (158), (50), (84), (17), (36)

--tableC(cid, aid, bid, …)
CREATE TABLE tableC(
	cid INT PRIMARY KEY IDENTITY(1, 1),
	aid INT FOREIGN KEY REFERENCES tableA(aid),
	bid INT FOREIGN KEY REFERENCES tableB(bid),
	)
INSERT INTO tableC VALUES (1, 5), (4, 10), (1, 1), (3, 9), (6, 7)

--a.Write queries on Ta such that their execution plans contain the following operators:
--clustered index scan
SET STATISTICS IO ON
GO
SELECT * FROM tableA
ORDER BY aid

--clustered index seek
SET STATISTICS IO ON
GO
SELECT * FROM tableA
WHERE aid = 2 OR aid = 4

--non clustered index seek and key lookup
SET STATISTICS IO ON
GO
SELECT * FROM tableA
WHERE a2 = 2

--non-clustered index scan and key lookup
SET STATISTICS IO ON
GO
SELECT * FROM tableA
ORDER BY a2


--b.Write a query on table Tb with a WHERE clause of the form WHERE b2 = value and analyze its execution plan. Create a nonclustered index that can speed up the query. Examine the execution plan again.
GO
CREATE NONCLUSTERED INDEX nci_b2 ON tableB(b2);
GO

SELECT * FROM tableB
WHERE b2 = 84

DROP INDEX nci_b2 ON tableB


--c.Create a view that joins at least 2 tables. Check whether existing indexes are helpful; if not, reassess existing indexes / examine the cardinality of the tables.
GO
CREATE OR ALTER VIEW testView
AS
	SELECT a.columnA, c.aid, b.b2 FROM tableA a
	INNER JOIN tableC c ON c.aid = a.aid
	INNER JOIN tableB b ON a.a2 = b.b2
GO

SELECT * FROM testView

SELECT * FROM tableA
SELECT * FROM tableB
SELECT * FROM tableC
