module Main

%default total

mkMouseMoveCmd : Int -> Int -> String
mkMouseMoveCmd x y = "xdotool mousemove " ++ show x ++ " " ++ show y

main : IO ()
main = putStrLn (mkMouseMoveCmd 100 200)
