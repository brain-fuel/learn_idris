module Main

import Data.String
import Data.List

%default total

extension : String -> String
extension s =
  let cs = unpack s in
  case break (== '.') (reverse cs) of
    (revExt, '.' :: _) => toLower (pack ('.' :: reverse revExt))
    _ => ""

main : IO ()
main = printLn (extension "P.JPG")
