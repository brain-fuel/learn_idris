module Main

%default total

-- New idea: `traverse_` is `for_` with the arguments flipped -- the
-- action comes first, then the list. So `for_ xs f` and `traverse_ f xs`
-- do the SAME thing. Pick whichever reads better in context.
--
-- Right now `main` just prints "FIXME". Replace the body with
-- `traverse_ printLn [1..3]` so the program prints 1, 2, 3 instead.

main : IO ()
main = putStrLn "FIXME"
