-- check that conjunctions correctly handle NULL values
-- 6.35 - Truth table for AND/OR/IS
SELECT case when
    (TRUE  AND TRUE)   IS TRUE    AND
    (TRUE  AND FALSE)  IS FALSE   AND
    (TRUE  AND NULL)   IS NULL    AND
    (FALSE AND TRUE)   IS FALSE   AND
    (FALSE AND FALSE)  IS FALSE   AND
    (FALSE AND NULL)   IS FALSE   AND
    (NULL  AND TRUE)   IS NULL    AND
    (NULL  AND FALSE)  IS FALSE   AND
    (NULL  AND NULL)   IS NULL    AND

    (TRUE  OR TRUE)   IS TRUE    AND
    (TRUE  OR FALSE)  IS TRUE    AND
    (TRUE  OR NULL)   IS TRUE    AND
    (FALSE OR TRUE)   IS TRUE    AND
    (FALSE OR FALSE)  IS FALSE   AND
    (FALSE OR NULL)   IS NULL    AND
    (NULL  OR TRUE)   IS TRUE    AND
    (NULL  OR FALSE)  IS NULL    AND
    (NULL  OR NULL)   IS NULL
then 'T' else 'F' end as result
FROM (VALUES (42)) AS t
