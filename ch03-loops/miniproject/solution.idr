module Main

%default total

-- FizzBuzz, 1 to 20.
--
-- Right now `label` just shows the number, so the program prints
-- 1, 2, 3, ... 20 -- no Fizz, no Buzz, no FizzBuzz anywhere.
--
-- TODO: rewrite `label` so it returns the right string for each
--       number. The shape you want is a chain of `if ... else if`:
--           - multiples of 15 say "FizzBuzz"
--           - multiples of 3  say "Fizz"
--           - multiples of 5  say "Buzz"
--           - everything else shows the number itself.
--       The `mod` function is your tool: `n `mod` 3 == 0` is True
--       when `n` is a multiple of 3.

label : Int -> String
label n = show n

main : IO ()
main = for_ [1..20] $ \i => putStrLn (label i)
