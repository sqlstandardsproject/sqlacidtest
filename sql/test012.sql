-- check that aggregations are correctly extracted from a subquery
SELECT (SELECT SUM(x))=42 AS result
FROM (VALUES (42)) AS t(x)
