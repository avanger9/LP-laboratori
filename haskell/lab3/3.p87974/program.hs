import System.Environment
 
-- main runs the main program
main :: IO ()
main = do
  name <- getLine
  putStrLn $ entrada name


femeni [] = False
femeni (x:[]) = x=='a' || x=='A'
femeni (_:xs) = femeni xs


entrada nom  
	| femeni nom = "Hola maca!" 
	| otherwise = "Hola maco!"
