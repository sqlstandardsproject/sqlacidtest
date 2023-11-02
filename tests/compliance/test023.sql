-- CD 9075-2:201?(E)
-- 8.15 <distinct predicate>
-- 4.1 Data types
-- 4.5.1 Introduction to Boolean types


SELECT CASE WHEN
              NULL IS UNKNOWN
          AND (NULL IS UNKNOWN) IS NOT UNKNOWN
          AND (NULL = 42) IS UNKNOWN
          AND ((NULL AND FALSE) IS NOT DISTINCT FROM FALSE)
          AND ((NULL OR  TRUE)  IS NOT DISTINCT FROM TRUE)
          AND (NULL IS NULL)
          AND ((NULL IS TRUE) IS NOT UNKNOWN)
          AND ((NULL IS TRUE) IS NOT DISTINCT FROM FALSE)
          AND ((NULL IS FALSE) IS NOT UNKNOWN)
          AND ((NULL IS FALSE) IS NOT DISTINCT FROM FALSE)
       THEN 'T'
       ELSE 'F'
       END
