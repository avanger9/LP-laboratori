-- problema 1

mconcat::[[a]]->[a]

mconcat2 l = [x | y<-l, x<-l]
mconcat (x:xs) = x:mconcat xs

mconcat3::[[[a]]]->[a]

mconcat3 l = foldr f [] l
	where f n a = a ++ mconcat n

mconcat3' :: (b->c)->(a->c)
mconcat3' l = concat (concat l)

-- problema 2

fold2r::(a->b->c->c)->c->[a]->[b]->c

fold2r f ini a b = foldr (uncurry f) ini $ zip a b

-- problema 3

mix::[a]->[a]->[a]
mix xs [] = xs
mix [] ys = ys
mix (x:xs) (y:ys) = x:y:mix xs ys

min' xs ys = fold2r f [] xs ys
	where
		f x y ls = x y ls

lmix::[Int]->[a]->[a]

lmix xs ys = foldr f' ys xs
	where
		f' ls n = min(drop n ls) (take n ls)

-- problema 5

data BTree a = Empty | Node a (BTree a) (BTree b) deriving (Show)

buildTreeF :: [[a]] -> BTree a

