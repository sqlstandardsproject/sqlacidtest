with
-- Multiple IN attributes
test0 as (select coalesce(sum(k), 0) - 2  as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 9 union all select 8, 9, 8 union all select 16, 3, null union all select 32, null, 8) R where (x, y) in     (select a, b from (select 2 as a, 6 as b union all select 3, 7 union all select 4, 8) S)),
test1 as (select coalesce(sum(k), 0) - 13 as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 9 union all select 8, 9, 8 union all select 16, 3, null union all select 32, null, 8) R where (x, y) not in (select a, b from (select 2 as a, 6 as b union all select 3, 7 union all select 4, 8) S)),
test2 as (select coalesce(sum(k), 0) - 2  as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 9 union all select 8, 9, 8 union all select 16, 3, null union all select 32, null, 8 union all select 64, null, null) R where (x, y) in     (select a, b from (select 2 as a, 6 as b union all select 3, 7 union all select 3, null union all select 4, 8) S)),
test3 as (select coalesce(sum(k), 0) - 9  as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 9 union all select 8, 9, 8 union all select 16, 3, null union all select 32, null, 8 union all select 64, null, null) R where (x, y) not in (select a, b from (select 2 as a, 6 as b union all select 3, 7 union all select 3, null union all select 4, 8) S)),
test4 as (select coalesce(sum(k), 0) - 2  as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 7 union all select 8, 4, 8) R where (x, y) in     (select a, b from (select 2 as a, 6 as b union all select null, 7 union all select 4, null union all select null, null) S)),
test5 as (select coalesce(sum(k), 0) - 0  as r from (select 1 as k, 1 as x, 5 as y union all select 2, 2, 6 union all select 4, 3, 7 union all select 8, 4, 8) R where (x, y) not in (select a, b from (select 2 as a, 6 as b union all select null, 7 union all select 4, null union all select null, null) S)),
test6 as (select coalesce(sum(k), 0) - 1  as r from (select 1 as k, 1 as x0, 1 as x1, 1 as x2, 1 as x3, 1 as x4, 1 as x5 union all select 2, 0, 0, 0, 0, 0, 0 union all select 4, 1, 0, 0, 0, 0, 0 union all select 8, 0, 1, 1, 0, 1, 0) R where (x0, x1, x2, x3, x4, x5) in     (select a0, a1, a2, a3, a4, a5 from (select 1 as a0, 1 as a1, 1 as a2, 1 as a3, 1 as a4, 1 as a5 union all select 0, null, null, 0, null, 0) S)),
test7 as (select coalesce(sum(k), 0) - 4  as r from (select 1 as k, 1 as x0, 1 as x1, 1 as x2, 1 as x3, 1 as x4, 1 as x5 union all select 2, 0, 0, 0, 0, 0, 0 union all select 4, 1, 0, 0, 0, 0, 0 union all select 8, 0, 1, 1, 0, 1, 0) R where (x0, x1, x2, x3, x4, x5) not in (select a0, a1, a2, a3, a4, a5 from (select 1 as a0, 1 as a1, 1 as a2, 1 as a3, 1 as a4, 1 as a5 union all select 0, null, null, 0, null, 0) S)),
-- Correlated multiple IN attributes
test8 as (select coalesce(sum(k), 0) - 1  as r from (select 1 as k, 2 as rc, 1 as x0, 1 as x1, 1 as x2, 1 as x3, 1 as x4, 1 as x5 union all select 2, 2, null, null, null, null, null, null union all select 4, 3, 1, 0, 0, 0, 0, 0 union all select 8, 2, 0, 1, 1, 0, 1, 0) R where (x0, x1, x2, x3, x4, x5) in     (select a0, a1, a2, a3, a4, a5 from (select 2 as sc, 1 as a0, 1 as a1, 1 as a2, 1 as a3, 1 as a4, 1 as a5 union all select 3, 0, null, null, 0, null, 0) S where rc = sc)),
test9 as (select coalesce(sum(k), 0) - 12 as r from (select 1 as k, 2 as rc, 1 as x0, 1 as x1, 1 as x2, 1 as x3, 1 as x4, 1 as x5 union all select 2, 2, null, null, null, null, null, null union all select 4, 3, 1, 0, 0, 0, 0, 0 union all select 8, 2, 0, 1, 1, 0, 1, 0) R where (x0, x1, x2, x3, x4, x5) not in (select a0, a1, a2, a3, a4, a5 from (select 2 as sc, 1 as a0, 1 as a1, 1 as a2, 1 as a3, 1 as a4, 1 as a5 union all select 3, 0, null, null, 0, null, 0) S where rc = sc))
select case when (0
    + case when (select r from test0) = 0 then 0 else 1   end
    + case when (select r from test1) = 0 then 0 else 2   end
    + case when (select r from test2) = 0 then 0 else 4   end
    + case when (select r from test3) = 0 then 0 else 8   end
    + case when (select r from test4) = 0 then 0 else 16  end
    + case when (select r from test5) = 0 then 0 else 32  end
    + case when (select r from test6) = 0 then 0 else 64  end
    + case when (select r from test7) = 0 then 0 else 128 end
    + case when (select r from test8) = 0 then 0 else 256 end
    + case when (select r from test9) = 0 then 0 else 512 end) = 0 then 'T' else 'F' end
from (values (1)) dumm(x)
;
