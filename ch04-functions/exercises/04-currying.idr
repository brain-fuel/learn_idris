module Main

%default total

-- New idea: passing FEWER arguments than declared is fine. `add 3` is a
-- function that still wants one more number. This is called CURRYING:
-- every multi-arg function is really a chain of one-arg functions.
--
-- TODO: replace `FIXME` so `incBy3` is just `add 3` -- no lambda needed.
--       (Hint: drop the `\n =>` entirely and put the partial application
--       on the right of `=`.)

add : Int -> Int -> Int
add x y = x + y

incBy3 : Int -> Int
incBy3 = \n => 0

main : IO ()
main = printLn (incBy3 10)
