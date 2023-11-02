-- check that || is actually the string concat operator...

-- result header
select case when s = 'abcdef' then 'T' else 'F' end as result
from (

-- the query itself
select 'abc' || 'def'

) _(s)
