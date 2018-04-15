
/*
Criado por Joao Vilar
Date: 25-11-2017
Brasília - DF
*/

IF OBJECT_ID('tempdb..#Person') IS NOT NULL 
BEGIN
     DROP TABLE #Person
END
-- Converte dos dasos em tabela e insere em uma tabela temporária
 DECLARE @JSON NVARCHAR(MAX) = '[
 {"id" : 2,"firstName": "João", "lastName": "Braga", "age": 28, "dateOfBirth": "2019-09-22T12:00:00", "Sexo": "M"},
 {"id" : 3,"firstName": "Eduarda", "lastName": "Oliveira", "age": 26, "dateOfBirth": "2019-02-18T12:00:00","Sexo":"F"},
 {"id" : 4,"firstName": "Daniele", "lastName": "Montes", "age": 20, "dateOfBirth": "2019-08-02T12:00:00","Sexo":"F"},
  {"id" : 5,"firstName": "Lucas", "lastName": "Pereira", "age": 23, "dateOfBirth": "2019-06-11T12:00:00","Sexo":"M"}
 ]';
 -- Verifica se o json é válido
  IF((SELECT ISJSON(@JSON)) = 1)
  SELECT 'JSON VÁLIDO';
ELSE
  SELECT 'JSON INVÁLIDO';
 
 SELECT * 
 INTO #PERSON
 FROM OPENJSON(@json)
 WITH (id int,
 firstName nvarchar(50), 
 lastName nvarchar(50), 
 age int,
 dateOfBirth datetime2,
 Sexo char(2))

 SELECT * FROM #PERSON


 -- Sem colchete
 SELECT * FROM #PERSON FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
 -- Com colchete
 SELECT * FROM #PERSON FOR JSON PATH 



-- Atualiza 
  DECLARE @JSON NVARCHAR(MAX) = '[
 {"id" : 2,"firstName": "João", "lastName": "Braga", "age": 28, "dateOfBirth": "2019-09-22T12:00:00", "Sexo": "M"},
 {"id" : 3,"firstName": "Eduarda", "lastName": "Oliveira", "age": 26, "dateOfBirth": "2019-02-18T12:00:00","Sexo":null},
 {"id" : 4,"firstName": "Daniele", "lastName": "Montes", "age": 20, "dateOfBirth": "2019-08-02T12:00:00","Sexo":null},
  {"id" : 5,"firstName": "Lucas", "lastName": "Pereira", "age": 23, "dateOfBirth": "2019-06-11T12:00:00","Sexo":null}
 ]';
 UPDATE #Person
 SET firstName = json.firstname,
 lastName = json.lastname,
 age = json.age,
 dateOfBirth = json.dateOfBirth,
 Sexo = json.sexo
 FROM OPENJSON(@json)
 WITH (id int,
       firstName nvarchar(50), lastName nvarchar(50), 
       isAlive bit, age int,
       dateOfBirth datetime2, spouse nvarchar(50),
	   Sexo char(2)) AS json
 WHERE #person.id = json.id

 SELECT * FROM #PERSON


 --======== Inserindo Registros JSON em uma variável================

 DECLARE @json AS NVARCHAR(MAX)
 SELECT @json = BulkColumn from OPENROWSET (BULK 'D:\Person.json', SINGLE_CLOB) as j
 SELECT @json

 
 --Inserindo os Registros JSON em uma tabela temporária
 SELECT BulkColumn
 INTO #temp 
 FROM OPENROWSET (BULK 'D:\Person.json', SINGLE_CLOB) as j

 SELECT * FROM #temp 



-- Importando de um diretório e montando em estrutura de tabelas e linhas

SELECT t.*
 FROM OPENROWSET (BULK 'D:\FileJSON\Person.json', SINGLE_CLOB) as j
 CROSS APPLY OPENJSON(BulkColumn)
 WITH( id int,
 firstName nvarchar(50), 
 lastName nvarchar(50), 
 age int,
 dateOfBirth datetime2,
 Sexo char(2)) AS t

