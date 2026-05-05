module Main

%default total

countDown : Nat -> IO ()
countDown Z     = putStrLn "lift off!"
countDown (S k) = do
  printLn (S k)
  countDown k

main : IO ()
main = countDown 5
