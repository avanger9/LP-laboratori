pot :: Int -> Int -> Int

pot x 0 = 1
pot x y = x * pot x (y-1)
