--table with 1PK and no FK
CREATE TABLE Country
(
	countryID INT PRIMARY KEY IDENTITY(1,1),
	countryName VARCHAR(50) NOT NULL,
	population INT NOT NULL,
	president VARCHAR(100),
	area INT NOT NULL,
	capital VARCHAR(50),
);

--table with 1PK and at least 1FK
CREATE TABLE City
(
	cityID INT PRIMARY KEY,
	cityName VARCHAR(50) NOT NULL,
	population INT NOT NULL,
	foundingYear INT NOT NULL,
	countryID INT FOREIGN KEY REFERENCES Country(countryID)
);

--table with multiple-column PK
CREATE TABLE PKTable
(
	id INT NOT NULL,
	pk1 INT NOT NULL,
	pk2 INT NOT NULL,
	CONSTRAINT PK_PKTable PRIMARY KEY(pk1, pk2)
);

--view that uses select on one table
GO
CREATE VIEW ViewSelect1
AS
	SELECT * FROM Country
GO

--view that uses select on multiple tables
GO
CREATE VIEW ViewSelect2
AS
	SELECT countryName, cityName, Country.population AS 'countryPopulation', City.population AS 'cityPopulation', president FROM Country, City
	WHERE cityName = capital
GO

--view that uses select on multiple tables and also uses group by
GO
CREATE VIEW ViewSelect3
AS
	SELECT MAX(countryName) AS 'countryName', SUM(City.population) AS 'populationFromCities', City.countryID FROM Country, City
	INNER JOIN PKTable ON pk1 = City.countryID AND pk2 = City.cityID
	WHERE Country.countryID = City.countryID
	GROUP BY City.countryID
GO

--insert values into tables
INSERT INTO Tables VALUES ('Country'), ('City'), ('PKTable')

--insert values into views
INSERT INTO Views VALUES ('ViewSelect1'), ('ViewSelect2'), ('ViewSelect3')

--insert values into country
SET IDENTITY_INSERT Country ON

INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (1, 'Germany',  83190556, 'Frank-Walter  Steinmeier', 357022, 'Berlin')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (2, 'United Kingdom', 67081000, 'Elizabeth II', 242495, 'London')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (3, 'Australia', 25887100, 'Elizabeth II', 7692024, 'Canberra')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (4, 'Mexico', 126014024, 'Andres Manuel Lopez Obrador', 1972550, 'Mexico City')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (5, 'Mongolia', 3353470, 'Ukhnagiin Khurelsukh', 1564116, 'Ulaanbaatar')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (6, 'Peru', 34294231, 'Pedro Castillo', 1285216, 'Lima')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (7, 'Canada', 38246108, 'Justin Trudeau', 9984670, 'Ottawa')
INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (8, 'France', 67413000, 'Emmanuel Macron', 640679, 'Paris')


SET IDENTITY_INSERT Country OFF

--insert values into city
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (1, 'Melbourne', 5159211, 1835, 3)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (2, 'Toronto', 2731571, 1750, 7)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (3, 'Sydney', 5367206, 1788, 3)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (4, 'Marseille', 868277, 600, 8)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (5, 'Mexico City', 9209944, 1325, 4)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (6, 'Munich', 1558395, 1158, 1)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (7, 'Burnley', 73021, 600, 2)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (8, 'London', 8961989, 47, 2)

--insert values into PKtable
INSERT INTO PKTable VALUES (1, 1, 6), (2, 2, 7), (3, 2, 8), (4, 3, 1), (5, 3, 3), (6, 4, 5), (7, 7, 2)

--create procedures that run the views
GO
CREATE OR ALTER PROCEDURE runView
	@viewID INT
AS
BEGIN
	DECLARE @viewName VARCHAR(50)
	SELECT @viewName = Name FROM Views WHERE ViewID = @viewID
	EXEC ('SELECT * FROM ' + @viewName)
END
GO

--insert values into tests
INSERT INTO Tests VALUES ('insertCountry'), ('insertCity'), ('insertPKTable'), ('deletePKTable'), ('deleteCity'), ('deleteCountry'),('runView')

SELECT * FROM Tests
SELECT * FROM Tables
SELECT * FROM Views

--insert values into testviews
INSERT INTO TestViews VALUES (7, 1), (7, 2), (7, 3)

SELECT * FROM TestViews

--insert values into testtables
INSERT INTO TestTables VALUES (1, 1, 50, 1), (2, 2, 50, 1), (3, 3, 50, 1), (4, 3, 50, 1), (5, 2, 50, 1), (6, 1, 50, 1)

