-- test that casting to integer rounds and does not truncate

SELECT 2 as test, CAST (4.8 AS INTEGER) = 5 AND CAST(4.2 AS INTEGER) = 4 as result