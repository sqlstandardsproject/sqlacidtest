-- check standard behaviour of between predicates
-- CD 9075-2:201?(E)
-- 8.3 <between predicate>, Syntax Rules 6)

select case when (
       0    BETWEEN -1    AND  1    AND
       0.99 BETWEEN  0    AND  1    AND

       0    BETWEEN  0    AND  0    AND
       1    BETWEEN  0    AND  1    AND
       0    BETWEEN  0    AND  1    AND

      -0    BETWEEN -0    AND +0    AND
      -0.00 BETWEEN -0.00 AND +0.00 AND

       1.00 BETWEEN  0    AND  1.00 AND
  NOT  1.01 BETWEEN  0    AND  1    AND

      'a'   BETWEEN 'a'   AND 'b'   AND
      'ab'  BETWEEN 'a'   AND 'b'   AND
      'b'   BETWEEN 'a'   AND 'b'   AND
  NOT 'bla' BETWEEN 'a'   AND 'b'   AND

  (NULL BETWEEN NULL AND NULL) IS NULL AND
  (NULL BETWEEN 0    AND NULL) IS NULL AND
  (0    BETWEEN 0    AND NULL) IS NULL AND
  (NULL BETWEEN 0    AND 1   ) IS NULL AND

  TRUE  BETWEEN FALSE AND TRUE AND
  FALSE BETWEEN FALSE AND TRUE

) then 'T' else 'F' end as result from (values (1)) as t
