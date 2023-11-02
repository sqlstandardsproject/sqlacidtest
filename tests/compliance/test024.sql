-- Section 4.2.3.3
SELECT CASE WHEN 
	LENGTH(x)=5 AND
	POSITION ('l' IN x)=3 AND
	'hello' = x AND
	NOT('hello' <> x)
THEN 'T' ELSE 'F' END AS result
FROM (VALUES ('hello')) AS t(x)