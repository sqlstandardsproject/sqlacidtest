-- check that the engine handles existential queries in disjunctions

-- result header
select 1 as test, queryresult = 11 as result
from (

-- the query itself
select sum(x) as queryresult
from (values(1),(2),(4),(8),(NULL)) s(x)
where exists(select * from (values(2),(8)) t(y) where x=y) or (x<3)

) test
