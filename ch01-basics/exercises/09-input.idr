module Main

%default total

-- New idea: `getLine` reads one line of input from the terminal.
-- It's an action that hands back a String, so you bind it with `<-`:
--
--       answer <- getLine
--       \----/    \-----/
--          name        action that produces the value
--       (`<-` says "run the action, then call its result `answer`")
--
-- TODO: change the question so it asks for the user's age (instead of name).
--       Then run the program and type in your real age.

main : IO ()
main = do
  putStr "What is your name? "
  answer <- getLine
  putStrLn ("You said: " ++ answer)
