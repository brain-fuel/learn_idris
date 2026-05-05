module Main

%default total

-- New idea: with `%default total`, every function must handle every input.
-- If you forget a clause -- say, only handle `True` for a `Bool` argument --
-- the compiler refuses to compile and names the missing pattern. That's
-- debugging by typechecker.
--
-- Here, both clauses of `describe` ARE present (so the file compiles),
-- but the `False` clause is wrong: it returns `"FIXME"` instead of the
-- intended `"no"`. Run the program -- it prints `FIXME` -- and read the
-- code to spot the error.
--
-- TODO: change the `False` clause so `describe False` returns `"no"`.

describe : Bool -> String
describe True  = "yes"
describe False = "FIXME"

main : IO ()
main = putStrLn (describe False)
