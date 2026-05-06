module Main

%default total

header : (w : Nat) -> (h : Nat) -> String
header w h = "P3\n" ++ show w ++ " " ++ show h ++ "\n255\n"

main : IO ()
main = putStr (header 4 3)
