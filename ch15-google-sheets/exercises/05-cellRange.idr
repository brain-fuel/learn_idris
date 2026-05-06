module Main

%default total

-- Exercise 05: build a Sheets A1-notation range.
--
-- A Google Sheets range looks like `Sheet1!A1:B2`. Format:
--
--     <sheetName> !  <topLeft> :  <bottomRight>
--
-- TODO: change `cellRange` so it returns `sheet ++ "!" ++ tl ++ ":" ++ br`.
--       For the call below, expected output is `Sheet1!A1:B2`.

cellRange : (sheet : String) -> (tl : String) -> (br : String) -> String
cellRange sheet tl br = "FIXME"  -- TODO: concatenate sheet/tl/br with "!" and ":"

main : IO ()
main = putStrLn (cellRange "Sheet1" "A1" "B2")
