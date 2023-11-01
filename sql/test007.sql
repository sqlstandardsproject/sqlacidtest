-- check that multi set operations are supported

-- result header
select 7 as test, (count(*) = 3) and (count(x) = 3) as result
from (
(values(2,2),(3,1),(4,1)) expected(a,b)
full outer join (


-- the query itself
select x, count(*) as c
from ((select * from (values(1),(2),(2),(3),(3),(3),(4),(4),(4),(4)) s(x) except all select * from (values(1),(3),(3)) t(x)) intersect all select * from (values(2),(2),(2),(4),(3),(3)) u(x)) s
group by x

) s on (x is not distinct from a and c is not distinct from b)
) test
