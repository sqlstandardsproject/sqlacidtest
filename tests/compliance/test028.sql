with
-- Single IN attribute
test0  as (select coalesce(sum(k), 0) - 6 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x in     (select a from (select 2 as a union all select 3 union all select 4) S)),
test1  as (select coalesce(sum(k), 0) - 1 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x not in (select a from (select 2 as a union all select 3 union all select 4) S)),
test2  as (select coalesce(sum(k), 0) - 6 as r from (select 1 as k, null as x union all select 2, 2 union all select 4, 3) R where x in     (select a from (select 2 as a union all select 3 union all select 4) S)),
test3  as (select coalesce(sum(k), 0) - 0 as r from (select 1 as k, null as x union all select 2, 2 union all select 4, 3) R where x not in (select a from (select 2 as a union all select 3 union all select 4) S)),
test4  as (select coalesce(sum(k), 0) - 6 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x in     (select a from (select 2 as a union all select 3 union all select 4 union all select null) S)),
test5  as (select coalesce(sum(k), 0) - 0 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x not in (select a from (select 2 as a union all select 3 union all select 4 union all select null) S)),
test6  as (select coalesce(sum(k), 0) - 0 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x in     (select a from (select 2 as a union all select 3 union all select 4) S where a < 2)),
test7  as (select coalesce(sum(k), 0) - 7 as r from (select 1 as k, 1 as x union all select 2, 2 union all select 4, 3) R where x not in (select a from (select 2 as a union all select 3 union all select 4) S where a < 2)),
-- Correlated single IN attribute
test8  as (select coalesce(sum(k), 0) - 1   as r from (select 1 as k, 1 as x, 1 as y union all select 2, null, 1 union all select 4, 1, 2 union all select 8, null, 2 union all select 16, 1, 3 union all select 32, null, 3 union all select 64, 1, null union all select 128, null, null) R where x in     (select a from (select 1 as a, 1 as b union all select 2, 2) S where y = b)),
test9  as (select coalesce(sum(k), 0) - 244 as r from (select 1 as k, 1 as x, 1 as y union all select 2, null, 1 union all select 4, 1, 2 union all select 8, null, 2 union all select 16, 1, 3 union all select 32, null, 3 union all select 64, 1, null union all select 128, null, null) R where x not in (select a from (select 1 as a, 1 as b union all select 2, 2) S where y = b)),
test10 as (select coalesce(sum(k), 0) - 1   as r from (select 1 as k, 1 as x, 1 as y union all select 2, null, 1 union all select 4, 1, 2 union all select 8, null, 2 union all select 16, 1, 3 union all select 32, null, 3 union all select 64, 1, null union all select 128, null, null) R where x in     (select a from (select 1 as a, 1 as b union all select null, 1 union all select null, 2 union all select null, null) S where y = b)),
test11 as (select coalesce(sum(k), 0) - 240 as r from (select 1 as k, 1 as x, 1 as y union all select 2, null, 1 union all select 4, 1, 2 union all select 8, null, 2 union all select 16, 1, 3 union all select 32, null, 3 union all select 64, 1, null union all select 128, null, null) R where x not in (select a from (select 1 as a, 1 as b union all select null, 1 union all select null, 2 union all select null, null) S where y = b))
select case when (0
    + case when (select r from test0)  = 0 then 0 else 1    end
    + case when (select r from test1)  = 0 then 0 else 2    end
    + case when (select r from test2)  = 0 then 0 else 4    end
    + case when (select r from test3)  = 0 then 0 else 8    end
    + case when (select r from test4)  = 0 then 0 else 16   end
    + case when (select r from test5)  = 0 then 0 else 32   end
    + case when (select r from test6)  = 0 then 0 else 64   end
    + case when (select r from test7)  = 0 then 0 else 128  end
    + case when (select r from test8)  = 0 then 0 else 256  end
    + case when (select r from test9)  = 0 then 0 else 512  end
    + case when (select r from test10) = 0 then 0 else 1024 end
    + case when (select r from test11) = 0 then 0 else 2048 end) = 0 then 'T' else 'F' end
from (values (1)) dumm(x)
;