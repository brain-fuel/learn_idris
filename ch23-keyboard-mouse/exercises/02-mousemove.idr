module Main

%default total

-- New idea: build the shell command as a String first; run it later.
-- Separating the command-building from the IO call makes it easy to
-- test the pure part in your head (and from the REPL) before letting
-- the OS do anything.
--
-- TODO: complete `mkMouseMoveCmd` so that
--           mkMouseMoveCmd 100 200 == "xdotool mousemove 100 200"
--       Use `show` to render the integers.

mkMouseMoveCmd : Int -> Int -> String
mkMouseMoveCmd x y = ""

main : IO ()
main = putStrLn (mkMouseMoveCmd 100 200)
