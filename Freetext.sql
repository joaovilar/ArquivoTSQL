use AdventureWorks2012

SELECT title 
FROM Production.Document
WHERE FREETEXT (Document, 'Vital safety components')


SELECT Name, Weight, Color
FROM Production.Product
where Weight < 10.00 or Color is null
order by Name