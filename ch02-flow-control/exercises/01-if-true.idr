module Main

%default total

-- New idea: `if cond then x else y` is ONE expression. It always returns
-- a value, so it always needs an `else`. Both branches must have the
-- same type.
--
-- TODO: replace `FIXMEbig` with `"big"` and `FIXMEsmall` with `"small"`
--       so the program prints `big` (because `n` is 5, which is greater
--       than 3). Note the quotes: those need to be String literals.

main : IO ()
main = do
  let n = 5
  putStrLn (if n > 3 then "FIXMEbig" else "FIXMEsmall")
