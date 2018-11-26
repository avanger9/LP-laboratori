import Data.Char (digitToInt)

diffSqrs::Int->Int
diffSqrs n = a^2 - b
	where
		a = (sum $ takeWhile (< n+1) $ iterate (+1) 1)
		b = sum $ map (^2) $ takeWhile (< n+1) $ iterate (+1) 1

triples n = [ (x,y,z) | x <- [0..n], y <- [x..n], z <- [y..n], x^2+y^2==z^2, x>0, y>0 ]

pythagoreanTriplets :: Int -> [(Int,Int,Int)]
pythagoreanTriplets n = filter (\(a,b,c) -> a+b+c==n) $ triples n

-- tartaglia
-- next row function
nextRow :: [Integer] -> [Integer]
nextRow row = zipWith (+) ([0] ++ row) (row ++ [0])
 
-- tartaglia triangle (binomial coefficients)
tartaglia :: [[Integer]]
tartaglia = iterate nextRow [1]



-- sum of digits
sumDigits :: Integer -> Integer
sumDigits n = toInteger.sum.map digitToInt $ show n



-- digitalRoot
digitalRoot :: Integer -> Integer
digitalRoot n = head.dropWhile (>9) $ iterate sumDigits n