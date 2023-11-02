-- check that the engine handles existential queries in disjunctions

-- result header
select case when queryresult = 11 then 'T' else 'F' end as result
from (

-- the query itself
select sum(x) as queryresult
from (
	SELECT 1 AS x
	UNION ALL
	SELECT 2
	UNION ALL
	SELECT 4
	UNION ALL
	SELECT 8
	UNION ALL
	SELECT NULL) AS s
where exists(select * from (
	SELECT 2 AS y
	UNION ALL
	SELECT 8) AS t where x=y) or (x<3)

) test
