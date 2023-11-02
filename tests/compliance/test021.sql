-- SQL standard compliant string escape
-- string literals are defined in the grammar as follows:
-- <character string literal> ::=
--   [ <introducer> <character set specification> ]
--       <quote> [ <character representation>... ] <quote>
--       [ { <separator> <quote> [ <character representation>... ] <quote> }... ]
-- <character representation> ::=
--     <nonquote character>
--   | <quote symbol>
-- <quote symbol> ::=
--   <quote> <quote>
-- in other words, string literals are started/terminated with quotes, and quotes are escaped with two consecutive quotes
SELECT CASE WHEN LENGTH(x)=1 THEN 'T' ELSE 'F' END AS result
FROM (VALUES ('''')) AS t(x)
