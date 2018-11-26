myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl _ a [] = a
myFoldl f a (x:xs) = myFoldl f (f a x) xs

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr _ a [] = a
myFoldr f a (x:xs) = f x (myFoldr f a xs)

myIterate :: (a -> a) -> a -> [a]
myIterate f a = a : myIterate f (f a)

myUntil :: (a -> Bool) -> (a -> a) -> a -> a
myUntil b f a = head (filter b (myIterate f a))


myMap::(a->b)->[a]->[b]
myMap f xs = [f b | b<-xs]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter f xs = [a | a<-xs, f a]

myAll :: (a -> Bool) -> [a] -> Bool
myAll p xs = and $ myMap p xs

myAny :: (a -> Bool) -> [a] -> Bool
myAny f list = or (map f list)

myZip :: [a] -> [b] -> [(a, b)]
myZip _ [] = []
myZip [] _ = []
myZip (a:as) (b:bs) = (a, b) : myZip as bs

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith func l1 l2 = [ func x y | (x, y) <- zip l1 l2 ]
