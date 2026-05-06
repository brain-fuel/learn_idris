module Main

import System.File

%default total

-- New idea: PPM-P3 is just text, so `writeFile` (from `System.File`)
-- is enough to save a PPM document. The function returns
-- `IO (Either FileError ())`; the cheapest way to "do something with
-- the result" is to ignore it (we already trust /tmp to be writable).
--
-- TODO: replace the body of `writeChart` so it actually writes
--       `body` to `path`. The stub does nothing (`pure ()`). Remember
--       `writeFile` returns `IO (Either FileError ())` — just bind it
--       and discard the result.

covering
writeChart : String -> String -> IO ()
writeChart _ _ = pure ()

covering
main : IO ()
main = do
  writeChart "/tmp/learn_idris_ch21_demo.ppm" "P3\n1 1\n255\n0 0 0\n"
  putStrLn "FIXME"
