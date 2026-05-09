module Main

%default total

-- Birthday Card miniproject.
--
-- Ask the user for a name and an age, then print a 2-line birthday card.
--
-- Run with the fixture (from the repo root):
--   cat ch00-hello/miniproject/fixtures/input.txt \
--     | idris2 --no-banner --exec main ch00-hello/miniproject/solution.idr
--
-- TODO 1: replace the first FIXME prompt with a real question asking for
--         the recipient's name (e.g. "What's the recipient's name?").
-- TODO 2: read the name from input. Use `getLine`, the same way `hello.idr`
--         did. Replace `let name = "FIXME"` with `name <- getLine`.
-- TODO 3: replace the second FIXME prompt with a real question asking for
--         the recipient's age.
-- TODO 4: read the age the same way you read the name. (Keep it as a
--         String — we won't parse numbers until ch01.)
-- TODO 5: replace the two FIXME card lines with two real lines that
--         include both `name` and `age`. Use `++` to glue strings, like
--         `putStrLn ("Happy birthday, " ++ name ++ "!")`.

main : IO ()
main = do
  putStrLn "FIXME: ask for the name"
  let name = "FIXME"
  putStrLn "FIXME: ask for the age"
  let age = "FIXME"
  putStrLn "FIXME: line 1 of card"
  putStrLn "FIXME: line 2 of card"
