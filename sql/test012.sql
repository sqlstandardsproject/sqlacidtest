-- check that aggregations are correctly extracted from a subquery
SELECT case when (SELECT SUM(x))=42 then 'T' else 'F' end AS result
FROM (SELECT 42 AS x) AS t
