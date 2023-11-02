-- CD 9075-2:201?(E)
-- 8.5 <like predicate> 
SELECT CASE WHEN (1=1
    -- Normal LIKE tests
    AND 'HELLO' LIKE 'HELLO'
    AND 'HELLO' LIKE 'HEL%O'  
    AND 'HELLO' LIKE 'HE%%O'  
    AND 'HELLO' LIKE 'H%'  
    AND 'HELLO' LIKE 'H_LLO' 
    AND 'HELLO' LIKE '_ELLO'   
    AND 'HELLO' LIKE '_____'  
    AND 'HELLO' LIKE '_____%'  
    AND 'HELLO' LIKE '%_____%'  
    AND 'HELLO' LIKE '%%%%%%%'  
    AND 'HELLO' LIKE '%%%%%%%'              
    AND '%' LIKE '%'
    AND '_' LIKE '_'
             
    -- Normal NOT LIKE tests
    AND 'HELLO' NOT LIKE 'HeLLO'
    AND 'HELLO' NOT LIKE 'HeL%O'  
    AND 'HELLO' NOT LIKE 'He%%O'  
    AND 'HELLO' NOT LIKE 'h%'  
    AND 'HELLO' NOT LIKE 'h_LLO' 
    AND 'HELLO' NOT LIKE '_eLLO'   
    AND 'HELLO' NOT LIKE '______'  
    AND 'HELLO' NOT LIKE '______%'  
    AND 'HELLO' NOT LIKE '%______%'  
    AND 'HELLO' NOT LIKE 'h%%%%%%%' 
                  
    -- Test the ESCAPE clause        
    AND '100%' LIKE '100b%' ESCAPE 'b'
    AND '1000' NOT LIKE '100b%' ESCAPE 'b'
    AND '100_' LIKE '100b_' ESCAPE 'b'
    AND '1000' NOT LIKE '100b_' ESCAPE 'b'
    AND '____' LIKE 'b_b_b_b_' ESCAPE 'b'
    AND '_--_' NOT LIKE 'b_b_b_b_' ESCAPE 'b'
    AND '_%%_' LIKE 'b_b%b%b_' ESCAPE 'b'
    AND '_--_' NOT LIKE 'b_b%b%b_' ESCAPE 'b'
    AND 'b' LIKE 'bb' ESCAPE 'b'
    AND 'bbb' LIKE 'bbbbbb' ESCAPE 'b'
    AND 'bbbH' LIKE 'bbbbbbH' ESCAPE 'b'
                  
    -- NULL semantics
    AND ('HELLO' LIKE NULL) IS NULL
    AND (NULL LIKE NULL) IS NULL
    AND (NULL LIKE 'HELLO') IS NULL
    AND ('HELLO' LIKE 'HELLO' ESCAPE NULL) IS NULL
    AND (NULL LIKE NULL ESCAPE NULL) IS NULL
    AND (NULL LIKE 'HELLO' ESCAPE NULL) IS NULL
    AND (NULL LIKE NULL ESCAPE NULL) IS NULL
                  
) THEN 'T' ELSE 'F' END
FROM (VALUES (1)) t(x)