SELECT * FROM TestTables

--procedures that delete data from tables
GO
CREATE OR ALTER PROCEDURE deleteCountry
AS
BEGIN
	DECLARE @pos INT
	SELECT @pos = Position FROM TestTables WHERE TestID = 1
	DELETE FROM Country
	WHERE countryID >= @pos
END
GO

GO
CREATE OR ALTER PROCEDURE deleteCity
AS
BEGIN
	DECLARE @pos INT
	SELECT @pos = Position FROM TestTables WHERE TestID = 2
	DELETE FROM City
	WHERE cityID >= @pos
END
GO

GO
CREATE OR ALTER PROCEDURE deletePKTable
AS
BEGIN
	DECLARE @pos INT
	SELECT @pos = Position FROM TestTables WHERE TestID = 3
	DELETE FROM PKTable
	WHERE id >= @pos
END
GO

--procedure that creates random string of lowercase letters
GO
CREATE OR ALTER PROCEDURE generateRandomString
	@length INT,
	@string VARCHAR(1000) OUTPUT
AS
	DECLARE @chars VARCHAR(26)
	SET @chars = 'abcdefghijkmnopqrstuvwxyz'
	DECLARE @index INT = 0
	SET @string = ''
	WHILE @index < @length
	BEGIN
		SELECT @string = @string + SUBSTRING(@chars, CONVERT(int, RAND() * 26) + 1, 1)
		SET @index = @index + 1
	END
RETURN
GO


--procedures that insert random data into tables
GO
CREATE OR ALTER PROCEDURE insertCountry
AS
	SET IDENTITY_INSERT Country ON
	DECLARE @index INT = 0
	DECLARE @NoOfRows INT
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 1

	DECLARE @randCountryName VARCHAR(25);
	DECLARE @randPresident VARCHAR(30);
	DECLARE @randCapital VARCHAR(20);

	WHILE @index < @NoOfRows
	BEGIN
		EXEC generateRandomString 25, @string = @randCountryName OUTPUT
		EXEC generateRandomString 30, @string = @randPresident OUTPUT
		EXEC generateRandomString 20, @string = @randCapital OUTPUT
		INSERT INTO Country(countryID, countryName, population, president, area, capital) VALUES (@index+1, @randCountryName, RAND() * 1000000000 + 1, @randPresident, RAND() * 1000000 + 1, @randCapital)
		SET @index = @index + 1
	END
	SET IDENTITY_INSERT Country OFF
GO

GO
CREATE OR ALTER PROCEDURE insertCity
AS
	DECLARE @index INT = 0
	DECLARE @NoOfRows INT
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 2
	DECLARE @NoOfRowsCountry INT
	SELECT @NoOfRowsCountry = @NoOfRows FROM TestTables WHERE TestId = 1

	DECLARE @randCityName VARCHAR(25);

	WHILE @index < @NoOfRows
	BEGIN
		EXEC generateRandomString 25, @string = @randCityName OUTPUT
		INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES  (@index+1, @randCityName, RAND() * 100000000 + 1, RAND() * 1521 + 500, RAND() * @NoOfRowsCountry + 1)
		SET @index = @index + 1
	END
GO

GO
CREATE OR ALTER PROCEDURE insertPKTable
AS
	DECLARE @index INT = 0
	DECLARE @NoOfRows INT
	SELECT @NoOfRows = NoOfRows FROM TestTables WHERE TestID = 3

	DECLARE @NoOfRowsCountry INT
	SELECT @NoOfRowsCountry = @NoOfRows FROM TestTables WHERE TestId = 1
	DECLARE @NoOfRowsCity INT
	SELECT @NoOfRowsCity = @NoOfRows FROM TestTables WHERE TestId = 2

	WHILE @index < @NoOfRows
	BEGIN
		INSERT INTO PKTable(id, pk1, pk2) VALUES (@index+1, RAND() * @NoOfRowsCountry + 1, RAND() * @NoOfRowsCity + 1)
		SET @index = @index + 1
	END
GO

--create procedure to test the performance of views
GO
CREATE OR ALTER PROCEDURE testPerfView
	@viewID INT
AS
BEGIN
	DECLARE @startTime DATETIME
	DECLARE @endTime DATETIME
	
	DECLARE @viewTestName VARCHAR(50)
	SELECT @viewTestName = Name FROM Tests INNER JOIN TestViews ON Tests.TestID = TestViews.TestID WHERE ViewID = @viewID

	DECLARE @message VARCHAR(75)
	SET @message = 'Test ' + @viewTestName + CAST(@viewID AS VARCHAR(5))
	PRINT @message

	SET @startTime = GETDATE()
	EXEC ('runView ' + @viewID)
	SET @endTime = GETDATE()

	INSERT INTO TestRuns VALUES (@message, @startTime, @endTime)
	INSERT INTO TestRunViews(TestRunID, ViewID, StartAt, EndAt) VALUES (@@IDENTITY, @viewID, @startTime, @endTime)
