fact1 1 = 1
fact1 n = n * fact1(n-1)

fact2 n = product [1..n]

fact3 n
	| n == 1 = 1
	| otherwise = n * fact4(n-1)

fact4 n = if n == 1 then 1 else n * fact5(n-1)

fact5 n = let ys = 1 : map(\(a,b)->a*b) (zip [1..n] ys) in last ys

fact6 n = foldl (*) 1 [1..n]

fact7 1 = 1
fact7 n = fact7(n-1) * n

-- infinite list
fac = iterate (\(a,b)->(a+1,a*b)) (1,1)

fact8 :: Integer -> Integer
fact8 n = snd.head $ drop (fromIntegral n) fac 
