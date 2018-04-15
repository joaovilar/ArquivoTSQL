select distinct persontype as tp,
				businessEntityID as vlr,--OVer (partition by persontype) as x 
				ROW_NUMBER() Over (PARTITION BY persontype order by persontype)
FROM person.person