END
GO

EXEC testPerfView 3
SELECT * FROM TestRuns

--create procedure to test the performance of insert
GO
CREATE OR ALTER PROCEDURE testPerfInsert
	@tableName VARCHAR(100)
AS
BEGIN
	DECLARE @startTime DATETIME
	DECLARE @endTime DATETIME

	DECLARE @message VARCHAR(75)
	SET @message = 'Test insert' + @tableName
	PRINT @message

	SET @startTime = GETDATE()
	EXEC ('insert' + @tableName)
	SET @endTime = GETDATE()

	DECLARE @tableID INT
	SELECT @tableID = TableID FROM Tables WHERE Name = @tableName
	INSERT INTO TestRuns VALUES (@message, @startTime, @endTime)
	INSERT INTO TestRunTables(TestRunID, TableID, StartAt, EndAt) VALUES (@@IDENTITY, @tableID, @startTime, @endTime)
END
GO

EXEC testPerfInsert PKTable
SELECT * FROM TestRuns
SELECT * FROM City

--create procedure to test the performance of delete
GO
CREATE OR ALTER PROCEDURE testPerfDelete
	@tableName VARCHAR(100)
AS
BEGIN
	DECLARE @startTime DATETIME
	DECLARE @endTime DATETIME

	DECLARE @message VARCHAR(75)
	SET @message = 'Test delete' + @tableName
	PRINT @message

	SET @startTime = GETDATE()
	EXEC('delete' + @tableName)
	SET @endTime = GETDATE()

	DECLARE @tableID INT
	SELECT @tableID = TableID FROM Tables WHERE Name = @tableName
	INSERT INTO TestRuns VALUES (@message, @startTime, @endTime)
END
GO
EXEC testPerfDelete Country
SELECT * FROM TestRuns

--main procedure to test all tests
GO
CREATE OR ALTER PROCEDURE testPerfMain
AS
BEGIN
	DECLARE @index INT = 1
	WHILE 1 = 1
		BEGIN
			DECLARE @tableName VARCHAR(50)	
			DECLARE @testName VARCHAR(50)
			SET @testName = 'null'
			SELECT @testName = Name FROM Tests WHERE TestID = @index

			IF @testName LIKE '%View%'
				BEGIN
					DECLARE @viewID INT = 1
					DECLARE @checkViewID INT
					WHILE 1 = 1
						BEGIN
							SET @checkViewID = 0
							SELECT @checkViewID = ViewID FROM TestViews WHERE ViewID = @viewID
							IF @checkViewID = 0
								BEGIN
									BREAK
								END
							ELSE
								BEGIN
									EXEC ('testPerfView ' + @viewID)
									
								END
							SET @viewID = @viewID + 1
						END
					SET @index = @index + 1	
				END
			ELSE IF @testName LIKE 'insert%'
				BEGIN
					SELECT @tableName = Name FROM Tables INNER JOIN TestTables ON Tables.TableID = TestTables.TableID WHERE TestID = @index
					EXEC ('testPerfInsert ' + @tableName)
					SET @index = @index + 1
				END
			ELSE IF @testName LIKE 'delete%'
				BEGIN
					--SELECT @tableName = SUBSTRING(@testName, 7, 50)
					SELECT @tableName = Name FROM Tables INNER JOIN TestTables ON Tables.TableID = TestTables.TableID WHERE TestID = @index
					PRINT @tableName
					EXEC ('testPerfDelete ' + @tableName)
					SET @index = @index + 1
				END
			ELSE
				BEGIN
					BREAK
				END
		END
END
GO

EXEC testPerfMain
DELETE FROM TestRuns
DELETE FROM TestRunTables
DELETE FROM TestRunViews
DElete from Country
delete from PKTable
delete from City


SELECT * FROM Tests
SELECT * FROM TestRuns
SELECT * FROM TestRunTables
SELECT * FROM TestRunViews
SELECT * FROM TestViews
SELECT * FROM TestTables
SELECT * FROM Tables
SELECT * FROM Country
SELECT * FROM City
SELECT * FROM PKTable
SELECT * FROM Views

DELETE FROM Tests
DELETE FROM TestTables
DELETE FROM TestViews