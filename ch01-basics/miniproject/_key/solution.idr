module Main

%default total

main : IO ()
main = do
  putStr "An animal: "
  animal <- getLine
  putStr "A verb: "
  verb <- getLine
  putStr "A place: "
  place <- getLine
  putStr "A funny adjective: "
  adjective <- getLine
  putStrLn ""
  putStrLn ("Once upon a time, a " ++ adjective ++ " " ++ animal
              ++ " decided to " ++ verb ++ " all the way to " ++ place ++ ".")
  putStrLn "Everyone there was very surprised."
  putStrLn "The end."
