module Main

import Data.String
import Data.List1

%default total

-- KEY: split text into rows on `\n`, then each row on `,`.

splitFields : String -> List String
splitFields s = forget (split (== ',') s)

splitRows : String -> List (List String)
splitRows s = map splitFields (forget (split (== '\n') s))

main : IO ()
main = do
  let text = "Ada,36\nBob,29"
  putStrLn "rows:"
  for_ (splitRows text) printLn
