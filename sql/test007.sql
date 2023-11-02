-- check that multi set operations are supported

-- result header
select case when (count(*) = 3) and (count(x) = 3) then 'T' else 'F' end as result
from (
(
	SELECT 2 AS a, 2 AS b
	UNION ALL
	SELECT 3,1
	UNION ALL
	SELECT 4,1) AS expected
full outer join (


-- the query itself
select x, count(*) as c
from ((select * from (
	SELECT 1 AS x
	UNION ALL
	SELECT 2
	UNION ALL
	SELECT 2
	UNION ALL
	SELECT 3
	UNION ALL
	SELECT 3
	UNION ALL
	SELECT 3
	UNION ALL
	SELECT 4
	UNION ALL
	SELECT 4
	UNION ALL
	SELECT 4
	UNION ALL
	SELECT 4) AS s
    except all select * from (
    	SELECT 1 AS x
    	UNION ALL
    	SELECT 3
    	UNION ALL
    	SELECT 3) AS t) intersect all select * from (
		SELECT 2 AS x
		UNION ALL
		SELECT 2
		UNION ALL
		SELECT 2
		UNION ALL
		SELECT 4
		UNION ALL
		SELECT 3
		UNION ALL
		SELECT 3) AS u) s
group by x

) s on (x=a and c=b)
) test
