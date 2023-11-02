-- check math functions defined in the standard

-- ISO 9075-2:2023(E)
-- 6.31 <numeric value function>

SELECT CASE WHEN (
  abs( 0) = 0 AND
  abs(-1) = 1 AND
  abs(-1) = 1 AND

  mod( 2, 1) =  0 AND
  mod(-3, 1) =  0 AND
  mod(-3, 2) = -1 AND
  mod(-3, 3) =  0 AND
  mod(-3, 4) = -3 AND
  mod(-3, 5) = -3 AND

  ln(0.5) BETWEEN -0.69315 AND -0.69314 AND
  ln(1.0) = 0                           AND
  ln(1.5) BETWEEN  0.40546 AND  0.40547 AND

  exp(-1) BETWEEN 0.36787 AND 0.36788 AND
  exp( 0) = 1                         AND
  exp( 1) BETWEEN 2.71828 AND 2.71829 AND

  power( 0, 0) =  1 AND
  power(10, 0) =  1 AND
  power( 3, 1) =  3 AND
  power( 3, 2) =  9 AND
  power( 3, 3) = 27 AND

  sqrt(       2) BETWEEN    1.41421 AND    1.41422 AND
  sqrt(       4) = 2                               AND
  sqrt(       9) = 3                               AND
  sqrt(      16) = 4                               AND
  sqrt( 1000000) = 1000                            AND
  sqrt(10000000) BETWEEN 3162.27766 AND 3162.27767 AND

  floor(1.2) = 1 AND
  floor(1.8) = 1 AND

  ceil(1.2) = 2 AND
  ceil(1.8) = 2 AND

  log(2, 1) = 0                         AND
  log(2, 2) = 1                         AND
  log(3, 2) BETWEEN 0.63092 AND 0.63093 AND

  sin(-1.0 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND
  sin(-0.5 * acos(-1)) BETWEEN -1.000001 AND -0.999999 AND
  sin( 0             ) BETWEEN -0.000001 AND  0.000001 AND
  sin(+0.5 * acos(-1)) BETWEEN  0.999999 AND  1.000001 AND
  sin(+1.0 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND

  cos(-1.0 * acos(-1)) BETWEEN -1.000001 AND -0.999999 AND
  cos(-0.5 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND
  cos( 0             ) BETWEEN  0.999999 AND  1.000001 AND
  cos(+0.5 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND
  cos(+1.0 * acos(-1)) BETWEEN -1.000001 AND -0.999999 AND

  tan(-1.0 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND
  tan( 0             ) BETWEEN -0.000001 AND  0.000001 AND
  tan(+1.0 * acos(-1)) BETWEEN -0.000001 AND  0.000001 AND

  asin(-1.0) BETWEEN -1.570797 AND -1.570796 AND
  asin(-0.5) BETWEEN -0.523599 AND -0.523598 AND
  asin( 0.0) BETWEEN -0.000001 AND  0.000001 AND
  asin(+0.5) BETWEEN  0.523598 AND  0.523599 AND
  asin(+1.0) BETWEEN  1.570796 AND  1.570797 AND

  acos(-1.0) BETWEEN  3.141592 AND  3.141593 AND
  acos(-0.5) BETWEEN  2.094395 AND  2.094396 AND
  acos( 0.0) BETWEEN  1.570796 AND  1.570797 AND
  acos(+0.5) BETWEEN  1.047197 AND  1.047198 AND
  acos(+1.0) BETWEEN -0.000001 AND  0.000001 AND

  atan(-1.0) BETWEEN -0.785399 AND -0.785398 AND
  atan(-0.5) BETWEEN -0.463648 AND -0.463647 AND
  atan( 0.0) BETWEEN -0.000001 AND  0.000001 AND
  atan(+0.5) BETWEEN  0.463647 AND  0.463648 AND
  atan(+1.0) BETWEEN  0.785398 AND  0.785399
) THEN 'T' ELSE 'F' END
FROM (VALUES (1)) something(x)
