module Main

%default total

mkH1 : String -> String
mkH1 s = "# " ++ s

main : IO ()
main = putStrLn (mkH1 "Hello")
