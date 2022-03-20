USE master
GO
ALTER DATABASE countries SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
GO
DROP DATABASE IF EXISTS countries
GO

CREATE DATABASE countries
GO
USE countries;

CREATE TABLE Continent(
	continentID INT PRIMARY KEY,
	continentName VARCHAR(50) NOT NULL,
);

CREATE TABLE Country
(
	countryID INT PRIMARY KEY IDENTITY(1,1),
	countryName VARCHAR(50) NOT NULL,
	population INT NOT NULL,
	president VARCHAR(100),
	area INT NOT NULL,
	capital VARCHAR(50),
	continentID INT FOREIGN KEY REFERENCES Continent(continentID)
);

CREATE TABLE City
(
	cityID INT PRIMARY KEY,
	cityName VARCHAR(50) NOT NULL,
	population INT NOT NULL,
	foundingYear INT NOT NULL,
	countryID INT FOREIGN KEY REFERENCES Country(countryID)
);

CREATE TABLE Currency(
	currencyID INT PRIMARY KEY IDENTITY(1,1),
	currencyName VARCHAR(50),
	creationYear INT,
	subunit VARCHAR(50),
	inflation INT,
	printer VARCHAR(150)
);

CREATE TABLE CurrencyHistory(
	countryID INT FOREIGN KEY REFERENCES Country(countryID),
	currencyID INT FOREIGN KEY REFERENCES Currency(currencyID)
	CONSTRAINT PK_currency_history PRIMARY KEY(countryID, currencyID)
);

CREATE TABLE Language(
	languageID INT PRIMARY KEY,
	languageName VARCHAR(50) NOT NULL,
	languageFamily VARCHAR(50) NOT NULL,
	writingSystem VARCHAR(50),
	nativeSpeakers INT
);

CREATE TABLE OfficialLanguage(
	countryID INT FOREIGN KEY REFERENCES Country(countryID),
	languageID INT FOREIGN KEY REFERENCES Language(languageID)
	CONSTRAINT PK_official_language PRIMARY KEY(countryID, languageID)
);

CREATE TABLE Organization(
	organizationID INT PRIMARY KEY,
	organizationName VARCHAR(50) NOT NULL,
	type VARCHAR(150),
	foundingYear INT CHECK(foundingYear > 1900 AND foundingYear < 2021)
);

CREATE TABLE OrganizationMembers(
	countryID INT FOREIGN KEY REFERENCES Country(countryID),
	organizationID INT FOREIGN KEY REFERENCES Organization(organizationID)
	CONSTRAINT PK_organization_members PRIMARY KEY(countryID, organizationID)
);

CREATE TABLE Flag(
	flagID INT PRIMARY KEY REFERENCES Country(countryID),
	no_of_colors INT DEFAULT 1,
	proportion VARCHAR(15),
	adoptionDate DATE,
	description VARCHAR(100),
);