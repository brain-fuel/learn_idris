module Main

import System.File

%default total

-- New idea: when a file op fails, the `Left` branch carries a
-- `FileError`. `FileError` has a `Show` instance, so you can format it
-- with `show`. For a missing path, `show` yields `"File Not Found"`.
--
-- The stub below IGNORES the `Left` (it discards the result with `_ <-`
-- and lies to the user). Your job: actually inspect the result.
--
-- TODO: replace the body so the program tries
--       `readFile "/no/such/path/at/all"` and either:
--         - prints the contents with `putStr` on `Right`, OR
--         - prints `error: <show err>` on `Left`.
--       Expected on this machine: `error: File Not Found`.

covering
main : IO ()
main = do
  _ <- readFile "/no/such/path/at/all"
  putStrLn "FIXME"
