-- check that the VALUES clause works
SELECT CASE WHEN
    SUM(a) = 86 AND SUM(b) = 88 THEN 'T' ELSE 'F' END AS result
FROM (VALUES (42, 43), (44, 45)) AS t(a, b)
