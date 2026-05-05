module Main

%default total

data Expr = Lit Int | Add Expr Expr | Mul Expr Expr

eval : Expr -> Int
eval (Lit n)   = n
eval (Add a b) = eval a + eval b
eval (Mul a b) = eval a * eval b

main : IO ()
main = printLn (eval (Add (Lit 2) (Mul (Lit 3) (Lit 4))))  -- 14
