--Insert data into table Continent
INSERT INTO Continent(continentID, continentName) VALUES(1, 'Europe')
INSERT INTO Continent(continentID, continentName) VALUES(2, 'Asia')
INSERT INTO Continent(continentID, continentName) VALUES(3, 'North America')
INSERT INTO Continent(continentID, continentName) VALUES(4, 'South America')
INSERT INTO Continent(continentID, continentName) VALUES(5, 'Africa')
INSERT INTO Continent(continentID, continentName) VALUES(6, 'Australia')
INSERT INTO Continent(continentID, continentName) VALUES(7, 'Antarctica')

--Insert data into table Country
SET IDENTITY_INSERT Country ON

INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (1, 'Germany',  83190556, 'Frank-Walter  Steinmeier', 357022, 'Berlin', 1)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (2, 'United Kingdom', 67081000, 'Elizabeth II', 242495, 'London', 1)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (3, 'Australia', 25887100, 'Elizabeth II', 7692024, 'Canberra', 6)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (4, 'Mexico', 126014024, 'Andres Manuel Lopez Obrador', 1972550, 'Mexico City', 3)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (5, 'Mongolia', 3353470, 'Ukhnagiin Khurelsukh', 1564116, 'Ulaanbaatar', 2)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (6, 'Peru', 34294231, 'Pedro Castillo', 1285216, 'Lima', 4)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (7, 'Canada', 38246108, 'Justin Trudeau', 9984670, 'Ottawa', 3)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (8, 'France', 67413000, 'Emmanuel Macron', 640679, 'Paris', 1)

--Error
--INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (9, 'Country', 5868686, 'President', 55222, 'Capital', 9)

SET IDENTITY_INSERT Country OFF

--Insert data into table City
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (1, 'Melbourne', 5159211, 1835, 3)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (2, 'Toronto', 2731571, 1750, 7)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (3, 'Sydney', 5367206, 1788, 3)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (4, 'Marseille', 868277, 600, 8)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (5, 'Mexico City', 9209944, 1325, 4)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (6, 'Munich', 1558395, 1158, 1)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (7, 'Burnley', 73021, 600, 2)
INSERT INTO City(cityID, cityName, population, foundingYear, countryID) VALUES (8, 'London', 8961989, 47, 2)


--Insert data into table Language
INSERT INTO Language(languageID, languageName, languageFamily, writingSystem, nativeSpeakers) VALUES (1, 'English', 'Indo-European', 'Latin', 400000000)
INSERT INTO Language(languageID, languageName, languageFamily, writingSystem, nativeSpeakers) VALUES (2, 'French', 'Indo-European', 'Latin', 768000000)
INSERT INTO Language(languageID, languageName, languageFamily, writingSystem, nativeSpeakers) VALUES (3, 'Spanish', 'Indo-European', 'Latin', 489000000)
INSERT INTO Language(languageID, languageName, languageFamily, writingSystem, nativeSpeakers) VALUES (4, 'German', 'Indo-European', 'Latin', 220000000)
INSERT INTO Language(languageID, languageName, languageFamily, writingSystem, nativeSpeakers) VALUES (5, 'Mongolian', 'Mongolic', 'Traditional Mongolian', 5200000)

--Insert data into table OfficialLanguage

INSERT INTO OfficialLanguage(countryID, languageID) VALUES (1, 4)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (2, 1)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (3, 1)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (4, 3)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (5, 5)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (6, 3)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (7, 1)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (7, 2)
INSERT INTO OfficialLanguage(countryID, languageID) VALUES (8, 2)

--Insert data into table Currency
SET IDENTITY_INSERT Currency ON

INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (1, 'Euro', 1999, 'cent', 3, 'European Central Bank')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (2, 'Pound sterling', 1801, 'penny', 2, 'Bank of England')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (3, 'Canandian dollar', 1858, 'cent', 2, 'Canadian Bank Note Company')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (4, 'Sol', 1991, 'centimo', 2, 'Central Reserve Bank of Peru')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (5, 'Togrog', 1925, 'mongo', 7, 'Bank of Mongolia')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (6, 'Australian dollar', 1966, 'cent', 1, 'Note Printing Australia')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (7, 'Australian pound', 1910, 'penny', 10, 'Reserve Bank of Australia')

SET IDENTITY_INSERT Currency OFF

--Insert data into table CurrencyHistory

INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (1, 1)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (8, 1)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (2, 2)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (3, 6)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (3, 7)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (7, 3)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (5, 5)
INSERT INTO CurrencyHistory(countryID, currencyID) VALUES (6, 4)

