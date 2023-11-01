-- check that conjunctions correctly handle NULL values
SELECT 13 AS test,
    NULL OR x>0
    AND
    NOT (NULL AND x<0) AS result
FROM (VALUES (42)) AS t(x)
