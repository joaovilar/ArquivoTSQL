USE BD_Cadastro

CREATE TABLE Cliente(
IdCliente int Identity,
Nome varchar (50) not null,
Endereco Varchar (50) not null,
Cep Varchar (20)not null,
Bairro Varchar (20) null ,
Cidade Varchar (20) not null,
Uf char (2) not null,
Telefone varchar (20) null
)

-- PROCEDURE DE INSERT
CREATE PROCEDURE spInserirCliente

@Nome AS VARCHAR (50),
@Endereco AS VARCHAR (50),
@Cep AS VARCHAR (20),
@Bairro AS VARCHAR (20),
@Cidade AS VARCHAR (20),
@Uf AS CHAR (2),
@Telefone AS VARCHAR (20)

AS
BEGIN
INSERT INTO Cliente (Nome,Endereco,Cep,Bairro,Cidade,Uf,Telefone)
VALUES (@Nome, @Endereco, @Cep, @Bairro, @Cidade, @Uf, @Telefone)
END

--PROCEDURE DE UPDATE
CREATE PROCEDURE spAlterarCliente
@IdCliente AS INT,
@Nome AS VARCHAR (50),
@Endereco AS VARCHAR (50),
@Cep AS VARCHAR (20),
@Bairro AS VARCHAR (20),
@Cidade AS VARCHAR (20),
@Uf AS CHAR (2),
@Telefone AS VARCHAR (20)

AS
BEGIN
UPDATE Cliente set
@Nome=Nome,
@Endereco=Endereco,
@Cep=Cep,
@Bairro=Bairro,
@Cidade=Cidade,
@Uf=Uf,
@Telefone=Telefone
WHERE @IdCliente=@IdCliente
END

--PROCEDURE DE DELETE

CREATE PROCEDURE spDeletarCliente
@IdCliente AS INT

AS
BEGIN

DELETE from Cliente where IdCliente = @IdCliente 

END

-- PROCEDURE DE SELECT

CREATE PROCEDURE spSelecionarCliente
@IdCliente AS INT

AS
BEGIN

SELECT * FROM Cliente 
WHERE @IdCliente = IdCliente

END




