module Main

%default total

-- New idea: names can hold numbers, and you can do math on them
-- just like with bare numbers.
--
-- TODO: add ONE more `printLn` line below that prints `a` TIMES `b`. (Use `*`.)

main : IO ()
main = do
  let a = 6
  let b = 4
  printLn (a + b)
