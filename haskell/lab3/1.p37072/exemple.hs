data Bool = False | True

data Llista a = Buida | Cons a Llista
data [a] = [] | 


ll :: Llista Int
ll = Cons 1 (Cons 2 Buida)

ll2::Llista Char
ll2 = Cons 'a' (Cons 'b' Buida)

llargada::Llista a -> Int
llargada Buida = 0
llargada (Cons x xs) = 1 + llargada xs


data Arbin a = Fulla | Node a Arbin Arbin

mida::Arbin a -> Int
mida Fulla = 0
mida (Node x fe fd) = 1 + mida fe  