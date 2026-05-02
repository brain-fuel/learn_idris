module Main

%default total

-- Mad Libs starter file.
--
-- TODO 1: replace each `let ... = "FIXME"` with a `getLine` that asks the
--         user the right thing. Look at `../exercises/09-input.idr` for the
--         pattern: putStr the question, then `name <- getLine`.
-- TODO 2: replace the placeholder line with at least three `putStrLn` lines
--         that use `animal`, `verb`, `place`, and `adjective`.

main : IO ()
main = do
  let animal = "FIXME"
  let verb = "FIXME"
  let place = "FIXME"
  let adjective = "FIXME"
  putStrLn ""
  putStrLn "(your story goes here -- use animal, verb, place, adjective)"
