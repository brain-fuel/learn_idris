module Main

%default total

showPixel : (Int, Int, Int) -> String
showPixel (r, g, b) = show r ++ " " ++ show g ++ " " ++ show b

main : IO ()
main = putStrLn (showPixel (255, 0, 64))
