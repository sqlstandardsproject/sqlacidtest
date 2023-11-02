-- check string-to-number casting

-- Support for the cast is required by the SQL Standard (see the table in
-- 6.13 <cast specification>, Syntax Rules 6). The actual semantics aren't clear
-- though. We believe the most sane behaviour to parse the string as a numeric
-- literal as defined by the SQL Standard (see grammar rule called
-- <signed numeric literal> in 5.3 <literal>).

SELECT CASE WHEN (
  CAST('+0'      AS NUMERIC(10,3)) = CAST(+0      AS NUMERIC(10,3)) AND
  CAST('-0'      AS NUMERIC(10,3)) = CAST(-0      AS NUMERIC(10,3)) AND

  CAST(' 1'      AS NUMERIC(10,3)) = CAST( 1      AS NUMERIC(10,3)) AND
  CAST(' 1.'     AS NUMERIC(10,3)) = CAST( 1.     AS NUMERIC(10,3)) AND
  CAST(' 1.2'    AS NUMERIC(10,3)) = CAST( 1.2    AS NUMERIC(10,3)) AND
  CAST('  .2'    AS NUMERIC(10,3)) = CAST(  .2    AS NUMERIC(10,3)) AND

  CAST('+1'      AS NUMERIC(10,3)) = CAST(+1      AS NUMERIC(10,3)) AND
  CAST('+1.'     AS NUMERIC(10,3)) = CAST(+1.     AS NUMERIC(10,3)) AND
  CAST('+1.2'    AS NUMERIC(10,3)) = CAST(+1.2    AS NUMERIC(10,3)) AND
  CAST('+.2'     AS NUMERIC(10,3)) = CAST( +.2    AS NUMERIC(10,3)) AND

  CAST('-1'      AS NUMERIC(10,3)) = CAST(-1      AS NUMERIC(10,3)) AND
  CAST('-1.'     AS NUMERIC(10,3)) = CAST(-1.     AS NUMERIC(10,3)) AND
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
