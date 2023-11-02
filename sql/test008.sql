-- check that || is actually the string concat operator...
-- CD 9075-2:201?(E)
-- 4.2.3.2 Operators that operate on character strings and return character strings

-- result header
select case when s = 'abcdef' then 'T' else 'F' end as result
from (

-- the query itself
values ('abc' || 'def')

) t(s)
