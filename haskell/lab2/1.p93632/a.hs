eql::[Int]->[Int]->Bool
eql xs ys = (and $ zipWith (==) xs ys) && length xs == length ys


prod::[Int]->Int
prod xs = foldl (*) 1 xs

prodOfEvens::[Int]->Int
prodOfEvens xs = product $ filter even xs

powersOf2::[Int]
powersOf2 = [2^x | x<-[0..]]

powersOf2' = iterate (*2) 1

scalarProduct::[Float]->[Float]->Float
scalarProduct xs ys = sum $ zipWith (*) xs ys




{-
myZipWith::(a->b->c)->[a]->[b]->[c]
myZipWith f [] _ = []
myZipWith f _ [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith xs ys
-}