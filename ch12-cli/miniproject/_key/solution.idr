module Main

import System
import System.File
import Data.String
import Data.List
import Data.Maybe

%default total

record Opts where
  constructor MkOpts
  input  : String
  output : String
  invert : Bool

defaultOpts : Opts
defaultOpts = MkOpts "" "" False

parseFlags : List String -> Opts -> Opts
parseFlags []                          o = o
parseFlags ("--invert"      :: rest)   o = parseFlags rest ({ invert := True } o)
parseFlags ("--in"  :: v :: rest)      o = parseFlags rest ({ input  := v    } o)
parseFlags ("--out" :: v :: rest)      o = parseFlags rest ({ output := v    } o)
parseFlags (_                :: rest)  o = parseFlags rest o

validate : Opts -> Either String Opts
validate o =
  if o.input == ""       then Left "missing --in"
  else if o.output == "" then Left "missing --out"
  else                        Right o

ramp : String
ramp = " .:-=+*#%@"

charForBrightness : Bool -> Integer -> Char
charForBrightness inv b =
  let idx  : Integer = (b * 10) `div` 256
      idx' : Integer = if inv then 9 - idx else idx
      cs            = unpack ramp
  in case getAt (cast idx') cs of
       Just c  => c
       Nothing => '?'

brightnessRow : Nat -> List Integer -> List Integer
brightnessRow Z     _                          = []
brightnessRow (S k) (r :: g :: b :: rest)      = ((r + g + b) `div` 3) :: brightnessRow k rest
brightnessRow (S _) _                          = []

renderRow : Bool -> List Integer -> String
renderRow inv = pack . map (charForBrightness inv)

chunkRows : Nat -> Nat -> List Integer -> List (List Integer)
chunkRows _ Z     _  = []
chunkRows w (S k) ns = brightnessRow w ns :: chunkRows w k (drop (3 * cast w) ns)

partial
main : IO ()
main = do
  line <- getLine
  let opts = parseFlags (words line) defaultOpts
  case validate opts of
    Left e  => do putStrLn ("error: " ++ e); exitWith (ExitFailure 1)
    Right o => do
      Right contents <- readFile o.input
        | Left fe => do putStrLn ("error: " ++ show fe); exitWith (ExitFailure 1)
      case words contents of
        ("P3" :: w :: h :: _ :: pixels) =>
          let wN   : Nat           = cast (the Integer (cast w))
              hN   : Nat           = cast (the Integer (cast h))
              nums : List Integer  = mapMaybe parseInteger pixels
              rows                 = chunkRows wN hN nums
              txt                  = unlines (map (renderRow o.invert) rows)
          in do
            Right () <- writeFile o.output txt
              | Left fe => do putStrLn ("error: " ++ show fe); exitWith (ExitFailure 1)
            putStrLn ("wrote " ++ o.output ++ ": " ++ w ++ "x" ++ h)
        _ => do putStrLn "error: not a P3 PPM"; exitWith (ExitFailure 1)
