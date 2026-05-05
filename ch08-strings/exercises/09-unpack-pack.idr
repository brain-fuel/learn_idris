module Main

%default total

-- New idea: a `String` is opaque, so to do per-character work you bridge
-- to a `List Char` and back:
--
--     unpack : String -> List Char
--     pack   : List Char -> String
--
-- `reverse` (from the `List` API) reverses a list. So
-- `pack (reverse (unpack s))` reverses a string.
--
-- TODO: replace `FIXME` with `reverse` so `reverseStr "hello"` prints
--       `olleh`.

reverseStr : String -> String
reverseStr s = pack (id (unpack s))

main : IO ()
main = putStrLn (reverseStr "hello")
