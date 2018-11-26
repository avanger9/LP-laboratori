flatten :: [[Int]] -> [Int]
flatten xs = foldr (++) [] xs

flatten'::[[Int]]->[Int]
flatten' xs = concat xs

myLength::String->Int
myLength = foldl (const . (+1)) 0
-- foldl ens permet anar sumant +1 a cada element que ens trobem a la llista

myLength'::String->Int
myLength' xs = sum $ map (const 1) xs
-- a la llista xs li donem 1 per cada elements i ho sumem

myLength''::String->Int
myLength'' xs = foldl (\y x -> y + 1) 0 xs

myReverse::[Int]->[Int]
myReverse xs = foldl (flip (:)) [] xs

myReverse' :: [Int] -> [Int] 
myReverse' a = foldr (\x y -> y++[x]) [] a

countIn::[[Int]]->Int->[Int]
countIn xs n = map (length) $ map (filter (==n)) xs

countIn' :: [[Int]] -> Int -> [Int]
countIn' x a = map (\l -> length (filter (== a) l)) x

firstWord::String->String
firstWord xs = takeWhile (/= ' ') $ dropWhile (== ' ') xs
-- amb drop while treiem els primers en blanc 
-- i el takewhile agafara els elements que siguin diferents als espais en blanc