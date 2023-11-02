-- check that conjunctions correctly handle NULL values
SELECT case when
    NULL OR x>0
    AND
    NOT (NULL AND x<0) then 'T' else 'F' end AS result
FROM (VALUES (42)) AS t(x)
