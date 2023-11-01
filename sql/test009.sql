-- check aggregate behavior
-- result header
SELECT 9 AS test,
	su = 50001 AND
	mi = 20001 AND
	ma = 30000 AND
	av BETWEEN 25000.4 AND 25000.6 AND
	ct = 2 AND
	cs = 3 AND
	mis = 'asdf' AND
	mas = 'asdf' AS result
FROM (


-- all aggregates shuold ignore NULL
SELECT 
	sum(x) as su, -- this should not overflow nor throw an error
	min(x) as mi, -- those two should just work
	max(x) as ma,
	avg(x) as av, -- should not be an integer average
	count(x) as ct, -- NULL should be excluded here
	count(*) as cs, -- NULL should be included here
	min('asdf') as mis, -- min/max should work on strings
	max('asdf') as mas

FROM (VALUES(CAST(30000 AS SMALLINT)), (CAST(20001 AS SMALLINT)), (NULL)) s(x)

) test
