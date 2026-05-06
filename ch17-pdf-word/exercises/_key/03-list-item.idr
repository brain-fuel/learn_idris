module Main

%default total

mkItem : String -> String
mkItem s = "- " ++ s

main : IO ()
main = putStrLn (mkItem "milk")
