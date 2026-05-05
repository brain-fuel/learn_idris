module Main

%default total

reverseStr : String -> String
reverseStr s = pack (reverse (unpack s))

main : IO ()
main = putStrLn (reverseStr "hello")
