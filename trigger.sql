

-- Criando uma Trigger (disparo,gatilho)
create Trigger utrEnviarEmailAlunoNovo

on tblAluno

for insert
as
begin
	declare 
	@IdAluno int,
	@Nome varchar (100);

	select
	@IdAluno = IdAluno,
	@Nome = Nome

	 From
	 inserted
	 insert into EnviarEmail
	 (
	 Destinatario,
	 Assunto,
	 Corpo
	 )
	 values
	 (
	 'j.vilar12@gmail.com',
	 'Novo Aluno cadastrado',
	 'Foi Cadastrado um novo email'+ cast(@IdAluno as varchar) + '@Nome' + @Nome
	 )
 end


 -- INNER JOIN
 select * from EnviarEmail
inner join tblAluno on EnviarEmail.IdMail = tblAluno.idAluno

--INSERIR

insert into EnviarEmail (Destinatario, Assunto, Corpo) 
VALUES ('j.vilar_@hotmail.com','teste','estamos apenas testando');

-- Consultando Toda a tabela
select * from EnviarEmail;