-- provide test results here
with testresults as (
  
-- check that the engine handles existential queries in disjunctions

-- result header
select 1 as test, queryresult = 11 as result
from (

-- the query itself
select sum(x) as queryresult
from (values(1),(2),(4),(8),(NULL)) s(x)
where exists(select * from (values(2),(8)) t(y) where x=y) or (x<3)

) test
UNION ALL
-- test that casting to integer rounds and does not truncate

SELECT 2 as test, CAST (4.8 AS INTEGER) = 5 AND CAST(4.2 AS INTEGER) = 4 as result
UNION ALL
-- check that that quantified expressions return NULL values as needed

-- result header
select 3 as test, (r1=5) and (r2=40) as result
from (

-- the query itself
select sum(case when m then i else 0 end) as r1, sum(case when m is null then i else 0 end) r2
from (
select i, x=some(select a from (values(1,1),(2,2),(3,3),(4,4),(NULL,5)) t(a,b) where b<y) as m
from (values(1,4,1),(2,2,2),(4,6,4),(8,8,8),(NULL,0,16),(NULL,8,32)) s(x,y,i)
) s

) test
UNION ALL
-- a string may be empty but that doesn't make it NULL

SELECT 4 AS test, '' IS NOT NULL AS result
UNION ALL
-- check that full outer joins are decorrelated correctly

-- result header
select 5 as test, count(x)=8 as result
from (
(values(1,NULL,2),(1,NULL,3),(2,1,NULL),(2,NULL,2),(2,NULL,3),(3,1,NULL),(3,2,2),(3,NULL,3)) expected(a,b,c)
left outer join (


-- the query itself
select * from (values(1),(2),(3)) s(x), lateral (select * from (select * from (values(1),(2)) a(y) where y<x) a full outer join (values(2),(3)) b(z) on y=z) t


) t on a is not distinct from x and b is not distinct from y and c is not distinct from z
) test
UNION ALL
-- check that decimal number behave sane

-- result header
select 6 as test, s*10000000000000000 = 100000000000000 as result
from (


-- the query itself
select sum(x)/10 as s from (values(0.2),(0.2),(-0.3)) s(x)


) test
UNION ALL
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

) s on (x=a and c=b)
) test
UNION ALL
-- check that || is actually the string concat operator...

-- result header
select 8 as test, s = 'abcdef' as result
from (

-- the query itself
select 'abc' || 'def'

) _(s)
UNION ALL
-- check aggregate behavior
-- result header
SELECT 9 AS test,
	su = 70003 AND
	mi = 20001 AND
	ma = 30001 AND
	av BETWEEN 23334.3 AND 23334.4 AND
	ct = 3 AND
	cs = 4 AND
	mis = '20001' AND
	mas = '30001' AND
	sd = 50002 AND
	cd = 2 AND
	CAST(ad as INTEGER) = 25001
	 AS result
FROM (

SELECT 
	sum(x) as su, -- this should not overflow nor throw an error
	min(x) as mi, -- those two should just work
	max(x) as ma,
	avg(x) as av, -- should not be an integer average
	count(x) as ct, -- NULL should be excluded here
	count(*) as cs, -- NULL should be included here
	min(CAST (x as VARCHAR)) as mis, -- min/max should work on strings
	max(CAST (x as VARCHAR)) as mas,
	sum(distinct x) as sd, -- distinct aggregates should work
	count(distinct x) as cd,
	avg(distinct x) as ad

FROM (VALUES(CAST(30001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (NULL)) s(x)

) test
UNION ALL
-- check for the space-padding semantics of type char(n)

SELECT 10 AS test,
       CAST('123' AS char(4)) =  CAST('123 ' AS char(4))
         AND
       CAST('123' AS text)    <> CAST('123 ' AS text) AS result
UNION ALL
SELECT 11 AS test, AVG(x)>0 AS result
FROM (
	SELECT CAST(9223372036854775807 AS BIGINT) AS x
	UNION ALL
	SELECT CAST(9223372036854775807 AS BIGINT)
) AS t
UNION ALL
-- check that aggregations are correctly extracted from a subquery
SELECT 12 AS test, (SELECT SUM(x))=126 AS result
FROM (VALUES (42), (84)) AS t(x)
UNION ALL
select index as test, true as result from generate_series(13,260) s(index) 
)
-- render the result
select case when state = 1048575 then image else 'XXXXXXXXXXXXXXXXXXXX' end as output from (values
(0, '+-----------------+'),
(1, '|......#####......|'),
(2, '|....##.....##....|'),
(3, '|...#.........#...|'),
(4, '|..#..()...()..#..|'),
(5, '|..#.....o.....#..|'),
(6, '|.#.............#.|'),
(7, '|..#..\...../..#..|'),
(8, '|..#...-----...#..|'),
(9, '|...#.........#...|'),
(10,'|....##.....##....|'),
(11,'|......#####......|'),
(12,'+-----------------+')
) image(line, image) left outer join (
select line, sum(cast(power(2,ofs) as integer)) as state
  from (select line, test-1-20*line as ofs, test, result
  from (select cast(floor((test-1)/20) as integer) as line, test, result from testresults where result) s
  ) s group by line) s
on image.line=s.line order by image.line;

