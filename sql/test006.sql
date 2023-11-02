-- check that decimal number behave sane

-- result header
select s*10000000000000000 = 100000000000000 as result
from (


-- the query itself
select sum(x)/10 as s from (values(0.2),(0.2),(-0.3)) s(x)


) test
