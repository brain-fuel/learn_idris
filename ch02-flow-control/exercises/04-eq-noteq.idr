module Main

%default total

-- New idea: `==` checks if two values are equal; `/=` is "not equal"
-- (the same thing as Python's `!=`). Both return `Bool`.
--
-- TODO: replace the placeholder `False` so the program prints
--       `different` whenever `x` and `y` are unequal. (Hint: use `/=`.)

main : IO ()
main = do
  let x = 3
  let y = 4
  putStrLn (if False then "different" else "same")
