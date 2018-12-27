

func::Char->Int
func x
	| x == 'I' = 1
	| x == 'V' = 5
	| x == 'X' = 10
	| x == 'L' = 50
	| x == 'C' = 100
	| x == 'D' = 500
	| otherwise = 1000	

-- exercici 1. num romans

roman2int::String->Int

roman2int [] = 0
roman2int [x] = func x
roman2int (x:y:xs) 
	| h > p = -p + roman2int(y:xs)
	| otherwise = p + roman2int(y:xs)
	where
		p = func x
		h = func y

-- exercici 2. num romans iteratiu

--roman2int' :: String->Int

--roman2int' xs 

-- exercici 3. arrels

arrels::Float->[Float]

arrels x = arrels' x 1

arrels' :: Float->Int->[Float]
arrels' x 1 = x:arrels' x 2
arrels' x n = (f n):arrels' x (n+1)
	where 
		f 1 = x
		f p = 0.5*(f (p-1) + (x/(f (p-1))))

-- exercici 4. arrel error

arrel::Float->Float->Float
arrel x e = arrel' (arrels x) e

arrel' (x:y:xs) e
	| p <= e = y
	| otherwise = arrel' (y:xs) e
	where p = abs(x-y)

-- exercici 5. arbre

data LTree a = Leaf a | Node (LTree a) (LTree a)

instance Show(a) => Show (LTree a) where
	show (Leaf a) = "{"++(show a)++"}"
	show (Node (a) (b)) = "<"++(show a)++","++(show b)++">"