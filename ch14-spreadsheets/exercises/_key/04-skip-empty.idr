module Main

%default total

-- Exercise 04 KEY: drop rows that are empty or just one empty field.

isEmptyRow : List String -> Bool
isEmptyRow []     = True
isEmptyRow [""]   = True
isEmptyRow _      = False

skipEmpty : List (List String) -> List (List String)
skipEmpty rows = filter (\r => not (isEmptyRow r)) rows

main : IO ()
main = do
  let rs = [["a","b"], [], [""], ["c","d"]]
  putStrLn (show (skipEmpty rs))
