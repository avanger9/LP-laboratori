absValue::Int->Int
absValue x
    | (x < 0) = -x
    | otherwise = x

power::Int->Int->Int
power x y
    | y == 0 = 1
    | otherwise = x*(power x (y-1))

isRprime::Int->Int->Bool
isRprime x y
    | y == 1 = True
    | x `mod` y == 0 = False
    | otherwise = isRprime x (y-1)

isPrime::Int->Bool
isPrime x
    | (x == 0 || x == 1) = False
    | otherwise = isRprime x (x-1)

slowFib::Int->Int
slowFib x
    | (x == 0 || x == 1) = x
    | otherwise = slowFib (x-1) + slowFib(x-2)

quickFib::Int->Int
quickFib x = head (fib x)
fib 0 = [0,0]
fib 1 = [1,0]
fib n = [f1+f2,f1] where (f1:f2:r) = fib(n-1)
    

-- main = do
--    line <- getLine
--    let x = (read line::Int)
--    print (absValue x)

