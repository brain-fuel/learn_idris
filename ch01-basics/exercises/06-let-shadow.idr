module Main

%default total

-- New idea: in Idris, a value cannot change. There is no way to say
-- "make `age` be 100 now." Instead, you write a NEW `let` that shadows
-- the old one for the rest of the scope.
--
-- This is the BIGGEST difference from Python. In Python you would write
-- `age = 100` to update. In Idris you write `let age = 100` -- it is a
-- new name, the old `age` is still 10 if anything could still see it.
--
-- TODO: between the two `printLn age` lines below, add a line that says
--       `let age = 100`. After running, you should see 10 then 100.

main : IO ()
main = do
  let age = 10
  printLn age
  -- (add `let age = 100` here)
  printLn age
