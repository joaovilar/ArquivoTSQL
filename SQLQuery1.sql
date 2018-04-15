--select distinct persontype,
--count(businessEntityID) OVer (partition by persontype) as x 
--from person.person
----group by persontype

--select distinct persontype,
--count(businessEntityID) --OVer (partition by persontype) as x 
--from person.person
--group by persontype

select	tp,
		vlr,
		rank() over (order by vlr desc) as [rank] 
from (
		select distinct persontype as tp,
		count(businessEntityID) as vlr--OVer (partition by persontype) as x 
		from person.person
		group by persontype

		union all

		select 'AR', 18484

		union all

		select 'JR', 753
	) as teste


	use AdventureWorks2012

	select [PersonType]
	from [Person].[PersonPhone]
	inner join [Person].[Person]
	on [Person].[PersonPhone].BusinessEntityID = Person.[BusinessEntityID]
	where PersonType like '_N%'

	union all
	select 'EM'

	