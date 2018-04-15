
use [Northwind]
set language portuguese

select [RequiredDate] from [dbo].[Orders]

SELECT DATEDIFF ( YEAR, '1989/09/22' , GETDATE())


CREATE TABLE TbPessoa (
IdPessoa INT IDENTITY,
Nome VARCHAR (50) NOT NULL,
DataNascimento DATE NOT NULL
)
INSERT INTO TbPessoa VALUES	
							('Carlos Eduardo', '1986/07/7'),
							('Monica Ferraz', '1988/10/2')

-- select Retornando os dados
SELECT Nome, DataNascimento,
DATEDIFF (YEAR,DataNascimento,GETDATE()) AS "Idade Atual",
DATEDIFF (MONTH,DataNascimento,GETDATE()) AS "Meses vividos ate hoje",
DATEDIFF (DAY,DataNascimento,GETDATE()) AS "Dias vividos ate hoje",
DATEDIFF (YEAR,DataNascimento,GETDATE()) + 10 AS "Idade daqui a 10 anos"
FROM TbPessoa


SELECT * FROM TbPessoa


--Converte a data atual para caracter e mostra no formato DD/MM/AAAA

SELECT CONVERT(CHAR,GETDATE(), 10)


-- Converte a data atual para caracter e mostra no formato AAAA.MM.DD
SELECT CONVERT(CHAR,GETDATE(),102)


--Somente os dois últimos dígitos do ano */
SELECT CONVERT (CHAR,GETDATE(),2)



--Retorna somente o mês da data atual
SELECT DATEPART(MONTH,GETDATE()) Mês

-- Retorna somente o ano
SELECT DATEPART(YEAR,GETDATE()) Ano

-- Retorna somente o dia do mês atual
SELECT DATEPART(DAY,GETDATE()) Dia

/*Retorna somente o parâmentro definido, antes da data
nesse caso o mês */
SELECT DATEPART(MONTH,'22-09-1989') "Mês data definida"




SELECT DATEDIFF (YEAR, '02/11/1962' , '20/12/2015' )

SELECT * FROM TbPessoa
WHERE MONTH(DataNascimento) = 2 AND DAY(DataNascimento) = 22

