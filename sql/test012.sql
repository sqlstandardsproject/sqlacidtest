-- check that aggregations are correctly extracted from a subquery
SELECT 12 AS test, (SELECT SUM(x))=126 AS result
FROM (VALUES (42), (84)) AS t(x)
