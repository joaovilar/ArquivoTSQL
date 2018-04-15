use SQLTeste


SELECT * FROM Tb_Pessoa

--Adiciona uma nova coluna a tabela chamada "Endereco"
ALTER TABLE Tb_Pessoa ADD CPF VARCHAR (20) NULL

--Altera o tipo de dado de uma coluna
ALTER TABLE Tb_Pessoa ALTER COLUMN CPF VARCHAR (14) NOT NULL 

-- Adiciona uma constraint para a coluna
ALTER TABLE Tb_Pessoa ADD CONSTRAINT CPF UNIQUE (Pessoa_Id)

-- Apagando uma constraint de um campo na tabela
ALTER TABLE Tb_Pessoa DROP CONSTRAINT CPF

-- Apaga uma coluna da tabela
ALTER TABLE Tb_Pessoa DROP COLUMN CPF

-- Habilita todas as constraints
ALTER TABLE Tb_Pessoa CHECK CONSTRAINT ALL

-- Desabilita todas as constraints
ALTER TABLE Tb_Pessoa NOCHECK CONSTRAINT ALL

/*
Se a coluna contiver restrições ou outras dependências, uma mensagem de erro será retornada.
Resolva o erro excluindo as restrições referenciadas.