--TAIWO AYODEJI PORTFOLIO



--What are the top 10 selling products by sales amount?
SELECT TOP 10 PRP.Name,FORMAT (SUM(SS.LineTotal) ,'00.00') TOTAL_SALES
FROM SALES.SalesOrderDetail SS
JOIN Production.Product PRP ON SS.ProductID = PRP.ProductID
GROUP BY PRP.Name
ORDER BY SUM(SS.LineTotal) DESC


--What is the total sales amount for each product category?
SELECT PP.Name, FORMAT(SUM(SS.LineTotal), '00.00') TOTAL_SALES_CAT
FROM Production.ProductSubcategory PS
JOIN Production.ProductCategory PP ON PS.ProductCategoryID = PP.ProductCategoryID
JOIN Production.Product PRP ON PS.ProductSubcategoryID = PRP.ProductSubcategoryID
JOIN Sales.SalesOrderDetail SS ON SS.ProductID = PRP.ProductID
GROUP BY PP.Name
ORDER BY SUM(SS.LineTotal) DESC


--Which product categories have the highest and lowest average sales prices?
SELECT PC.Name, avg(ss.UnitPrice) AVG_PRICE
FROM SALES.SalesOrderDetail SS
JOIN Production.Product PP ON SS.ProductID = PP.ProductID
JOIN Production.ProductSubcategory PS ON PP.ProductSubcategoryID = PS.ProductSubcategoryID
JOIN Production.ProductCategory PC ON PS.ProductCategoryID = PC.ProductCategoryID
group by PC.Name
ORDER BY avg(ss.UnitPrice) DESC


--How many products are in each product subcategory?
SELECT PS.Name, COUNT(PP.ProductID) NO_OF_PRODUCTS
FROM Production.Product PP
JOIN Production.ProductSubcategory PS ON PP.ProductSubcategoryID = PS.ProductSubcategoryID
GROUP BY PS.Name
ORDER BY COUNT(PP.ProductID) DESC


--What is the total sales amount by sales territory?
SELECT ST.Name, FORMAT(SUM(SD.LineTotal),'00.00') TOTAL_SALES
FROM SALES.SalesOrderDetail SD
JOIN Sales.SalesOrderHeader SH ON SD.SalesOrderID = SH.SalesOrderID
JOIN Sales.SalesTerritory ST ON SH.TerritoryID = ST.TerritoryID
GROUP BY ST.Name
ORDER BY  SUM(SD.LineTotal) DESC


--What is the average age of employees in each department?
SELECT HD.NAME, AVG(DATEDIFF(year,HE.BirthDate,GETDATE())) AVG_AGE
FROM HumanResources.Employee HE
JOIN HumanResources.EmployeeDepartmentHistory EDH ON HE.BusinessEntityID = EDH.BusinessEntityID
JOIN HumanResources.Department HD ON EDH.DepartmentID = HD.DepartmentID
GROUP BY HD.NAME


--How many employees are working in each region?
SELECT PC.Name, COUNT(HE.Businessentityid) NO_OF_EMP
FROM HumanResources.Employee HE
JOIN Person.BusinessEntityAddress PB ON HE.BusinessEntityID = PB.BusinessEntityID
JOIN Person.Address PA ON PB.AddressID=PA.AddressID
JOIN Person.StateProvince PS ON PA.StateProvinceID=PS.StateProvinceID
JOIN Person.CountryRegion PC ON PS.CountryRegionCode=PC.CountryRegionCode
GROUP BY PC.Name

--What is the turnover rate by department?
SELECT HD.Name, FORMAT(COUNT(CASE WHEN EndDate is not null then 1 End)*1.0/count(*),'0.000') TURNOVER_RATE
FROM HumanResources.Employee HE
join HumanResources.EmployeeDepartmentHistory EDH on HE.BusinessEntityID=EDH.BusinessEntityID
JOIN HumanResources.Department HD ON EDH.DepartmentID=HD.DepartmentID
GROUP BY HD.Name


--Number of Employees Hired Each Year
SELECT YEAR(HIREDATE) YEAR , COUNT(*) NO_OF_EMPLOYEES_HIRED
FROM HumanResources.Employee
GROUP BY YEAR(HIREDATE)
ORDER BY YEAR(HIREDATE) 


--How many people are there in each contact type (e.g., employee, customer, vendor)?
SELECT PersonType, COUNT(PersonType) Total_No
FROM Person.Person
group by PersonType


--What is the employee retention rate by department?
SELECT HD.Name, FORMAT(COUNT(CASE WHEN EndDate is null then 1 End)*1.0/count(*),'0.000') RETENTION_RATE
FROM HumanResources.Employee HE
join HumanResources.EmployeeDepartmentHistory EDH on HE.BusinessEntityID=EDH.BusinessEntityID
JOIN HumanResources.Department HD ON EDH.DepartmentID=HD.DepartmentID
GROUP BY HD.Name



--Who are the top 10 customers by sales amount?
select TOP 10 SOH.CustomerID,PP.Firstname, PP.LastName, format(SUM(SOD.LineTotal),'00.00') Total_Sales_Amount
from Sales.SalesOrderDetail SOD
JOIN Sales.SalesOrderHeader SOH ON SOD.SalesOrderID=SOH.SalesOrderID
JOIN SALES.Customer SC ON SOH.CustomerID=SC.CustomerID
JOIN Person.Person PP ON SC.PersonID=PP.BusinessEntityID
group by SOH.CustomerID, PP.Firstname,PP.LastName
order by SUM(SOD.LineTotal) desc


--What is the trend in sales over the last 15 years?
SELECT YEAR(OrderDate) YEAR, FORMAT(SUM(TOTALDUE),'00.00') TOTAL_SALES
FROM Sales.SalesOrderHeader
WHERE  OrderDate >= DATEADD(YEAR, -15, GETDATE())
GROUP BY YEAR(OrderDate)
ORDER BY  SUM(TOTALDUE)


--How many orders were placed online versus in-store?
SELECT COUNT(CASE WHEN Onlineorderflag=1 then 1 END) Online, COUNT(CASE WHEN Onlineorderflag=0 then 0 END) 'In-Store'
FROM SALES.SalesOrderHeader


--How many orders have been placed by each customer?
SELECT SC.CustomerID, COUNT(SOH.SalesOrderID)
FROM Sales.SalesOrderHeader SOH
JOIN Sales.Customer SC ON SOH.CustomerID=SC.CustomerID
GROUP BY SC.CustomerID
ORDER BY COUNT(SOH.SalesOrderID) DESC



