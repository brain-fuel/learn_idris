module Main

import Language.JSON.Data

%default total

-- Exercise 04: pretty-print JSON.
--
-- `Language.JSON.Data` defines `Show JSON` so `show v` returns a
-- valid JSON serialization (no whitespace).
--
-- TODO: change `render` so it returns `show v` instead of "FIXME".

render : JSON -> String
render v = "FIXME"  -- TODO: use the Show instance: `show v`

main : IO ()
main = putStrLn (render (JString "x"))
