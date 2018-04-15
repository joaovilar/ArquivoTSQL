
-- Criando uma banco de dados
CREATE DATABASE DB_Pessoa

-- Criando uma tabela
CREATE TABLE Funcionario(
CodFunc INT IDENTITY PRIMARY KEY,
NomeFunc VARCHAR (100) NOT NULL,
DataNasc DATETIME,
Cpf CHAR (14) NOT NULL,
Telefone CHAR (14)
);



--Adiciona uma nova coluna a tabela chamada "Endereco"
ALTER TABLE Funcionario ADD Idade INT NOT NULL

--Altera o tipo de dado de uma coluna
ALTER TABLE Funcionario ALTER COLUMN DataNasc DATE NOT NULL

-- Adiciona uma constraint para a coluna
ALTER TABLE Funcionario ADD CONSTRAINT CPF UNIQUE

-- Apagando uma constraint de um campo na tabela
ALTER TABLE Funcionario DROP CONSTRAINT CPF

-- Apaga uma coluna da tabela
ALTER TABLE Funcionario DROP COLUMN CPF

ALTER TABLE Funcionario NOCHECK CONSTRAINT ALL


USE dbPessoa;

CREATE TABLE TB_Cargo(
idCargo INT IDENTITY PRIMARY KEY,
NomeCargo VARCHAR (50) NOT NULL,
salario DECIMAL (10,2)
);

-- ALtera o nome "tabela antiga para um novo nome --!
EXEC sp_rename 'dbPessoa', 'DB_Pessoa','DATABASE'



INSERT INTO TB_Cargo (NomeCargo,salario) VALUES ('Engenheiro de Software', '6000');

SELECT * FROM Funcionario

DROP TABLE Funcionario

