-- check that precedence matches the standard precedence order
-- associativity rules for arithmetic is defined in 6.27
select case when (
	-- * has higher precedence than binary +
	(1+2*3) = (1+(2*3)) and

	-- / has higher precedence than binary -
	(2-3/4) = (2-(3/4)) and

	-- Left Associativity of /*
	(2/3/3) = ((2/3)/3) and
	(2/3*3) = ((2/3)*3) and

	-- < > = <> has lower precedence than binary -/+*
	(1+2 < 2+2) = ((1+2) < (2+2))  and
	(1+2 <= 1+2) = ((1+2) <= (1+2))  and
	(2+2 > 1+2) = ((2+2) > (1+2))  and
	(2+2 >= 1+2) = ((2+2) >= (1+2))  and
	(2+2 <> 1+2) = ((2+2) <> (1+2))	and

	-- in between  has lower precedence than binary,unary operator
	(2 between 2-1 and 2+1) and
	(2 + 3 in (3+2)) and

	-- OR has lower preceedence than the logical negation
	(not true or true) = ((not true) or true)
) then 'T' else 'F' end as result
