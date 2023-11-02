-- check that decimal number behave sane

-- result header
select case when s*10000000000000000 = 100000000000000 then 'T' else 'F' end as result
from (


-- the query itself
select sum(x)/10 as s from (
	SELECT 0.2 AS x
	UNION ALL
	SELECT 0.2
	UNION ALL
	SELECT -0.3) AS s


) test
