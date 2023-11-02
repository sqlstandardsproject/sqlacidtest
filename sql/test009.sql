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
	min(CAST (x as VARCHAR)) as mis, -- min/max should work on strings
	max(CAST (x as VARCHAR)) as mas,
	sum(distinct x) as sd, -- distinct aggregates should work
	count(distinct x) as cd,
	avg(distinct x) as ad

FROM (VALUES(CAST(30001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (NULL)) s(x)

) test
