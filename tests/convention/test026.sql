-- Should be standard compliant, but I cannot find the section in the
-- standard that says so explicitly.
select case when (true
  and (select a as b from (values (1)) t(a) order by b) = 1
) then 'T' else 'F' end from (values (1)) AS t