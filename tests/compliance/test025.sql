-- extract
-- date/time/timestamp literals are defined in 5.3 <literal>
-- extract is defined in 6.28 <numeric value function>
SELECT CASE WHEN
	EXTRACT(YEAR   FROM date_col)=2000 AND
	EXTRACT(MONTH  FROM date_col)=2 AND
	EXTRACT(DAY    FROM date_col)=3 AND

	EXTRACT(YEAR   FROM ts_col)=2000 AND
	EXTRACT(MONTH  FROM ts_col)=2 AND
	EXTRACT(DAY    FROM ts_col)=3 AND
	EXTRACT(HOUR   FROM ts_col)=12 AND
	EXTRACT(MINUTE FROM ts_col)=23 AND
	EXTRACT(SECOND FROM ts_col)=45 AND

	EXTRACT(HOUR   FROM time_col)=12 AND
	EXTRACT(MINUTE FROM time_col)=23 AND
	EXTRACT(SECOND FROM time_col)=45
THEN 'T'
ELSE 'F'
END AS result
FROM (VALUES (
	DATE '2000-02-03',
	TIMESTAMP '2000-02-03 12:23:45',
	TIME '12:23:45'
)) AS t(date_col, ts_col, time_col)
