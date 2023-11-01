-- check that || is actually the string concat operator...

-- result header
select 8 as test, s = 'abcdef' as result
from (

-- the query itself
select 'abc' || 'def'

) somealias(s)