--Insert data into table Flag
INSERT INTO Flag(flagID, no_of_colors, proportion, adoptionDate, description) VALUES (1, 3, '3:5', '1949-5-23', 'A horizontal tricolour of black, red, and gold')
INSERT INTO Flag(flagID, no_of_colors, proportion, adoptionDate, description) VALUES (2, 3, '1:2', '1801-1-1', 'A white symmetric red cross on a blue field with a white counterchanged saltire of red and white')
INSERT INTO Flag(flagID, no_of_colors, proportion, adoptionDate, description) VALUES (3, 3, '1:2', '1908-12-8', 'A Blue Ensign defaced with the Commonwealth Star in the lower quarter and five stars in the fly half')
INSERT INTO Flag(flagID, no_of_colors, proportion, adoptionDate, description) VALUES (8, 3, '2:3', '1848-3-5', 'A vertical tricolour of blue, white, and red')
INSERT INTO Flag(flagID, no_of_colors, proportion, adoptionDate, description) VALUES (7, 2, '1:2', '1965-2-15', 'A vertical triband of red and white with the red maple leaf centred on the white band')

--Update countries

UPDATE Country
SET president = 'Elizabeth II'
WHERE countryID = 7

UPDATE Country
SET population = 90254784
WHERE countryID = 1

UPDATE Country
SET population = population + 1000
WHERE countryName like 'M%'

--Update currencies

UPDATE Currency
SET subunit = 'shilling'
WHERE currencyID = 7

UPDATE Currency
SET inflation = inflation + 1
WHERE currencyID = 5

UPDATE Currency
SET currencyName = 'Canadian dollar'
WHERE printer = 'Canadian Bank Note Company'

--Update languages

UPDATE Language
SET languageFamily = 'Indo-European Germanic'
WHERE languageName = 'English' or languageName = 'German'

UPDATE Language
SET languageFamily = 'Indo-European Italic'
WHERE languageName = 'French' or languageName = 'Spanish'

--Delete data from table Country
SET IDENTITY_INSERT Country ON

INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (100, 'testCountry', 5454, 'testPresident', 5555, 'testCapital', 2)
INSERT INTO Country(countryID, countryName, population, president, area, capital, continentID) VALUES (101, 'tysgdzsf', 56565, 'fhsdjhfskd', 6565, 'fhdhfdskf', 3)

DELETE from Country
WHERE countryID > 10

SET IDENTITY_INSERT Country OFF

--Delete data from table Currency

SET IDENTITY_INSERT Currency ON

INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (50, 'Name', 2025, 'jj', 5, 'jfhjdfhds')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (24, 'N', 2026, 'fksdjfd', 8, 'fjdskfhksdf')
INSERT INTO Currency(currencyID, currencyName, creationYear, subunit, inflation, printer) VALUES (66, 'test', 1444, 'fsjkhfsd', 55, 'fskjljfkldsf')

DELETE from Currency
WHERE creationYear > 2021

DELETE from Currency
WHERE currencyName like 'test'

SET IDENTITY_INSERT Currency OFF


--a.2 queries with the union operation; use UNION [ALL] and OR;
--show all the countries and all the languages from their respective databases
SELECT countryName FROM Country
UNION
SELECT languageName FROM Language

--show all the currencies that have as subunit the penny or the cent
SELECT currencyName, subunit FROM Currency
WHERE (subunit='penny' OR subunit='cent')


--b.2 queries with the intersection operation; use INTERSECT and IN;
--show ids of all countries that have at least a city in the City database
SELECT countryID FROM Country
INTERSECT
SELECT DISTINCT countryID FROM City

--show the language families of English, German and Mongolian
SELECT languageFamily FROM Language
WHERE languageName IN ('English', 'German', 'Mongolian')


--c.2 queries with the difference operation; use EXCEPT and NOT IN;
--show the ids of all countries that don't have a city in the City database
SELECT countryID FROM Country
EXCEPT
SELECT DISTINCT countryID FROM City

--show the countries not ruled by Elizabeth II or Pedro Castillo and order alphabetically by president
SELECT countryName, president FROM Country
WHERE president NOT IN ('Elizabeth II', 'Pedro Castillo')
ORDER BY president


--d.4 queries with INNER JOIN, LEFT JOIN, RIGHT JOIN, and FULL JOIN (one query per operator); one query will join at least 3 tables, while another one will join at least two many-to-many relationships;
--show all the cities alongside the countries they belong to and the country's flag description
--this query joins three tables
SELECT City.cityName, Country.countryName, Flag.description FROM City
INNER JOIN Country ON City.countryID = Country.countryID
INNER JOIN Flag ON City.countryID = Flag.flagID

--show all the countries and all the cities they have
SELECT Country.countryName, City.cityName FROM Country
LEFT JOIN City ON Country.countryID = City.countryID

--show all the countries alongside the description of their flags
SELECT Country.countryName, Flag.description FROM Flag
RIGHT JOIN Country ON Country.countryID = Flag.flagID

--show all the countries alongside their official languages and all the currencies they have used throughout history
--this query joins to m:n relationships
SELECT Country.countryName, Language.languageName, Currency.currencyName
FROM Language
FULL JOIN OfficialLanguage ON OfficialLanguage.languageID = Language.languageID
FULL JOIN Country ON OfficialLanguage.countryID = Country.countryID
FULL JOIN CurrencyHistory ON CurrencyHistory.countryID = OfficialLanguage.countryID
FULL JOIN Currency ON Currency.currencyID = CurrencyHistory.currencyID


