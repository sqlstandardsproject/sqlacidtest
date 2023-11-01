-- check that aggregations are correctly extracted from a subquery
SELECT (SELECT SUM(x))=126 AS result
FROM (VALUES (42), (84)) AS t(x)
