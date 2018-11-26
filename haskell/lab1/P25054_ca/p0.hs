myLength::[Int]->Int

myLength []=0
myLength (_:xs) = 1+myLength xs

myLength'::[Int]->Int
myLength' xs = length xs

myMaximum::[Int]->Int

myMaximum [x] = x
myMaximum (x:xs)
	| (myMaximum xs) > x = myMaximum xs
	| otherwise = x 

myMaximum'::[Int]->Int
myMaximum' [x] = x
myMaximum' (x:xs) = max x (myMaximum' xs)

myMaximum''::[Int]->Int
myMaximum'' x = maximum x

average::[Int]->Float

average xs = sumLlista xs / fromIntegral (length xs)
	where
		sumLlista::[Int]->Float
		sumLlista [] = 0.0
		sumLlista (x:xs) = fromIntegral x + (sumLlista xs)

average'::[Int]->Float
average' xs = fromIntegral (sum xs) / fromIntegral (length xs)

buildPalindrome::[Int]->[Int]
buildPalindrome [] = []
buildPalindrome xs = reverse xs ++ xs

buildPalindrome'::[Int]->[Int]

buildPalindrome' [] = []
buildPalindrome' xs = reverseList xs ++ xs
	where
		reverseList::[Int]->[Int]
		reverseList ts = last ts : reverseList (init ts)

remove::[Int]->[Int]->[Int]
remove xs [] = xs
remove [] _ = []
remove xs (y:ys) = remove (delete y xs) ys
	where
		delete::Int->[Int]->[Int]
		delete _ [] = []
		delete y (x:xs)
			| y == x = delete y xs
			| otherwise = x:(delete y xs) 

flatten::[[Int]]->[Int]
flatten [] = []
flatten [x] = x
flatten (x:xs) = x ++ flatten xs


oddsNevens::[Int]->([Int],[Int])
oddsNevens [] = ([],[])
-- filter [condicio a filtrar] list
oddsNevens x = (filter odd x, filter even x)

primeDivisors::Int->[Int]
primeDivisors x = divisorPrimer 2
	where
		divisorPrimer::Int->[Int]
		divisorPrimer n
			| n == x+1 = []
			| mod x n == 0 && isPrime n = n:divisorPrimer (n+1)
			| otherwise = divisorPrimer (n+1)
			where
				isPrime :: Int -> Bool
				isPrime 1 = False
				isPrime n = not (hasDivisor n 2)
					where
						hasDivisor :: Int -> Int -> Bool
						hasDivisor n c
							| n == c = False
							| mod n c == 0 = True
							| otherwise = hasDivisor n (c+1)

primeDivisors'::Int->[Int]
primeDivisors' x = [y | y<-[0..x], isPrime' y && mod x y == 0]
	where
		isPrime'::Int->Bool
		isPrime' 0 = False
		isPrime' 1 = False
		isPrime' x = (0 == length [y | y <- [2..x-1], mod x y == 0])
