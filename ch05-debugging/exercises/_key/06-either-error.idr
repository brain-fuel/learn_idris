module Main

%default total

safeDiv : Int -> Int -> Either String Int
safeDiv x 0 = Left "divide by zero"
safeDiv x y = Right (x `div` y)

main : IO ()
main = case safeDiv 10 0 of
         Right r => printLn r
         Left e  => putStrLn e
