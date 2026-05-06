module Main

import System.File

%default total

-- New idea: AFTER shelling out to a converter, you usually want to
-- VERIFY that the output file actually appeared. `exists : HasIO io =>
-- String -> io Bool` is the cheap way; `System.File` re-exports it from
-- `System.File.Meta`.
--
-- TODO: replace `pure False` so `checkOutput` returns whether `path`
--       exists. Then, in `main`, print `present` if the file is there
--       and `missing` if not. Hint:
--           if !(checkOutput "...") then putStrLn "present" else putStrLn "missing"

checkOutput : String -> IO Bool
checkOutput _ = pure False

main : IO ()
main = do
  here <- checkOutput "/etc/hostname"
  printLn here
