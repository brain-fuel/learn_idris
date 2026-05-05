module Main

import System.File

%default total

-- New idea: `exists : HasIO io => String -> io Bool` returns `True` if
-- a path exists and is readable. Useful when you want to branch BEFORE
-- attempting to read.
--
-- `exists` is exported from `System.File.Meta`, but `System.File`
-- re-exports it, so the import above is enough.
--
-- TODO: replace `FIXME` so the program prints `found` if `/etc/hostname`
--       exists, and `missing` otherwise. Idiom:
--           if !(exists "/etc/hostname") then ... else ...
--       The `!` prefix unwraps an `IO Bool` inside a `do` block.

main : IO ()
main = putStrLn "FIXME"
