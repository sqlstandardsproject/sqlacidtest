-- provide test results here
with testresults as (
  
select 1 as test, result from (
-- tests/compliance/test008.sql
-- check that || is actually the string concat operator...
-- CD 9075-2:201?(E)
-- 4.2.3.2 Operators that operate on character strings and return character strings

-- result header
select case when s = 'abcdef' then 'T' else 'F' end as result
from (

-- the query itself
values ('abc' || 'def')

) t(s)
) testcase(result) UNION ALL select 2 as test, result from (
-- tests/compliance/test014.sql
-- check that precedence matches the standard precedence order
-- associativity rules for arithmetic is defined in 6.27
select case when (
	-- * has higher precedence than binary +
	(1+2*3) = (1+(2*3)) and

	-- / has higher precedence than binary -
	(2-3/4) = (2-(3/4)) and

	-- Left Associativity of /*
	(2/3/3) = ((2/3)/3) and
	(2/3*3) = ((2/3)*3) and

	-- < > = <> has lower precedence than binary -/+*
	(1+2 < 2+2) = ((1+2) < (2+2))  and
	(1+2 <= 1+2) = ((1+2) <= (1+2))  and
	(2+2 > 1+2) = ((2+2) > (1+2))  and
	(2+2 >= 1+2) = ((2+2) >= (1+2))  and
	(2+2 <> 1+2) = ((2+2) <> (1+2))	and

	-- in between  has lower precedence than binary,unary operator
	(2 between 2-1 and 2+1) and
	(2 + 3 in (3+2)) and

	-- OR has lower preceedence than the logical negation
	(not true or true) = ((not true) or true)
) then 'T' else 'F' end as result
) testcase(result) UNION ALL select 3 as test, result from (
-- tests/compliance/test015.sql
-- check that conjunctions correctly handle NULL values
-- 6.35 - Truth table for AND/OR/IS
SELECT case when
    (TRUE  AND TRUE)   IS TRUE    AND
    (TRUE  AND FALSE)  IS FALSE   AND
    (TRUE  AND NULL)   IS NULL    AND
    (FALSE AND TRUE)   IS FALSE   AND
    (FALSE AND FALSE)  IS FALSE   AND
    (FALSE AND NULL)   IS FALSE   AND
    (NULL  AND TRUE)   IS NULL    AND
    (NULL  AND FALSE)  IS FALSE   AND
    (NULL  AND NULL)   IS NULL    AND

    (TRUE  OR TRUE)   IS TRUE    AND
    (TRUE  OR FALSE)  IS TRUE    AND
    (TRUE  OR NULL)   IS TRUE    AND
    (FALSE OR TRUE)   IS TRUE    AND
    (FALSE OR FALSE)  IS FALSE   AND
    (FALSE OR NULL)   IS NULL    AND
    (NULL  OR TRUE)   IS TRUE    AND
    (NULL  OR FALSE)  IS NULL    AND
    (NULL  OR NULL)   IS NULL
then 'T' else 'F' end as result
FROM (VALUES (42)) AS t
) testcase(result) UNION ALL select 4 as test, result from (
-- tests/compliance/test016.sql
-- check standard type casts
-- CD 9075-2:201?(E)
-- 4.1.2 Naming of predefined types
SELECT
  CASE WHEN
        CAST(NULL AS CHARACTER) IS NULL
    AND CAST(NULL AS NUMERIC) IS NULL
    AND CAST(NULL AS DECIMAL) IS NULL
    AND CAST(NULL AS SMALLINT) IS NULL
    AND CAST(NULL AS INTEGER) IS NULL
    AND CAST(NULL AS INT) IS NULL
    AND CAST(NULL AS BIGINT) IS NULL
    AND CAST(NULL AS FLOAT) IS NULL
    AND CAST(NULL AS REAL) IS NULL
    AND CAST(NULL AS DOUBLE PRECISION) IS NULL
    AND CAST('T' AS BOOLEAN) <> CAST('F' AS BOOLEAN)
  THEN 'T' ELSE 'F' END AS result
) testcase(result) UNION ALL select 5 as test, result from (
-- tests/compliance/test017.sql
-- check case insensitivity in identifiers
SELECT CASE WHEN T.HeLlO=t.hello THEN 'T' ELSE 'F' END AS result
FROM (VALUES (42)) AS t(hello)
) testcase(result) UNION ALL select 6 as test, result from (
-- tests/compliance/test018.sql
-- check standard behaviour of between predicates
-- CD 9075-2:201?(E)
-- 8.3 <between predicate>, Syntax Rules 6)

select case when (
       0    BETWEEN -1    AND  1    AND
       0.99 BETWEEN  0    AND  1    AND

       0    BETWEEN  0    AND  0    AND
       1    BETWEEN  0    AND  1    AND
       0    BETWEEN  0    AND  1    AND

      -0    BETWEEN -0    AND +0    AND
      -0.00 BETWEEN -0.00 AND +0.00 AND

       1.00 BETWEEN  0    AND  1.00 AND
  NOT  1.01 BETWEEN  0    AND  1    AND

      'a'   BETWEEN 'a'   AND 'b'   AND
      'ab'  BETWEEN 'a'   AND 'b'   AND
      'b'   BETWEEN 'a'   AND 'b'   AND
  NOT 'bla' BETWEEN 'a'   AND 'b'   AND

  (NULL BETWEEN NULL AND NULL) IS NULL AND
  (NULL BETWEEN 0    AND NULL) IS NULL AND
  (0    BETWEEN 0    AND NULL) IS NULL AND
  (NULL BETWEEN 0    AND 1   ) IS NULL AND

  TRUE  BETWEEN FALSE AND TRUE AND
  FALSE BETWEEN FALSE AND TRUE

) then 'T' else 'F' end as result from (values (1)) as t
) testcase(result) UNION ALL select 7 as test, result from (
-- tests/compliance/test019.sql
-- check string-to-number casting

-- Support for the cast is required by the SQL Standard (see the table in
-- 6.13 <cast specification>, Syntax Rules 6). The actual semantics aren't clear
-- though. We believe the most sane behaviour to parse the string as a numeric
-- literal as defined by the SQL Standard (see grammar rule called
-- <signed numeric literal> in 5.3 <literal>).

SELECT CASE WHEN (
  CAST('+0'      AS NUMERIC(10,3)) = CAST(+0      AS NUMERIC(10,3)) AND
  CAST('-0'      AS NUMERIC(10,3)) = CAST(-0      AS NUMERIC(10,3)) AND

  CAST(' 1'      AS NUMERIC(10,3)) = CAST( 1      AS NUMERIC(10,3)) AND
  CAST(' 1.'     AS NUMERIC(10,3)) = CAST( 1.     AS NUMERIC(10,3)) AND
  CAST(' 1.2'    AS NUMERIC(10,3)) = CAST( 1.2    AS NUMERIC(10,3)) AND
  CAST('  .2'    AS NUMERIC(10,3)) = CAST(  .2    AS NUMERIC(10,3)) AND

  CAST('+1'      AS NUMERIC(10,3)) = CAST(+1      AS NUMERIC(10,3)) AND
  CAST('+1.'     AS NUMERIC(10,3)) = CAST(+1.     AS NUMERIC(10,3)) AND
  CAST('+1.2'    AS NUMERIC(10,3)) = CAST(+1.2    AS NUMERIC(10,3)) AND
  CAST('+.2'     AS NUMERIC(10,3)) = CAST( +.2    AS NUMERIC(10,3)) AND

  CAST('-1'      AS NUMERIC(10,3)) = CAST(-1      AS NUMERIC(10,3)) AND
  CAST('-1.'     AS NUMERIC(10,3)) = CAST(-1.     AS NUMERIC(10,3)) AND
  CAST('-1.2'    AS NUMERIC(10,3)) = CAST(-1.2    AS NUMERIC(10,3)) AND
  CAST('-.2'     AS NUMERIC(10,3)) = CAST( -.2    AS NUMERIC(10,3)) AND

  CAST(' 1.2E3'  AS NUMERIC(10,3)) = CAST( 1.2E3  AS NUMERIC(10,3)) AND
  CAST('+1.2E3'  AS NUMERIC(10,3)) = CAST(+1.2E3  AS NUMERIC(10,3)) AND
  CAST('-1.2E3'  AS NUMERIC(10,3)) = CAST(-1.2E3  AS NUMERIC(10,3)) AND

  CAST(' 1.2E+3' AS NUMERIC(10,3)) = CAST( 1.2E+3 AS NUMERIC(10,3)) AND
  CAST('+1.2E+3' AS NUMERIC(10,3)) = CAST(+1.2E+3 AS NUMERIC(10,3)) AND
  CAST('-1.2E+3' AS NUMERIC(10,3)) = CAST(-1.2E+3 AS NUMERIC(10,3)) AND

  CAST(' 1.2E-3' AS NUMERIC(10,3)) = CAST( 1.2E-3 AS NUMERIC(10,3)) AND
  CAST('+1.2E-3' AS NUMERIC(10,3)) = CAST(+1.2E-3 AS NUMERIC(10,3)) AND
  CAST('-1.2E-3' AS NUMERIC(10,3)) = CAST(-1.2E-3 AS NUMERIC(10,3))
) THEN 'T' ELSE 'F' END
FROM (VALUES (1)) something(x)
) testcase(result) UNION ALL select 8 as test, result from (
-- tests/compliance/test020.sql
-- SQL standard compliant identifiers
-- delimited identifiers are defined in the grammar as follows:
-- <delimited identifier> ::=
--   <double quote> <delimited identifier body> <double quote>
-- <delimited identifier body> ::=
--   <delimited identifier part>...
-- <delimited identifier part> ::=
--     <nondoublequote character>
--   | <doublequote symbol>
-- <doublequote symbol> ::=
--   ""!! two consecutive double quote characters
-- in other words, delimited identifiers are started/terminated with double quotes, and double quotes are escaped with two consecutive double quotes
SELECT CASE WHEN "this is an ""escaped"" identifier"."""escaped"""=1 THEN 'T' ELSE 'F' END AS result
FROM (VALUES (1)) AS "this is an ""escaped"" identifier"("""escaped""")
) testcase(result) UNION ALL select 9 as test, result from (
-- tests/compliance/test021.sql
-- SQL standard compliant string escape
-- string literals are defined in the grammar as follows:
-- <character string literal> ::=
--   [ <introducer> <character set specification> ]
--       <quote> [ <character representation>... ] <quote>
--       [ { <separator> <quote> [ <character representation>... ] <quote> }... ]
-- <character representation> ::=
--     <nonquote character>
--   | <quote symbol>
-- <quote symbol> ::=
--   <quote> <quote>
-- in other words, string literals are started/terminated with quotes, and quotes are escaped with two consecutive quotes
SELECT CASE WHEN LENGTH(x)=1 THEN 'T' ELSE 'F' END AS result
FROM (VALUES ('''')) AS t(x)
) testcase(result) UNION ALL select 10 as test, result from (
-- tests/compliance/test022.sql
-- CD 9075-2:201?(E)
-- 8.5 <like predicate> 
SELECT CASE WHEN (1=1
    -- Normal LIKE tests
    AND 'HELLO' LIKE 'HELLO'
    AND 'HELLO' LIKE 'HEL%O'  
    AND 'HELLO' LIKE 'HE%%O'  
    AND 'HELLO' LIKE 'H%'  
    AND 'HELLO' LIKE 'H_LLO' 
    AND 'HELLO' LIKE '_ELLO'   
    AND 'HELLO' LIKE '_____'  
    AND 'HELLO' LIKE '_____%'  
    AND 'HELLO' LIKE '%_____%'  
    AND 'HELLO' LIKE '%%%%%%%'  
    AND 'HELLO' LIKE '%%%%%%%'              
    AND '%' LIKE '%'
    AND '_' LIKE '_'
             
    -- Normal NOT LIKE tests
    AND 'HELLO' NOT LIKE 'HeLLO'
    AND 'HELLO' NOT LIKE 'HeL%O'  
    AND 'HELLO' NOT LIKE 'He%%O'  
    AND 'HELLO' NOT LIKE 'h%'  
    AND 'HELLO' NOT LIKE 'h_LLO' 
    AND 'HELLO' NOT LIKE '_eLLO'   
    AND 'HELLO' NOT LIKE '______'  
    AND 'HELLO' NOT LIKE '______%'  
    AND 'HELLO' NOT LIKE '%______%'  
    AND 'HELLO' NOT LIKE 'h%%%%%%%' 
                  
    -- Test the ESCAPE clause        
    AND '100%' LIKE '100b%' ESCAPE 'b'
    AND '1000' NOT LIKE '100b%' ESCAPE 'b'
    AND '100_' LIKE '100b_' ESCAPE 'b'
    AND '1000' NOT LIKE '100b_' ESCAPE 'b'
    AND '____' LIKE 'b_b_b_b_' ESCAPE 'b'
    AND '_--_' NOT LIKE 'b_b_b_b_' ESCAPE 'b'
    AND '_%%_' LIKE 'b_b%b%b_' ESCAPE 'b'
    AND '_--_' NOT LIKE 'b_b%b%b_' ESCAPE 'b'
    AND 'b' LIKE 'bb' ESCAPE 'b'
    AND 'bbb' LIKE 'bbbbbb' ESCAPE 'b'
    AND 'bbbH' LIKE 'bbbbbbH' ESCAPE 'b'
                  
    -- NULL semantics
    AND ('HELLO' LIKE NULL) IS NULL
    AND (NULL LIKE NULL) IS NULL
    AND (NULL LIKE 'HELLO') IS NULL
    AND ('HELLO' LIKE 'HELLO' ESCAPE NULL) IS NULL
    AND (NULL LIKE NULL ESCAPE NULL) IS NULL
    AND (NULL LIKE 'HELLO' ESCAPE NULL) IS NULL
    AND (NULL LIKE NULL ESCAPE NULL) IS NULL
                  
) THEN 'T' ELSE 'F' END
FROM (VALUES (1)) t(x)
) testcase(result) UNION ALL select 11 as test, result from (
-- tests/compliance/test023.sql
-- CD 9075-2:201?(E)
-- 8.15 <distinct predicate>
-- 4.1 Data types
-- 4.5.1 Introduction to Boolean types


SELECT CASE WHEN
              NULL IS UNKNOWN
          AND (NULL IS UNKNOWN) IS NOT UNKNOWN
          AND (NULL = 42) IS UNKNOWN
          AND ((NULL AND FALSE) IS NOT DISTINCT FROM FALSE)
          AND ((NULL OR  TRUE)  IS NOT DISTINCT FROM TRUE)
          AND (NULL IS NULL)
          AND ((NULL IS TRUE) IS NOT UNKNOWN)
          AND ((NULL IS TRUE) IS NOT DISTINCT FROM FALSE)
          AND ((NULL IS FALSE) IS NOT UNKNOWN)
          AND ((NULL IS FALSE) IS NOT DISTINCT FROM FALSE)
       THEN 'T'
       ELSE 'F'
       END
) testcase(result) UNION ALL select 12 as test, result from (
-- tests/compliance/test024.sql
-- Section 4.2.3.3
SELECT CASE WHEN 
	LENGTH(x)=5 AND
	POSITION ('l' IN x)=3 AND
	'hello' = x AND
	NOT('hello' <> x)
THEN 'T' ELSE 'F' END AS result
FROM (VALUES ('hello')) AS t(x)
) testcase(result) UNION ALL select 13 as test, result from (
-- tests/compliance/test025.sql
-- extract
-- date/time/timestamp literals are defined in 5.3 <literal>
-- extract is defined in 6.28 <numeric value function>
SELECT CASE WHEN
	EXTRACT(YEAR   FROM date_col)=2000 AND
	EXTRACT(MONTH  FROM date_col)=2 AND
	EXTRACT(DAY    FROM date_col)=3 AND

	EXTRACT(YEAR   FROM ts_col)=2000 AND
	EXTRACT(MONTH  FROM ts_col)=2 AND
	EXTRACT(DAY    FROM ts_col)=3 AND
	EXTRACT(HOUR   FROM ts_col)=12 AND
	EXTRACT(MINUTE FROM ts_col)=23 AND
	EXTRACT(SECOND FROM ts_col)=45 AND

	EXTRACT(HOUR   FROM time_col)=12 AND
	EXTRACT(MINUTE FROM time_col)=23 AND
	EXTRACT(SECOND FROM time_col)=45
THEN 'T'
ELSE 'F'
END AS result
FROM (VALUES (
	DATE '2000-02-03',
	TIMESTAMP '2000-02-03 12:23:45',
	TIME '12:23:45'
)) AS t(date_col, ts_col, time_col)
) testcase(result) UNION ALL select 14 as test, result from (
-- tests/convention/test001.sql
-- check that the engine handles existential queries in disjunctions

-- result header
select case when queryresult = 11 then 'T' else 'F' end as result
from (

-- the query itself
select sum(x) as queryresult
from (values(1),(2),(4),(8),(NULL)) s(x)
where exists(select * from (values(2),(8)) t(y) where x=y) or (x<3)

) test
) testcase(result) UNION ALL select 15 as test, result from (
-- tests/convention/test002.sql
-- test that casting to integer rounds and does not truncate

SELECT case when CAST (4.8 AS INTEGER) = 5 AND CAST(4.2 AS INTEGER) = 4 then 'T' else 'F' end as result
) testcase(result) UNION ALL select 16 as test, result from (
-- tests/convention/test003.sql
-- check that that quantified expressions return NULL values as needed

-- result header
select case when (r1=5) and (r2=40) then 'T' else 'F' end as result
from (

-- the query itself
select sum(case when m then i else 0 end) as r1, sum(case when m is null then i else 0 end) r2
from (
select i, x=some(select a from (values(1,1),(2,2),(3,3),(4,4),(NULL,5)) t(a,b) where b<y) as m
from (values(1,4,1),(2,2,2),(4,6,4),(8,8,8),(NULL,0,16),(NULL,8,32)) s(x,y,i)
) s

) test
) testcase(result) UNION ALL select 17 as test, result from (
-- tests/convention/test004.sql
-- a string may be empty but that doesn't make it NULL

SELECT case when '' IS NOT NULL then 'T' else 'F' end AS result
) testcase(result) UNION ALL select 18 as test, result from (
-- tests/convention/test005.sql
-- check that full outer joins are decorrelated correctly

-- result header
select case when count(x)=8 then 'T' else 'F' end as result
from (
(values(1,NULL,2),(1,NULL,3),(2,1,NULL),(2,NULL,2),(2,NULL,3),(3,1,NULL),(3,2,2),(3,NULL,3)) expected(a,b,c)
left outer join (


-- the query itself
select * from (values(1),(2),(3)) s(x), lateral (select * from (select * from (values(1),(2)) a(y) where y<x) a full outer join (values(2),(3)) b(z) on y=z) t


) t on a is not distinct from x and b is not distinct from y and c is not distinct from z
) test
) testcase(result) UNION ALL select 19 as test, result from (
-- tests/convention/test006.sql
-- check that decimal number behave sane

-- result header
select case when s*10000000000000000 = 100000000000000 then 'T' else 'F' end as result
from (


-- the query itself
select sum(x)/10 as s from (values(0.2),(0.2),(-0.3)) s(x)


) test
) testcase(result) UNION ALL select 20 as test, result from (
-- tests/convention/test007.sql
-- check that multi set operations are supported

-- result header
select case when (count(*) = 3) and (count(x) = 3) then 'T' else 'F' end as result
from (
(values(2,2),(3,1),(4,1)) expected(a,b)
full outer join (


-- the query itself
select x, count(*) as c
from ((select * from (values(1),(2),(2),(3),(3),(3),(4),(4),(4),(4)) s(x) except all select * from (values(1),(3),(3)) t(x)) intersect all select * from (values(2),(2),(2),(4),(3),(3)) u(x)) s
group by x

) s on (x=a and c=b)
) test
) testcase(result) UNION ALL select 21 as test, result from (
-- tests/convention/test009.sql
-- check aggregate behavior
-- result header
SELECT case when
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
	then 'T' else 'F' end AS result
FROM (

SELECT
	sum(x) as su, -- this should not overflow nor throw an error
	min(x) as mi, -- those two should just work
	max(x) as ma,
	avg(x) as av, -- should not be an integer average
	count(x) as ct, -- NULL should be excluded here
	count(*) as cs, -- NULL should be included here
	min(CAST (x as VARCHAR(10))) as mis, -- min/max should work on strings
	max(CAST (x as VARCHAR(10))) as mas,
	sum(distinct x) as sd, -- distinct aggregates should work
	count(distinct x) as cd,
	avg(distinct x) as ad

FROM (VALUES(CAST(30001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (NULL)) s(x)

) test
) testcase(result) UNION ALL select 22 as test, result from (
-- tests/convention/test010.sql
-- check for the space-padding semantics of type char(n)

SELECT case when CAST('123' AS char(4)) =  CAST('123 ' AS char(4))
         AND
       CAST('123' AS varchar(10))    <> CAST('123 ' AS varchar(10)) then 'T' else 'F' end AS result
) testcase(result) UNION ALL select 23 as test, result from (
-- tests/convention/test011.sql
SELECT case when AVG(x)>0 then 'T' else 'F' end AS result
FROM (
	SELECT CAST(9223372036854775807 AS BIGINT) AS x
	UNION ALL
	SELECT CAST(9223372036854775807 AS BIGINT)
) AS t
) testcase(result) UNION ALL select 24 as test, result from (
-- tests/convention/test012.sql
-- check that aggregations are correctly extracted from a subquery
SELECT case when (SELECT SUM(x))=42 then 'T' else 'F' end AS result
FROM (VALUES (42)) AS t(x)
) testcase(result) UNION ALL select 25 as test, result from (
-- tests/convention/test013.sql
-- check that recursive queries work

-- result header
select case when (state='924875136138624795765391842546713928812469357397582614651238479489157263273946581') then 'T' else 'F' end as result
from (


-- the query itself
with recursive
   digits(value,ch) as (values(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7'),(8,'8'),(9,'9')),
   sudoku(state, next) as
   (select state, position(' ' in state) as next
    from (select '9     1 6   62 79   5  1   54     2 81  6935739 5826 46      7   915   32 3 46   ') s(state)
   union all
   select state, position(' ' in state) as next
   from (select substring(state from 1 for next-1) || try || substring(state from next+1) as state
         from sudoku, (select ch as try from digits) g
         where next > 0 and
         not exists(select 1 from (select value as pos from digits) s
                    where try = substring(state from cast(floor((next-1)/9) as integer)*9+pos for 1)
                    or    try = substring(state from mod((next-1),9)+9*pos-8 for 1)
                    or    try = substring(state from mod(cast(floor((next-1)/3) as integer),3)*3+cast(floor((next-1)/27) as integer)*27+pos+cast(floor((pos-1)/3) as integer)*6 for 1))
        ) c)
select state from sudoku where next=0

) test
) testcase(result) UNION ALL select index as test, 'T' as result from generate_series(26,260) s(index) 
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
  from (select cast(floor((test-1)/20) as integer) as line, test, result from testresults where result = 'T') s
  ) s group by line) s
on image.line=s.line order by image.line;
