module Main

%default total

label : Int -> String
label n =
  if      n `mod` 15 == 0 then "FizzBuzz"
  else if n `mod` 3  == 0 then "Fizz"
  else if n `mod` 5  == 0 then "Buzz"
  else show n

main : IO ()
main = for_ [1..20] $ \i => putStrLn (label i)
