module Main

%default total

-- New idea: the simplest debugging tool of all is `printLn` at boundaries.
-- When you don't trust a value, print it. The compiler can catch many bugs
-- at compile time -- but `printLn` still earns its keep when the *logic*
-- is wrong (right type, wrong number, missing step).
--
-- Run this file as-is. It compiles cleanly and prints `done`. But the
-- whole point of computing `doubled` was to SEE its value -- and we
-- never print it. That's the bug: a silent intermediate.
--
-- TODO: add a line `printLn doubled` between the `let` and `putStrLn "done"`.
-- After the fix, running the program should print `42` then `done`.

main : IO ()
main = do
  let doubled = 21 * 2
  -- (add `printLn doubled` here)
  putStrLn "done"