--e.2 queries with the IN operator and a subquery in the WHERE clause; in at least one case, the subquery should include a subquery in its own WHERE clause;
--show the first 3 countries that have their flag logged in the Flag database
SELECT TOP 3 countryName FROM Country
where countryID IN (SELECT flagID FROM Flag)

--show all cities that are in countries starting with M
--this query has a subquery with its own WHERE clause
SELECT cityName FROM City
WHERE countryID IN (SELECT countryID from Country WHERE countryName like 'M%')


--f.2 queries with the EXISTS operator and a subquery in the WHERE clause;
--show cities from countries that have a population over 90M and order by city population
SELECT cityName, population FROM City
WHERE EXISTS(SELECT countryName FROM Country WHERE (Country.countryID = City.countryID AND Country.population > 90000000))
ORDER BY population DESC

--show countries that don't have as an official language at least an Indo-European Italic language
SELECT countryName FROM Country
WHERE EXISTS (SELECT languageFamily FROM Language, OfficialLanguage WHERE (OfficialLanguage.languageID = Language.languageID AND OfficialLanguage.countryID = Country.countryID AND NOT languageFamily = 'Indo-European Italic'))


--g. 2 queries with a subquery in the FROM clause;
--show capitals from continents starting with A
SELECT capital, continentName
FROM (SELECT continentName, capital FROM Continent, Country WHERE (Continent.continentName like 'A%' AND Country.continentID = Continent.continentID)) AS CapData

--show the first currency printers from countries with an inflation smaller than 4
SELECT printer, countryName
FROM (SELECT TOP 3 countryName, printer FROM Country, Currency, CurrencyHistory WHERE (CurrencyHistory.currencyID = Currency.currencyID AND CurrencyHistory.countryID = Country.countryID AND Currency.inflation < 4) ORDER BY Currency.inflation) AS CurrData


--h.4 queries with the GROUP BY clause, 3 of which also contain the HAVING clause; 2 of the latter will also have a subquery in the HAVING clause; use the aggregation operators: COUNT, SUM, AVG, MIN, MAX;
--for every country, show the most populous city that also has over 5M inhabitants and the city's population last year
SELECT countryID, MAX(population) AS "cityPopulation", MAX(population) - 1000 AS "cityPopulation1Year"
FROM City
GROUP BY countryID
HAVING MAX(population) > 5000000

--for every continent but Australia, show the number of inhabitants, the average number of inhabitants per country and a prediction for the population after 5 years
SELECT continentID, SUM(population) AS "contPop", AVG(population) AS "avgNoCountryPop", SUM(population) + 1000500 AS "contPop5Years"
FROM Country
GROUP BY continentID
HAVING continentID IN (SELECT continentID FROM Continent WHERE NOT continentName = 'Australia')

--show the minimum number of people that speak a language from every language family and the estimative number of future native speakers
SELECT MIN(nativeSpeakers) AS "minNativeSpeakers", languageFamily, MIN(nativeSpeakers) / 4 AS "futureNativeSpeakers"
FROM Language
GROUP BY languageFamily

--count the flag proportions if its flagID is odd at one point
SELECT COUNT(proportion) AS "proportionCount", proportion
FROM Flag
GROUP BY proportion
HAVING proportion IN (SELECT proportion FROM Flag WHERE flagID % 2 = 1)


--i.4 queries using ANY and ALL to introduce a subquery in the WHERE clause (2 queries per operator); rewrite 2 of them with aggregation operators, and the other 2 with IN / [NOT] IN.
--select all cities from countries with an area of over 800000 km^2
SELECT cityName FROM City
WHERE countryID = ANY(SELECT countryID FROM Country WHERE area > 800000)

--same query, rewritten with IN
SELECT cityName FROM City
WHERE countryID IN (SELECT countryID FROM Country WHERE area > 800000) 

--show countryIDs of countries which have cities that have more inhabitants than entire countries
SELECT DISTINCT countryID FROM City
WHERE population > ANY(SELECT population FROM Country)

--same query, rewritten with aggregator operator
SELECT countryID, MAX(population)
FROM City
GROUP BY countryID
HAVING MAX(population) > (SELECT MIN(population) FROM Country)

--show countries if all entries are countries from Europe, Asia or North America
SELECT countryName FROM Country
WHERE continentID = ALL(SELECT continentID from Continent WHERE continentName IN ('Europe', 'Asia', 'North America'))

--same query, rewritten with NOT IN
SELECT countryName FROM Country
WHERE continentID NOT IN (SELECT continentID from Continent)

--show cities that existed before all the currencies from the Currency database
SELECT cityName FROM City
WHERE foundingYear < ALL(SELECT creationYear FROM Currency)

--same query, rewritten with aggregator operator
SELECT cityName, MAX(foundingYear)
FROM City
GROUP BY cityName
HAVING MAX(foundingYear) < (SELECT MIN(creationYear) FROM Currency)





