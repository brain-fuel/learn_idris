module Main

%default total

-- New idea: `for_` walks a list and runs an action on each element. The
-- shape is `for_ xs $ \name => action-using-name`. The `\name => ...` is
-- a lambda -- a tiny anonymous function. (Mind the FAT arrow `=>` -- the
-- skinny arrow `->` is for type signatures.)
--
-- TODO: replace `FIXME` with three string names, like
--       `["Alice", "Bob", "Carol"]`. The program will greet each one.

main : IO ()
main = for_ ["FIXME"] $ \name => putStrLn ("Hi, " ++ name)
