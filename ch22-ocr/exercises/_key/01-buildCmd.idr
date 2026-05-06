module Main

%default total

mkCmd : (img : String) -> (out : String) -> String
mkCmd img out =
  "tesseract " ++ img ++ " " ++ out ++ " -l eng 2>/dev/null"

main : IO ()
main = putStrLn (mkCmd "receipt.png" "/tmp/out")
