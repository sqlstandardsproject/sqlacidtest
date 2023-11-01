-- check that that quantified expressions return NULL values as needed

-- result header
select (r1=5) and (r2=40) as result
from (

-- the query itself
select sum(case when m then i else 0 end) as r1, sum(case when m is null then i else 0 end) r2
from (
select i, x=some(select a from (values(1,1),(2,2),(3,3),(4,4),(NULL,5)) t(a,b) where b<y) as m
from (values(1,4,1),(2,2,2),(4,6,4),(8,8,8),(NULL,0,16),(NULL,8,32)) s(x,y,i)
) s

) test
