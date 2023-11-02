-- check that || is actually the string concat operator...

-- result header
select s = 'abcdef' as result
from (

-- the query itself
select 'abc' || 'def'

) _(s)
