--- visualisering 1:

SELECT
	pc.Name AS CategoryName,
	COUNT(DISTINCT p.ProductID) AS ProductCount
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
GROUP BY pc.Name
ORDER BY ProductCount DESC

--- visualisering 2:
SELECT
	pc.Name AS CategoryName,
	SUM(sod.LineTotal) AS TotalSales
FROM Production.ProductCategory pc
INNER JOIN Production.ProductSubcategory psc ON pc.ProductCategoryID = psc.ProductCategoryID
INNER JOIN Production.Product p ON psc.ProductSubcategoryID = p.ProductSubcategoryID
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY pc.Name
ORDER BY TotalSales DESC

--- visualisering 3:
SELECT
	YEAR(OrderDate) AS SalesYear,
	MONTH(OrderDate) AS SalesMonth,
	SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY
	YEAR(OrderDate),
	MONTH(OrderDate)
ORDER BY
	YEAR(OrderDate) ASC,
	MONTH(OrderDate) ASC

--- visualisering 4:
SELECT
	YEAR(OrderDate) AS SalesYear,
	COUNT(DISTINCT SalesOrderID) AS AntalOrdrar,
	SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY
	YEAR(OrderDate)
ORDER BY
	YEAR(OrderDate) ASC

--- visualisering 5:
SELECT TOP 10
	p.Name AS Namn,
	SUM(sod.LineTotal) AS TotalSales
FROM Production.Product p
INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
GROUP BY p.Name
ORDER BY TotalSales DESC

--- visualisering 6:
SELECT
	COUNT(DISTINCT c.CustomerID) AS CustomerCount,
	st.Name AS Region,
	SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
INNER JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
INNER JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name
ORDER BY TotalSales DESC

--- visualisering 7:
SELECT
    st.Name AS Region,
    CASE 
        WHEN c.StoreID IS NOT NULL THEN 'Store'
		ELSE 'Individual'
    END AS CustomerType,
    SUM(soh.TotalDue) / COUNT(soh.SalesOrderID) AS OrderValue
FROM Sales.SalesOrderHeader soh
LEFT JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
INNER JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY
    st.Name,
    CASE 
        WHEN c.StoreID IS NOT NULL THEN 'Store'
		ELSE 'Individual'
    END
ORDER BY
    OrderValue DESC

--- Djupanalys alternativ: