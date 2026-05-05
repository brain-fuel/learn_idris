module Main

%default total

-- New idea: `getLine` reads a line of input as a `String`. You can
-- compare strings with `==` and branch on the result the same way as
-- any other `Bool`.
--
-- TODO: replace the placeholder `"yes-FIXME"` with the String literal
--       `"yes"` so that typing `yes` prints `hello!` and anything else
--       prints `goodbye`.

main : IO ()
main = do
  putStr "say yes: "
  answer <- getLine
  if answer == "yes-FIXME" then putStrLn "hello!" else putStrLn "goodbye"
