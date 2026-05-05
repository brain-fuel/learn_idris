module Main

%default total

-- New idea: a hole reports MORE than its expected type -- it also lists
-- every name in local scope, with their types. So you don't have to
-- scroll up to remember what `bigger` was; just put `?answer` where
-- you're stuck and ask the REPL.
--
-- Try it:
--   idris2 05-hole-context.idr
--   :t answer
-- You'll see something like:
--   x : Int
--   y : Int
--   bigger : Int
--   ------------------------------
--   answer : Int
-- That's the entire context, for free.
--
-- The file typechecks (holes are accepted with a warning), but `main`
-- can't actually run until `?answer` is filled in.
--
-- TODO: replace `?answer` with `bigger` so `compute 3 5` evaluates to 5
-- and `main` prints `5`.

compute : Int -> Int -> Int
compute x y =
  let bigger = if x > y then x else y in
  ?answer

main : IO ()
main = printLn (compute 3 5)
