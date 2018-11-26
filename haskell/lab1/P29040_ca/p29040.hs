insert::[Int]->Int->[Int]

insert [] x = [x]
insert (x:xs) y
	| y < x = y:x:xs
	| otherwise = x:insert xs y

isort::[Int]->[Int]
isort [] = []
isort (x:xs) = insert (isort xs) x


remove::[Int]->Int->[Int]
remove (x:xs) y
	| x == y = xs
	| otherwise = x: remove xs y 


ssort::[Int]->[Int]
ssort [] = []
ssort xs = minv: ssort (remove xs minv)
	where
		minv = minimum xs


merge::[Int]->[Int]->[Int]
merge [] [] = []
merge xs [] = xs
merge [] xs = xs
merge a@(x:xs) b@(y:ys)
	| x < y = x: merge xs b
	| otherwise = y: merge a ys

msort::[Int]->[Int]
msort [] = []
msort [x] = [x]
msort xs = merge (msort x1) (msort x2)
	where
		xx = splitAt (div (length xs) 2) xs
		x1 = fst xx
		x2 = snd xx

qsort::[Int]->[Int]
qsort [] = []
qsort (x:xs) = qsort x1 ++ (x:qsort x2)
	where
		x1 = [y | y <- xs, y <= x]
		x2 = [y | y <- xs, y > x]

genQsort::Ord a=>[a]->[a]
genQsort [] = []
genQsort (x:xs) = genQsort x1 ++ (x:genQsort x2)
	where
		x1 = [a | a <- xs, a <= x]
		x2 = [a | a <- xs, a > x]