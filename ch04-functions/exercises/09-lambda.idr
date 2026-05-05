module Main

%default total

-- New idea: an anonymous function (a "lambda") lets you write a tiny
-- function without naming it. The syntax is
--
--     \x => x + 1
--      ^^^   ^^^^^
--      arg   body
--
-- You can pass a lambda straight into another function. Below, `map`
-- applies a function to every element of a list.
--
-- TODO: replace `FIXME` with `\x => x * 2` so the program prints
--       `[2, 4, 6, 8, 10]`.

main : IO ()
main = printLn (map (\x => x) [1..5])
