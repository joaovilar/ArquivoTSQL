use AdventureWorks2012

-- Retorna a diferença em cotas de vendas para um funcionário específico nos anos anteriores

SELECT BusinessEntityID, YEAR(QuotaDate) AS SalesYear, SalesQuota AS CurrentQuota, 
       LAG(SalesQuota, 1,0) OVER (ORDER BY YEAR(QuotaDate)) AS PreviousQuota
FROM Sales.SalesPersonQuotaHistory
WHERE BusinessEntityID = 275 and YEAR(QuotaDate) IN ('2005','2006');


select TerritoryName, BusinessEntityID, SalesYTD,
lag (SalesYTD, 1, 0) over (partition by TerritoryName order by SalesYTD desc ) as PrevRepSales
from Sales.vSalesPerson
WHERE TerritoryName IN (N'Northwest', N'Canada') 
ORDER BY TerritoryName;

SELECT STUFF('THAMIEL',1,0,'THIAGO ' )
SELECT STUFF('THIAGO THAMIEL',1,7,'SILVA ' )
SELECT STUFF('THIAGO THAMIEL',7,1,' SILVA ' )
SELECT STUFF('THIAGO THAMIEL ',15,0, ' DA SILVA' )

SELECT PARSE('1/2/2012' AS DATE USING 'en-BR')


DECLARE @dinheiro1 smallmoney = 3148.29,
        @dinheiro2    money = 3148.29;
SELECT  CAST(@dinheiro1 AS varchar) AS 'SMALLMONEY varchar',
        CAST(@dinheiro2 AS decimal)    AS 'MONEY decimal';


--vamos declarar uma variavel do tipo money
DECLARE @valor smallmoney;
-- vamos atribuir o valor 34.654,78 a variavel
SET @valor = 34654.79;
-- vamos exibir o valor da variavel
SELECT @valor AS valor;