module Main

import Data.String

%default total

-- New idea: `Data.String.unlines : List String -> String` joins lines
-- with newlines (and adds a trailing newline). Combined with `map`, you
-- can turn a list of strings into a Markdown bullet list.
--
-- TODO: complete `bulletList` so that
--           bulletList ["milk", "eggs", "bread"]
--             == "- milk\n- eggs\n- bread\n"
--       Hint: `unlines (map mkItem xs)` where `mkItem s = "- " ++ s`.

bulletList : List String -> String
bulletList _ = ""

main : IO ()
main = putStr (bulletList ["milk", "eggs", "bread"])
