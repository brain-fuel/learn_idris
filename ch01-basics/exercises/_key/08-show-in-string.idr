module Main

%default total

main : IO ()
main = do
  let age = 42
  putStrLn ("I am " ++ show age ++ " years old.")
