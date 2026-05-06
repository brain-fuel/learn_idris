module Main

%default total

mkH2 : String -> String
mkH2 s = "## " ++ s

main : IO ()
main = putStrLn (mkH2 "Section")
