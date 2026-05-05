module Main

import Data.Vect

%default total

-- New idea: `Vect n a` is a list whose LENGTH is part of the TYPE.
-- The `n` is a number the compiler knows. So `Vect 3 Int` means
-- "exactly three Ints" — not two, not four. If your literal has the
-- wrong number of elements, the program will not compile.
--
-- This is dependent typing: types depend on values (here, on a number).
-- The compiler counts your elements for you, and the compiler is fussy.
--
-- TODO: the list is missing one element — add `40` to the literal AND
--       update the type to `Vect 4 Int` so the program prints all four.

four : Vect 3 Int
four = [10, 20, 30]

main : IO ()
main = printLn four
