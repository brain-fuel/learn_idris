module Main

%default total

-- New idea: you can define your OWN data types with `data`. Each
-- constructor is capitalized and lists what it carries:
--
--     data Expr = Lit Int | Add Expr Expr | Mul Expr Expr
--
-- Now `Lit 7`, `Add (Lit 1) (Lit 2)`, and `Mul (Lit 3) (Lit 4)` are all
-- values of type `Expr`. To USE one, pattern-match on the constructor.
--
-- This recap pulls together: top-level type signature, recursion,
-- pattern matching on a custom data type.
--
-- TODO: fill in the `Mul` case of `eval`. The right answer is
--       `eval a * eval b` (mirrors the `Add` case but multiplies).

data Expr = Lit Int | Add Expr Expr | Mul Expr Expr

eval : Expr -> Int
eval (Lit n)   = n
eval (Add a b) = eval a + eval b
eval (Mul a b) = 0

main : IO ()
main = printLn (eval (Add (Lit 2) (Mul (Lit 3) (Lit 4))))  -- 14
