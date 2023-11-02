-- check that full outer joins are decorrelated correctly

-- result header
select case when count(x)=8 then 'T' else 'F' end as result
from (
(
	SELECT 1 AS a, CAST(NULL AS INTEGER) AS b, 2 AS c
	UNION ALL
	SELECT 1,NULL,3
	UNION ALL
	SELECT 2,1,NULL
	UNION ALL
	SELECT 2,NULL,2
	UNION ALL
	SELECT 2,NULL,3
	UNION ALL
	SELECT 3,1,NULL
	UNION ALL
	SELECT 3,2,2
	UNION ALL
	SELECT 3,NULL,3) AS expected
left outer join (


-- the query itself
select * from (
	SELECT 1 AS x
	UNION ALL
	SELECT 2
	UNION ALL
	SELECT 3) AS s,
    lateral (
    	select * from (
    		select * from (SELECT 1 AS y UNION ALL SELECT 2) AS a where y<x) a full outer join (SELECT 2 AS z UNION ALL SELECT 3) b(z) on y=z) t


) t on a is not distinct from x and b is not distinct from y and c is not distinct from z
) test
