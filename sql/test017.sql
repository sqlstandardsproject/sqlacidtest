-- check case insensitivity in identifiers
SELECT CASE WHEN T.HeLlO=t.hello THEN 'T' ELSE 'F' END AS result
FROM (SELECT 42 AS hello) AS t
