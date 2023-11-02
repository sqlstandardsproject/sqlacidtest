-- check for the space-padding semantics of type char(n)

SELECT case when CAST('123' AS char(4)) =  CAST('123 ' AS char(4))
         AND
       CAST('123' AS varchar(10))    <> CAST('123 ' AS varchar(10)) then 'T' else 'F' end AS result
