fact :: Integer -> Integer

--fact 0 = 1
--fact n = n * fact(n-1)

{-
fact n
    | n == 0 = 1
	| otherwise = n * fact(n-1)

fact n = case n of
	0 -> 1
	otherwise -> n*fact(n-1)
-}

fact n = 
	if n == 0 then 1
	else n*fact(n-1) 

not :: Bool -> Bool

pot :: Int -> Int -> Int

pot x 0 = 1
pot x y = x*pot x (y-1)
