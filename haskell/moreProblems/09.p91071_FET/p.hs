quicksort :: Ord a => [a] -> [a]
quicksort []     = []
quicksort (p:xs) = (quicksort lesser) ++ [p] ++ (quicksort greater)
    where
        lesser  = filter (< p) xs
        greater = filter (>= p) xs

select:: Ord a => [a] -> Int -> a
select xs k = select' xs k

select' [x] 0 = x
select' xs k
		| k == 1 = minimum xs
		| k == n = maximum xs
		| otherwise = head $ drop (k-1) $ quicksort xs
		where
			n = length xs