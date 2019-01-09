fun2 (x:l) y = (x.y) l > 0

fun1 x = let y = fst x in (y,y)

--fsmap = foldl $ flip ($)

funn1 g (x,y) = (g x, g y)

funn2 x (y:l) = let s = sum l in if s < x then funn2 x l else y:l