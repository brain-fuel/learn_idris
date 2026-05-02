module Main

%default total

-- Goal: make the program say TWO things after asking for a name.
-- TODO: add ONE more `putStrLn` line below the existing one. Make it print
--       any message you want, using `name` somewhere in it.
--       Example: putStrLn ("Your name has cool letters in it, " ++ name ++ ".")

main : IO ()
main = do
  putStrLn "What is your name?"
  putStr "> "
  name <- getLine
  putStrLn ("Hi, " ++ name ++ ".")
