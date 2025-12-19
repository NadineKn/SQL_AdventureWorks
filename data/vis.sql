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
	SUM(sod.OrderQty * sod.UnitPrice * (1 - sod.UnitPriceDiscount)) AS TotalSales
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


--- visualisering 6:


--- visualisering 7:


--- Djupanalys alternativ: