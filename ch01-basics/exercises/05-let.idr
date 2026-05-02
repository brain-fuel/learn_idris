module Main

%default total

-- New idea: a `let` binding gives a value a name. The name and value
-- are stuck together for the rest of the scope.
--
--       let favorite = 7
--           \---/    \-/
--             |       value going in
--             name
--       (`let` is the keyword that introduces a binding)
--
-- TODO: print `favorite` TWICE. (Add another `printLn favorite` line below.)

main : IO ()
main = do
  let favorite = 7
  printLn favorite
