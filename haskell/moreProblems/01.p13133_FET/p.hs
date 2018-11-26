sumMultiples35::Integer->Integer
sumMultiples35 n = sumMultiples35'' n

sumMultiples35' 0 = 0
sumMultiples35' 1 = 0
sumMultiples35' 2 = 0
sumMultiples35' n 
	| (mod n 3 == 0) || (mod n 5 == 0) = n + sumMultiples35' (n-1)
	| otherwise = sumMultiples35' (n-1)

sumMultiples35'' n = (sumMultiples 3 n) + (sumMultiples 5 n) - (sumMultiples 15 n)
	where
		sumMultiples x n = x*n'*(n'+1) `div` 2
			where
				n' = div (n-1) x


fibonacci :: Int -> Integer
fibonacci n = fib n

fib n = last (take (n + 1) (fib' 0 1))
	where
		fib' x y = x : fib' y (x+y)

quickFib :: Int -> Integer
quickFib n = fst (qF' n)

qF' :: Int -> (Integer, Integer)
qF' 0 = (0,0)
qF' 1 = (1,0)
qF' n = (fn, fn + fn1)
	where (fn, fn1) = qF' (n-1)

sumEvenFibonaccis :: Integer -> Integer
sumEvenFibonaccis n = sum (filter even (takeWhile (<n) (listFib 0 1)))
	where listFib x y = x:listFib y (x+y)

-- largest prime factor

largestPrimeFactor :: Integer -> Integer
largestPrimeFactor n = head $ filter (isPrime) $ filter (isFactor n) $ alReves n

alReves :: Integer -> [Integer]
alReves n = takeWhile (>0) $ iterate (sub) (n)

sub :: Integer -> Integer
sub x = x - 1

isFactor :: Integer -> Integer -> Bool
isFactor x y = x `mod` y == 0 

isPrimeRec :: Integer -> Integer -> Bool
isPrimeRec x div
    | div == 1 = True
    | x `mod` div == 0 = False
    | otherwise = isPrimeRec x (div - 1)

isPrime :: Integer -> Bool
isPrime x
    | x == 0 = False
    | x == 1 = True
    | otherwise = isPrimeRec x (floor (sqrt (fromIntegral x)))

-- palindromic 

isPalindromic :: Integer -> Bool
isPalindromic n = and $ zipWith (==) (show n) (reverse $ show n)