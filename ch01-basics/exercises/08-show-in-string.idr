module Main

%default total

-- New idea: in Idris, strings hold ONLY text. To put a number inside a
-- string, you have to turn it into text first with `show`.
--
--       let age = 30
--       putStrLn ("I am " ++ show age ++ " years old.")
--                            \--------/
--                            turns 30 into the string "30"
--
-- (Python's f-strings do this for you. Idris asks you to be explicit.)
--
-- TODO: change `age` to your real age. Run and see the sentence change.

main : IO ()
main = do
  let age = 30
  putStrLn ("I am " ++ show age ++ " years old.")
