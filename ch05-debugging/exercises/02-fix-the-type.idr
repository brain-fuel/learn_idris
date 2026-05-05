module Main

%default total

-- New idea: a function's TYPE SIGNATURE and its BODY have to agree, and
-- both have to agree with what `main` (or whoever calls it) expects.
-- When something is "wrong," the cheapest first move is to read the
-- signature and ask: does the body really do what this promises?
--
-- Here, `greet`'s signature says `String -> String` and the call site
-- asks for a greeting for `"world"`. The body, though, just returns
-- the string `"FIXME"` regardless of who you pass in. The program
-- compiles, runs, and prints `FIXME` -- which is obviously not a greeting.
--
-- Debug-by-reading: the signature names the input `name : String`, so
-- the body should USE `name`. Right now it doesn't.
--
-- TODO: change the body of `greet` so the program prints `Hello, world`.

greet : String -> String
greet name = "FIXME"

main : IO ()
main = putStrLn (greet "world")
