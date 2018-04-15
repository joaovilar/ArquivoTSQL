use dbPessoa
-- Configurar o sql server antes de exportar para o excel
EXEC sp_configure 'show advanced options',1
GO
reconfigure with override
GO
EXEC sp_configure 'Ad Hoc Distributed Queries',1
GO
reconfigure with override
GO

SELECT * INTO CADASTRO FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0',
 
'Excel 8.0;Database=c:\CAD.xls',
 
'SELECT * FROM [CAD$]')

--Aí para visualizar, é só dar um SELECT na tabela
Select * from funcionario