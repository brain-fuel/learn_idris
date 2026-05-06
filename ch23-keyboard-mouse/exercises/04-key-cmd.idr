module Main

%default total

-- New idea: `xdotool key Return` presses the Return key in the focused
-- window. Other examples: `xdotool key ctrl+c`, `xdotool key Escape`.
-- The key-name argument is appended verbatim — no quoting needed
-- because key names contain no spaces.
--
-- TODO: complete `mkKeyCmd` so that
--           mkKeyCmd "Return"  == "xdotool key Return"
--           mkKeyCmd "ctrl+c"  == "xdotool key ctrl+c"

mkKeyCmd : String -> String
mkKeyCmd key = ""

main : IO ()
main = putStrLn (mkKeyCmd "Return")
