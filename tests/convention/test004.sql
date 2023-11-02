-- a string may be empty but that doesn't make it NULL

SELECT case when '' IS NOT NULL then 'T' else 'F' end AS result
