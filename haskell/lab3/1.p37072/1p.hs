data Tree a = Node a (Tree a) (Tree a) | Empty deriving (Show)

size :: Tree a -> Int
size Empty = 0
size (Node _ fd fe) = 1 + size fd + size fe

height :: Tree a -> Int
height Empty = 0
height (Node _ fd fe) = 1 + max (height fd) (height fe)

equal :: Eq a => Tree a -> Tree a -> Bool
equal Empty Empty = True
equal Empty _ = False
equal _ Empty = False
equal (Node x1 fd1 fe1) (Node x2 fd2 fe2) = x1 == x2 && equal fe1 fe2 && equal fd1 fd2

isomorphic :: Eq a => Tree a -> Tree a -> Bool
isomorphic Empty Empty = True
isomorphic Empty _ = False
isomorphic _ Empty = False
isomorphic (Node x1 a1 b1) (Node x2 a2 b2) = x1 == x2 &&
		((equal a1 a2 && equal b1 b2) || (equal a1 b2 && equal b1 a2))

preOrder :: Tree a -> [a]
preOrder Empty = []
preOrder (Node x fd fe) = [x] ++ preOrder fd ++ preOrder fe

postOrder :: Tree a -> [a]
postOrder Empty = []
postOrder (Node x fd fe) = postOrder fd ++ postOrder fe ++ [x]

inOrder :: Tree a -> [a]
inOrder Empty = []
inOrder (Node x fd fe) = inOrder fd ++ [x] ++ inOrder fe

breadthFirst :: Tree a -> [a]
breadthFirst t = bfs [t]

bfs :: [Tree a] -> [a]
bfs [] = []
bfs (Empty:ts) = bfs ts
bfs ((Node x fd fe):ts) = x:bfs(ts ++ [fd, fe])

build :: Eq a => [a] -> [a] -> Tree a
build [] [] = Empty
build (x:preorder) inorder = 
		Node x (build leftPreorder  leftInorder ) (build rightPreorder rightInorder)
		    where  
		        leftInorder   = takeWhile (/= x) inorder
		        leftPreorder  = take (length leftInorder) preorder
		        rightPreorder = drop (length leftInorder) preorder
		        rightInorder  = tail (dropWhile (/= x) inorder)

overlap :: (a -> a -> a) -> Tree a -> Tree a -> Tree a
overlap _ tree1 Empty = tree1
overlap _ Empty tree2 = tree2
overlap op (Node x1 a1 b1) (Node x2 a2 b2) = 
		Node (foldl op x1 [x2]) (overlap op a1 a2) (overlap op b1 b2)