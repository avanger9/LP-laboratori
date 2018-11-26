llarg :: [a] -> Int

llarg [] = 0
--llarg (x:xs) = 1 + llarg xs
llarg (_:xs) = 1 + llarg xs
