-- check aggregate behavior
-- result header
SELECT 42 AS test, *, 
	su = 50001 AND 
	mi = 20001 AND 
	ma = 30000 AND 
	av BETWEEN 25000.4 AND 25000.6,
	ct = 2 AND 
	cs = 3 AS result
FROM (


-- all aggregates shuold ignore NULL
SELECT 
	sum(x::SMALLINT) as su, -- this should not overflow nor throw an error
	min(x::SMALLINT) as mi, -- those two should just work
	max(x::SMALLINT) as ma,
	avg(x::SMALLINT) as av, -- should not be an integer average
	count(x::SMALLINT) as ct, -- NULL should be excluded here
	count(*) as cs -- NULL should be included here

FROM (VALUES(30000), (20001), (NULL)) s(x)

) test
