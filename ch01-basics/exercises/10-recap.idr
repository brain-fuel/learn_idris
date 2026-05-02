module Main

%default total

-- New idea: you already know everything in this file -- it's a recap.
-- This program asks the user TWO questions and prints a sentence using both.
--
-- TODO: replace each "FIXME" placeholder with a `getLine` so the program
--       asks the user for their name and age.
--
-- Hint: look back at exercise 09 for how `getLine` works. Each question
-- needs its own `putStr "..."` and `<- getLine`.

main : IO ()
main = do
  let name = "FIXME"
  let age = "FIXME"
  putStrLn ("Hi " ++ name ++ ", you are " ++ age ++ " years old.")
