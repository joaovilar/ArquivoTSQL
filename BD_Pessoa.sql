
use dbPessoa;

-- Inner Join
select * from Funcionario
inner join tbCargo on Funcionario.CodFunc = tbCargo.idCargo;

-- Inserir campos
insert into Funcionario (NomeFunc,DataNasc, Cpf, Telefone) values ('Mateus','12-08-2003','9863527581','6193226588')

-- ALterar campo especifico
UPDATE Funcionario SET NomeFunc = 'Lucas' where NomeFunc = 'Marcos'

-- Selecionar toda a tabela
select * from tbCargo



