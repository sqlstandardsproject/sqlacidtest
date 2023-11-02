-- Test that an alias from the select clause can be used in the order by clause
-- Should be standard compliant (CD 9075-2:201?(E) 7.16 <query expression>), 
-- but I cannot find the section that says so explicitly.
select case when (true
  and (select a as b from (values (1)) t(a) order by b) = 1
) then 'T' else 'F' end from (values (1)) AS t
