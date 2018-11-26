
myMap :: (a -> b) -> [a] -> [b]
myMap function list = [ function element | element <- list ]

myFilter :: (a -> Bool) -> [a] -> [a]
myFilter function list = [ element | element <- list, function element ]

myZipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
myZipWith func l1 l2 = [ func x y | (x, y) <- zip l1 l2 ]

thingify :: [Int] -> [Int] -> [(Int, Int)]
thingify l1 l2 = [ (i, j) | i <- l1, j <- l2, mod i j == 0 ]

factors :: Int -> [Int]
factors x = [ factor | factor <- [1..x], mod x factor == 0 ]