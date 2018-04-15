
CREATE table dim_data
(
id_dim_data int not null,
data date,
ano_mes_dia char(10),
ano int,
mes int,
dia int,
ano_mes char(7),
ano_mes_nome varchar(15),
ano_mes_nome_abrev char(8),
anomes int,
mes_nome varchar(9),
mes_nome_abrev varchar(3),
dia_da_semana int,
dia_da_semana_nome varchar(7),
dia_do_ano int,
bimestre int,
trimestre int,
semestre int,
semana_mes int,
semana_ano int,
ano_bimestre char(7),
ano_trimestre char(7),
ano_semestre char(7),
dia_util int,
final_semana int,
data_por_extenso varchar(50)
)

DECLARE @dataini as date
declare @datafin as date 

declare @id_dim_data int,
		@dia as int,
		@dia_da_semana as int,
		@dia_da_semana_nome  as varchar(7),
		@ano as int,
		@mes as int,
		@mes_nome as varchar(9),
		@mes_nome_abrev as varchar(3),
		@bimestre as int,
		@trimestre as int,
		@semestre as int,
		@dia_util as int,
		@final_semana as int,
		@semana_mes as int,
		@semana_ano as int

set @dataini ='2000-01-01'
set @datafin ='2010-12-31'
set @id_dim_data = 0

while @dataini <= @datafin
begin

	set @id_dim_data = @id_dim_data + 1
	set @dia = day(@dataini)
	set @dia_da_semana = datepart(weekday,@dataini)
	set @ano = year(@dataini)
	set @mes = month(@dataini)

	set @dia_da_semana_nome = case
	when @dia_da_semana =1 then 'domingo'
	when @dia_da_semana =2 then 'segunda'
	when @dia_da_semana =3 then 'terça'
	when @dia_da_semana =4 then 'quarta'
	when @dia_da_semana =5 then 'quinta'
	when @dia_da_semana =6 then 'sexta'
	when @dia_da_semana =7 then 'sábado' end

	set @mes_nome = case 
	when @mes = 1 then 'janeiro'
	when @mes = 2 then 'fevereiro'
	when @mes = 3 then 'março'
	when @mes = 4 then 'abril'
	when @mes = 5 then 'maio'
	when @mes = 6 then 'junho'
	when @mes = 7 then 'julho'
	when @mes = 8 then 'agosto'
	when @mes = 9 then 'setembro'
	when @mes = 10 then 'outubro'
	when @mes = 11 then 'novembro'
	when @mes = 12 then 'dezembro' end

	set @mes_nome_abrev = case 
	when @mes = 1 then 'jan'
	when @mes = 2 then 'fev'
	when @mes = 3 then 'mar'
	when @mes = 4 then 'abr'
	when @mes = 5 then 'mai'
	when @mes = 6 then 'jun'
	when @mes = 7 then 'jul'
	when @mes = 8 then 'ago'
	when @mes = 9 then 'set'
	when @mes = 10 then 'out'
	when @mes = 11 then 'nov'
	when @mes = 12 then 'dez' end

	set @bimestre = case 
	when @mes <= 2 then 1
	when @mes <= 4 then 2
	when @mes <= 6 then 3
	when @mes <= 8 then 4
	when @mes <= 10 then 5
	when @mes <= 12 then 6 end

	set @trimestre = case 
	when @mes <= 3 then 1
	when @mes <= 6 then 2
	when @mes <= 9 then 3
	when @mes <= 12 then 4 end

	set @semestre = case 
	when @mes <= 6 then 1
	when @mes <= 12 then 2 end

	select @semana_mes = case
	when @dia < 8 then 1
	when @dia < 15 then 2
	when @dia < 22 then 3
	when @dia < 29 then 4
	when @dia < 32 then 5 end

	set @semana_ano = datepart(wk,@dataini)

	set @dia_util = 1
	set @final_semana = 0

	if @dia_da_semana = 1 or @dia_da_semana = 7 
		set @final_semana = 1

	if @final_semana = 1
		set @dia_util = 0
	else if @mes = 1 and @dia = 1 --confraternização universal
		set @dia_util = 0
	else if @mes = 4 and @dia = 21 --tiradentes
		set @dia_util = 0
	else if @mes = 5 and @dia = 1 --trabalho
		set @dia_util = 0
	else if @mes = 9 and @dia = 7 --independência
		set @dia_util = 0
	else if @mes = 10 and @dia = 12 --nossa sra. aparecida
		set @dia_util = 0
	else if @mes = 11 and @dia = 2 --finados
		set @dia_util = 0
	else if @mes = 11 and @dia = 15 --proclamação da república
		set @dia_util = 0
	else if @mes = 12 and @dia = 25 --natal
		set @dia_util = 0

	/*
		feriados sem dia fixo devem ser atualizados manualmente
		ex:
		carnaval 
		paixão de cristo
		corpus christi
	*/

	insert into dim_data
	select 
	@id_dim_data as id_dim_data,
	@dataini as data,
	convert(char(10),@dataini,120) as ano_mes_dia,
	@ano as ano,
	@mes as mes,
	@dia as dia,
	convert(char(7),@dataini,120) as ano_mes,
	cast(@ano as char(4)) + '-' + @mes_nome as ano_mes_nome,
	cast(@ano as char(4)) + '-' + @mes_nome_abrev as ano_mes_nome_abrev,
	convert(char(6),@dataini,112) as anomes,
	@mes_nome as mes_nome,
	@mes_nome_abrev as mes_nome_abrev,
	@dia_da_semana as dia_da_semana,
	@dia_da_semana_nome as dia_da_semana_nome,
	datepart(dayofyear,@dataini) as dia_do_ano,
	@bimestre as bimestre,
	@trimestre as trimestre,
	@semestre as semestre,
	@semana_mes as semana_mes,
	@semana_ano as semana_ano,
	cast(@ano as varchar) + '-0' + cast(@bimestre as varchar) as ano_bimestre,
	cast(@ano as varchar) + '-0' + cast(@trimestre as varchar) as ano_trimestre,
	cast(@ano as varchar) + '-0' + cast(@semestre as varchar) as ano_semestre,
	@dia_util as dia_util,
	@final_semana as final_semana,
	lower(@dia_da_semana_nome + ', dia ' + cast(@dia as varchar) + ' de ' + @mes_nome + ' de ' + cast(@ano as varchar)) as data_por_extenso

	set @dataini = dateadd(day,1,@dataini)
end