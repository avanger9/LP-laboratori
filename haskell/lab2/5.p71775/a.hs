countIf::(Int->Bool)->[Int]->Int
countIf f a = length (filter f a)

pam :: [Int] -> [Int -> Int] -> [[Int]]
pam xs fs = [ map f xs | f <- fs ]


pam2::[Int]->[Int->Int]->[[Int]]
pam2 xs fs = [ map (flip ($) x) fs | x <- xs ]


filterFoldl :: (Int -> Bool) -> (Int -> Int -> Int) -> Int -> [Int] -> Int
filterFoldl p f i xs = foldl f i (filter p xs)

insert :: (Int -> Int -> Bool) -> [Int] -> Int -> [Int]
insert _ [] x = [x]
insert pr (head:tail) x
    | pr x head = x:head:tail
    | otherwise = head:(insert pr tail x)

insertionSort :: (Int -> Int -> Bool) -> [Int] -> [Int]
insertionSort _ [] = []
insertionSort pr xs = foldl (insert pr) [] xs

