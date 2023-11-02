-- check case insensitivity in identifiers
SELECT CASE WHEN T.HeLlO=t.hello THEN 'T' ELSE 'F' END AS result
FROM (VALUES (42)) AS t(hello)
