absValue :: Int -> Int

absValue x
	| x < 0 = -x
	| otherwise = x
	
power :: Int -> Int -> Int

power x 0 = 1
power x n
	| even n = z * z
	| odd n = z*z*x
	where z = power x (div n 2)

slowFib :: Int -> Int

slowFib 0 = 0
slowFib 1 = 1
slowFib n = slowFib (n-1) + slowFib (n-2)

quickFib :: Int -> Int
quickFib 0 = 0
quickFib 1 = 1
quickFib n = fst (qF' n)

qF' :: Int -> (Int, Int)
qF' 0 = (0,0)
qF' 1 = (1,0)
qF' n = (fn, fn1)
		where
			(fn1, fn2) = qF' (n-1)
			fn = fn1 + fn2
			
isPrime :: Int -> Bool

isPrime 1 = False
isPrime n = not (hasDivisor n 2)
	where
		hasDivisor :: Int -> Int -> Bool
		hasDivisor n c
			| n == c = False
			| mod n c == 0 = True
			| otherwise = hasDivisor n (c+1)

isPrime1 1 = False
isPrime1 n = not (hasDivisor n 2)
	where
		hasDivisor :: Int -> Int -> Bool
		hasDivisor n c
			| c*c > n = False
			| mod n c == 0 = True
			| otherwise = hasDivisor n (c+1)


-- int, integer, double, float, bool, char
-- (t1, t2..) -> tuples, productes cartesians de tipus
-- [t] -> llistes
