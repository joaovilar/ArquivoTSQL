CREATE TABLE CLIENTES
 ( 
 ID_CLIENTE INT IDENTITY,
 NOME VARCHAR (50) NOT NULL,
 CPF CHAR (14) NOT NULL
 )

INSERT INTO CLIENTES (NOME,CPF) 
VALUES	('Fabio Martins','402.205.672-04'),
		('Juliano pereira','8.458.962-04'),
		('Mario Anuncia��o','28.458.962-04'),
		('Jessica das Neves','270.442-34'),
		('Felipe Oliveira','048.839.002-82'),
		('Joao Vilar','12345');



DECLARE @TAM char (14)
    SET @TAM=14 /*Define o tamanho m�ximo de caracteres que dever� ser gerado */
-------------------------------------------------------------------------------
BEGIN
     SELECT
         NOME,
         CPF AS 'CPF Orginal',
         REPLICATE(0, @TAM- LEN(REPLACE(REPLACE(CPF,'.',''),'-','')))+
        (REPLACE(REPLACE(CPF,'.',''),'-','')) AS CodigoModificado

      FROM CLIENTES  
END


         /* Note que no c�digo acima, primeiro descobrimos o numero de vezes que
o zero ser� repetido atrav�s o c�lculo @TAN-len(), que calcula o valor 15 menos o
tamanho do n�mero de  CPF gravado no campo j� eliminando os pontos e tra�os. E em seguida, concatenamos com o resultado tratado do campo CPF */

SELECT REPLICATE ('A', 3)

SELECT REPLACE ('Aula de Portugu�s', 'Portugu�s', 'Matematica') as Replace

SELECT REPLICATE('9','1') + '88776655' as Replicate

SELECT REPLICATE('0',11-LEN(1234) )+'1234'

SELECT REPLACE ('www.teste.net', 'gov', 'com')