USE AdventureWorks2012; 
GO

--Exemplo 1_
SELECT ROW_NUMBER() OVER(ORDER BY SalesYTD DESC) AS Row, 
    FirstName, LastName, ROUND(SalesYTD,2,1) AS "Sales YTD" 
FROM Sales.vSalesPerson
WHERE TerritoryName IS NOT NULL AND SalesYTD <> 0;

--Exemplo 2
WITH OrderedOrders AS
(
    SELECT SalesOrderID, OrderDate,
    ROW_NUMBER() OVER (ORDER BY OrderDate) AS RowNumber
    FROM Sales.SalesOrderHeader 
) 
SELECT SalesOrderID, OrderDate, RowNumber  
FROM OrderedOrders 
WHERE RowNumber BETWEEN 50 AND 60;

select OrderDate from Sales.SalesOrderHeader 

--Exemplo 3
--Mostra as quatro funções de classificação usados na mesma consulta.

USE AdventureWorks2012;
GO
SELECT p.FirstName, p.LastName
    ,ROW_NUMBER() OVER (ORDER BY a.PostalCode) AS "Row Number"
    ,RANK() OVER (ORDER BY a.PostalCode) AS Rank
    ,DENSE_RANK() OVER (ORDER BY a.PostalCode) AS "Dense Rank"
    ,NTILE(4) OVER (ORDER BY a.PostalCode) AS [Ntile]
    ,s.SalesYTD
    ,a.PostalCode
FROM Sales.SalesPerson AS s 
    INNER JOIN Person.Person AS p 
        ON s.BusinessEntityID = p.BusinessEntityID
    INNER JOIN Person.Address AS a 
        ON a.AddressID = p.BusinessEntityID
WHERE TerritoryID IS NOT NULL AND SalesYTD <> 0;

--Exemplo cast, conver
DECLARE @myval decimal (5, 2);
SET @myval = 193.57;
SELECT CAST(CAST(@myval AS varbinary(20)) AS decimal(10,5));
-- Ou, usando CONVERT
SELECT CONVERT(decimal(10,5), CONVERT(varbinary(20), @myval));

-- Usando CAST
USE AdventureWorks2012;
GO
SELECT SUBSTRING(Name, 1, 30) AS ProductName, ListPrice
FROM Production.Product
WHERE CAST(ListPrice AS int) LIKE '4%';
GO

-- Usando CONVERT.
USE AdventureWorks2012;
GO
SELECT SUBSTRING(Name, 1, 30)AS ProductName, ListPrice
FROM Production.Product 
WHERE CONVERT (int, ListPrice)  LIKE '3%';
GO

-- Exibe a data e a hora atuais
SELECT 
   GETDATE() AS "Usando Date Time",
   CAST(GETDATE() AS nvarchar(30)) AS "Usando Cast",
   CONVERT(nvarchar(30), GETDATE(), 126) AS "Usando Convert_ISO8601";
GO

-- Categoria de funçoes que retorna data e hora atuais

SELECT
GETDATE() AS "GETDATE",
CURRENT_TIMESTAMP AS "CURRENT_TIMESTAMP",
GETUTCDATE() AS "GETUTCDATE",
SYSDATETIME() AS "SYSDATETIME",
SYSUTCDATETIME() AS "SYSUTCDATETIME",
SYSDATETIMEOFFSET() AS "SYSDATETIMEOFFSET"

SELECT DATEDIFF(millisecond, getdate(), sysdatetime())


--retorno da coluna na consulta letras Minusculas
	select LOWER (FirstName) from [Person].[Person]

	--Retorna na consulta letras Maiusculas na string
	select UPPER (FirstName) from [Person].[Person] 

	--Retorna o numero de dias vivido
	select datediff(MONTH, 22/09/1989, GETDATE()) as Tempo


USE AdventureWorks2012;
GO
SELECT   ProductNumber, Category =
      CASE ProductLine
         WHEN 'R' THEN 'Road'
         WHEN 'M' THEN 'Mountain'
         WHEN 'T' THEN 'Touring'
         WHEN 'S' THEN 'Other sale items'
         ELSE 'Not for sale'
      END,
   Name
FROM Production.Product
ORDER BY ProductNumber;
GO

--Exemplo com Case
USE AdventureWorks2012;
GO
SELECT   ProductNumber, Name, 'Price Range' = 
      CASE 
         WHEN ListPrice =  0 THEN 'Mfg item - not for resale'
         WHEN ListPrice < 50 THEN 'Under $50'
         WHEN ListPrice >= 50 and ListPrice < 250 THEN 'Under $250'
         WHEN ListPrice >= 250 and ListPrice < 1000 THEN 'Under $1000'
         ELSE 'Over $1000'
      END
FROM Production.Product
ORDER BY ProductNumber;
GO

--Exemplo com CASE
select case year ([SellEndDate]) 
	when 2002 then 'Ano 2'
	when 2007 then 'Ano 7'
	when 2006 then 'Ano 6'
	else 'Ano diferente'
	end as "Tipo de ano"
from [Production].[Product]

use AdventureWorks2012
-- Usando ANY
select Name 
From Production.Product
where ListPrice >= ANY
(Select MAX (ListPrice)
	from Production.Product
	group by ProductSubcategoryID)


	-- Usando LEN

	SELECT LEN(FirstName) AS Length, FirstName, LastName 
FROM Sales.vIndividualCustomer
WHERE CountryRegionName = 'Australia';
GO

-- Usando DATALENGTH
USE AdventureWorks2012;
GO
SELECT length = DATALENGTH(Name), Name
FROM Production.Product
ORDER BY Name;

GO

--Me mostra o ultimo identificador ID gerado na tabela
USE AdventureWorks2012;
GO
SELECT IDENT_CURRENT ('Person.Address') AS Current_Identity;
GO

select * from Person.Address