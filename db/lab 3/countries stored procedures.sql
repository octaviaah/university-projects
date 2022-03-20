--a. modify the type of a column;
GO
CREATE OR ALTER PROCEDURE do1
AS
BEGIN
	ALTER TABLE Country
	ALTER COLUMN area FLOAT
END
GO

GO
CREATE OR ALTER PROCEDURE undo1
AS
BEGIN
	ALTER TABLE Country
	ALTER COLUMN area INT
END
GO

--b. add / remove a column;
GO
CREATE OR ALTER PROCEDURE do2
AS
BEGIN
	ALTER TABLE City
	ADD mayor VARCHAR(50)
END
GO

GO
CREATE OR ALTER PROCEDURE undo2
AS
BEGIN
	ALTER TABLE City
	DROP COLUMN mayor
END
GO

--c. add / remove a DEFAULT constraint;
GO
CREATE OR ALTER PROCEDURE do3
AS
BEGIN
	ALTER TABLE Language
	ADD CONSTRAINT defaultName
	DEFAULT 'English' FOR languageName
END
GO


GO
CREATE OR ALTER PROCEDURE undo3
AS
BEGIN
	ALTER TABLE Language
	DROP CONSTRAINT defaultName
END
GO


--d.add / remove a primary key;
GO
CREATE OR ALTER PROCEDURE do4
AS
BEGIN
	CREATE TABLE TestTable(TestColumn INT NOT NULL);
	ALTER TABLE TestTable
	ADD CONSTRAINT PK_Column PRIMARY KEY(TestColumn)
END
GO

GO
CREATE OR ALTER PROCEDURE undo4
AS
BEGIN
	ALTER TABLE TestTable
	DROP CONSTRAINT PK_Column
	DROP TABLE IF EXISTS TestTable
END
GO


--e.add / remove a candidate key;
GO
CREATE OR ALTER PROCEDURE do5
AS
BEGIN
	ALTER TABLE Country
	ADD CONSTRAINT UQ_CountryNameCapital UNIQUE(countryName, capital)
END
GO

GO
CREATE OR ALTER PROCEDURE undo5
AS
BEGIN
	ALTER TABLE Country
	DROP CONSTRAINT UQ_CountryNameCapital
END
GO



--f. add / remove a foreign key;
GO
CREATE OR ALTER PROCEDURE do6
AS
BEGIN
	ALTER TABLE Flag
	ADD continentID INT;

	ALTER TABLE Flag
	ADD CONSTRAINT FK_continentID FOREIGN KEY(continentID) REFERENCES Continent(continentID)
END
GO


GO
CREATE OR ALTER PROCEDURE undo6
AS
BEGIN
	ALTER TABLE Flag
	DROP CONSTRAINT FK_continentID;

	ALTER TABLE Flag
	DROP COLUMN continentID
END
GO



--g. create / drop a table.
GO
CREATE OR ALTER PROCEDURE do7
AS
BEGIN
	CREATE TABLE TestTable2(
		TestID INT PRIMARY KEY,
		TestColumn VARCHAR(25)
		);
END
GO


GO
CREATE OR ALTER PROCEDURE undo7
AS
BEGIN
	DROP TABLE IF EXISTS TestTable2;
END
GO


--Create a new table that holds the current version of the database schema. Simplifying assumption: the version is an integer number.
CREATE TABLE Version
(
	id int IDENTITY(1, 1) NOT NULL,
	currentVersion int,
	CONSTRAINT PK_VERSION_ID PRIMARY KEY (id)
);

INSERT INTO Version VALUES(0);

GO
CREATE OR ALTER PROCEDURE changeVersionTo
	@versionFin INT
AS
BEGIN
	DECLARE @versionInit INT
	SET @versionInit = (SELECT V.currentVersion FROM Version V)
	DECLARE @query VARCHAR(2000)
	IF @versionFin <= 7 AND @versionFin >= 0
		IF @versionFin > @versionInit
		BEGIN
			WHILE @versionInit < @versionFin
				BEGIN
					SET @versionInit = @versionInit + 1
					SET @query = 'do' + CAST(@versionInit AS VARCHAR(5))
					EXEC @query
				END
		END
		ELSE
		BEGIN
			WHILE @versionFin < @versionInit
				BEGIN
					IF @versionInit != 0
					BEGIN
						SET @query = 'undo' + CAST(@versionInit AS VARCHAR(5))
						EXEC @query
					END
					SET @versionInit = @versionInit - 1
				END
		END
	ELSE
	BEGIN
		PRINT 'incorrect number'
		RETURN
	END
	UPDATE Version
	SET currentVersion = @versionFin
END
GO

EXEC changeVersionTo 10

SELECT currentVersion FROM Version
SELECT * from Country
SELECT * from City
SELECT * from Language
SELECT * from TestTable2