-- check that that quantified expressions return NULL values as needed

-- result header
select (r1=5) and (r2=40) as result
from (

-- the query itself
select sum(case when m then i else 0 end) as r1, sum(case when m is null then i else 0 end) r2
from (
select i, x=some(select a from (
	SELECT 1 AS a, 1 AS b
	UNION ALL
	SELECT 2, 2
	UNION ALL
	SELECT 3, 3
	UNION ALL
	SELECT 4, 4
	UNION ALL
	SELECT NULL, 5) AS t where b<y) as m
from (
	SELECT 1 AS x, 4 AS y, 1 AS i
	UNION ALL
	SELECT 2,2,2
	UNION ALL
	SELECT 4,6,4
	UNION ALL
	SELECT 8,8,8
	UNION ALL
	SELECT NULL,0,16
	UNION ALL
	SELECT NULL,8,32) AS s
) s

) test
