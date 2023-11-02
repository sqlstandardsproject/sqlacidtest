-- check that full outer joins are decorrelated correctly

-- result header
select count(x)=8 as result
from (
(values(1,NULL,2),(1,NULL,3),(2,1,NULL),(2,NULL,2),(2,NULL,3),(3,1,NULL),(3,2,2),(3,NULL,3)) expected(a,b,c)
left outer join (


-- the query itself
select * from (values(1),(2),(3)) s(x), lateral (select * from (select * from (values(1),(2)) a(y) where y<x) a full outer join (values(2),(3)) b(z) on y=z) t


) t on a is not distinct from x and b is not distinct from y and c is not distinct from z
) test
