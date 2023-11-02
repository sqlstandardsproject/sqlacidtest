-- SQL standard compliant identifiers
-- delimited identifiers are defined in the grammar as follows:
-- <delimited identifier> ::=
--   <double quote> <delimited identifier body> <double quote>
-- <delimited identifier body> ::=
--   <delimited identifier part>...
-- <delimited identifier part> ::=
--     <nondoublequote character>
--   | <doublequote symbol>
-- <doublequote symbol> ::=
--   ""!! two consecutive double quote characters
-- in other words, delimited identifiers are started/terminated with double quotes, and double quotes are escaped with two consecutive double quotes
SELECT CASE WHEN "this is an ""escaped"" identifier"."""escaped"""=1 THEN 'T' ELSE 'F' END AS result
FROM (VALUES (1)) AS "this is an ""escaped"" identifier"("""escaped""")
