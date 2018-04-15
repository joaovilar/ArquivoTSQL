CREATE PROCEDURE uspCadastrarCliente
--parametros

@Nome VARCHAR(50),
@DataNascimento Datetime,
@Sexo bit,
@limiteCompra decimal(18,2),
@Telefone1 varchar(20) = null,
@Telefone2 varchar(20) = null,
@Email1 Varchar (200) = null,
@Email2 varchar (200) = null

AS
BEGIN
-- corpo / tratar
	BEGIN TRY
		BEGIN tran 
		-- Executa tudo ou nada
		-- Inserir na tabela de cliente
		insert into tblCliente (idCliente, Nome, DataNascimento,Sexo, LimiteCompra)
		VALUES (@Nome, @DataNascimento,@Sexo, @limiteCompra)

		DECLARE @idClienteNovo as int = @@IDENTITY

		-- inserir na tabela telefone 

		if(@Telefone1 = @Telefone2)
		RAISERROR ('Nao é possivel Cadastrar dois numeros iguais.',14,1)

		if (@Telefone1 IS NOT NULL)
		BEGIN 
			insert into tblClienteTelefone (idCliente, Telefone)
			values (@idClienteNovo, @Telefone1)
		END

		if (@Telefone2 IS NOT NULL)
		BEGIN 
			insert into tblClienteTelefone (idCliente, Telefone)
			values (@idClienteNovo, @Telefone2)
		END

			-- inserir na tabela de email
		if (@Email1 IS NOT NULL)
		BEGIN 
			insert into tblClienteEmail (idCliente, Email)
			values (@idClienteNovo, @Email1)
		END

		if (@Email2 IS NOT NULL)
		BEGIN 
			insert into tblClienteEmail (idCliente, Email)
			values (@idClienteNovo, @Email2)
		END

		select @idClienteNovo as retorno

		COMMIT tran
	END TRY 

	BEGIN CATCH
	ROLLBACK tran
		select ERROR_MESSAGE () as retorno

	END CATCH

END