ones::[Integer]
ones = 1:ones

nats::[Integer]
nats = 0:  map (+1) nats

ints::[Integer]
ints = tail $ concat $ map f nats
	where f x = [x, -x]

triangulars::[Integer]
triangulars = trs 1
	where trs n = 0 : map (+n) (trs (n+1))

fibo::[Integer]
fibo = 0:1: zipWith (+) fibo (tail fibo)

fact::[Integer]
fact = fact' 1
	where fact' n = 1: map (*n) (fact' (n+1))