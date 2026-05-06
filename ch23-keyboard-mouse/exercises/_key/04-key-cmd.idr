module Main

%default total

mkKeyCmd : String -> String
mkKeyCmd key = "xdotool key " ++ key

main : IO ()
main = putStrLn (mkKeyCmd "Return")
