-- check for the space-padding semantics of type char(n)

SELECT 10 AS test,
       CAST('123' AS char(4)) =  CAST('123 ' AS char(4))
         AND
       CAST('123' AS text)    <> CAST('123 ' AS text) AS result;
