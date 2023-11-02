-- check string-to-number casting
SELECT CASE WHEN (
  CAST(' 1  '    AS NUMERIC(10,3)) = CAST( 1      AS NUMERIC(10,3)) AND
  CAST(' 1. '    AS NUMERIC(10,3)) = CAST( 1.     AS NUMERIC(10,3)) AND
  CAST(' 1.2'    AS NUMERIC(10,3)) = CAST( 1.2    AS NUMERIC(10,3)) AND
  CAST('  .2'    AS NUMERIC(10,3)) = CAST(  .2    AS NUMERIC(10,3)) AND

  CAST('+1  '    AS NUMERIC(10,3)) = CAST(+1      AS NUMERIC(10,3)) AND
  CAST('+1. '    AS NUMERIC(10,3)) = CAST(+1.     AS NUMERIC(10,3)) AND
  CAST('+1.2'    AS NUMERIC(10,3)) = CAST(+1.2    AS NUMERIC(10,3)) AND
  CAST('+.2'     AS NUMERIC(10,3)) = CAST( +.2    AS NUMERIC(10,3)) AND

  CAST('-1  '    AS NUMERIC(10,3)) = CAST(-1      AS NUMERIC(10,3)) AND
  CAST('-1. '    AS NUMERIC(10,3)) = CAST(-1.     AS NUMERIC(10,3)) AND
  CAST('-1.2'    AS NUMERIC(10,3)) = CAST(-1.2    AS NUMERIC(10,3)) AND
  CAST('-.2'     AS NUMERIC(10,3)) = CAST( -.2    AS NUMERIC(10,3)) AND

  CAST(' 1.2E3'  AS NUMERIC(10,3)) = CAST( 1.2E3  AS NUMERIC(10,3)) AND
  CAST('+1.2E3'  AS NUMERIC(10,3)) = CAST(+1.2E3  AS NUMERIC(10,3)) AND
  CAST('-1.2E3'  AS NUMERIC(10,3)) = CAST(-1.2E3  AS NUMERIC(10,3)) AND

  CAST(' 1.2E+3' AS NUMERIC(10,3)) = CAST( 1.2E+3 AS NUMERIC(10,3)) AND
  CAST('+1.2E+3' AS NUMERIC(10,3)) = CAST(+1.2E+3 AS NUMERIC(10,3)) AND
  CAST('-1.2E+3' AS NUMERIC(10,3)) = CAST(-1.2E+3 AS NUMERIC(10,3)) AND

  CAST(' 1.2E-3' AS NUMERIC(10,3)) = CAST( 1.2E-3 AS NUMERIC(10,3)) AND
  CAST('+1.2E-3' AS NUMERIC(10,3)) = CAST(+1.2E-3 AS NUMERIC(10,3)) AND
  CAST('-1.2E-3' AS NUMERIC(10,3)) = CAST(-1.2E-3 AS NUMERIC(10,3))
) THEN 'T' ELSE 'F' END
FROM (VALUES (1)) something(x)
