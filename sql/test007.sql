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
from ((select * from (values(1),(2),(2),(3),(3),(3),(4),(4),(4),(4)) s(x) except all select * from (values(1),(3),(3)) t(x)) intersect all select * from (values(2),(2),(2),(4),(3),(3)) u(x)) s
group by x

) s on (x=a and c=b)
) test
