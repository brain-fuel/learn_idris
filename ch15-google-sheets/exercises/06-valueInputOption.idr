module Main

%default total

-- Exercise 06: a query-string fragment for the Sheets v4 API.
--
-- When you PUT a row to Sheets, you must tell it how to interpret
-- the values. The query string `?valueInputOption=USER_ENTERED`
-- means "treat them like the user typed them in the UI."
--
-- TODO: replace the empty string with the literal
--       "?valueInputOption=USER_ENTERED".

valueInputOption : String
valueInputOption = ""  -- FIXME: return "?valueInputOption=USER_ENTERED"

main : IO ()
main = putStrLn valueInputOption
