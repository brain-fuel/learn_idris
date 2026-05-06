module Main

%default total

mkTypeCmd : String -> String
mkTypeCmd s = "xdotool type \"" ++ s ++ "\""

main : IO ()
main = putStrLn (mkTypeCmd "hello world")
