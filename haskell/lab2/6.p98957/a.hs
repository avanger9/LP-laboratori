ones::[Integer]
ones = 1:ones

nats::[Integer]
nats = 0:map (+1) nats

nats' = iterate (+1) 0

ints::[Integer]
ints = tail $ concat $ map f nats
	where f x = [x, -x]

triangulars::[Integer]
triangulars = trs 1
	where trs n = 0 : map (+n) (trs (n+1))

fibs::[Integer]
fibs = 0:1: zipWith (+) fibs (tail fibs)

factorials::[Integer]
factorials = fact' 1
	where fact' n = 1: map (*n) (fact' (n+1))

------------------ PRIMERS -------------------
isPrimeRec :: Integer -> Integer -> Bool
isPrimeRec x d
    | d == 1 = True
    | mod x d == 0 = False
    | otherwise = isPrimeRec x (d - 1)

isPrime :: Integer -> Bool
isPrime x
    | x == 0 = False
    | x == 1 = False
    | otherwise = isPrimeRec x (floor (sqrt (fromIntegral x)))

primes :: [Integer]
primes = primers 2
     where
          primers :: Integer -> [Integer]
          primers x
               | isPrime x = x : primers (x + 1)
               | otherwise = primers (x + 1)

------------------------------------ hammings  -------------------------------------
------------------------------------------------------------------------------------
hammings :: [Integer]
hammings = 1 : merge3 (map (* 2) hammings) (map (* 3) hammings) (map (* 5) hammings)

merge3 :: [Integer] -> [Integer] -> [Integer] -> [Integer]
merge3 xs ys zs = merge2 (merge2 xs ys) zs

merge2 :: [Integer] -> [Integer] -> [Integer] 
merge2 a [] = a
merge2 [] b = b
merge2 (a:as) (b:bs)
      | a < b  = a : (merge2 as (b:bs))
      | b < a  = b : (merge2 (a:as) bs)
      |otherwise = merge2 (a:as) bs

------------------------------------------------------------------------------------
------------------------------------ lookNsay  -------------------------------------
------------------------------------------------------------------------------------
lookNsay :: [Integer]
lookNsay = iterate count 1

count :: Integer -> Integer
count a = read $ next $ show a

next :: [Char] -> [Char]
next [] = []
next cs = (show n) ++ [pr] ++ next cua
  where 
    pr = head cs
    n = length $ takeWhile ( == pr) cs
    cua = dropWhile ( == pr) cs

------------------------------------------------------------------------------------
----------------------------------- tartaglia  -------------------------------------
------------------------------------------------------------------------------------
tartaglia :: [[Integer]]
tartaglia = (iterate (pascal) [1])

pascal :: [Integer] -> [Integer]
pascal xs = zipWith (+) (xs ++ [0]) ([0] ++ xs)
