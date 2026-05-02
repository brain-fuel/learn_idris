# Idris 2 Idioms — Teacher Reference

A cheat sheet of Idris 2 idioms the teacher should be able to explain when they come up. **Not for the learner** — they meet these one at a time inside chapter exercises.

For learners arriving from Python, this doc becomes the spine: walk it top-to-bottom.

| # | Concept | Idris form | Note |
|---|---------|------------|------|
| 1 | Top-level definitions | `name : Type` then `name = expr` | Type signature on its own line. Mandatory. |
| 2 | IO action | `main : IO ()` | `IO ()` = an action returning unit. Run with `idris2 --exec main file.idr`. |
| 3 | Sequencing actions | `do` block; `<-` to bind a value out of `IO a`; `let` for pure binding | `name <- getLine` then `putStrLn ("Hi " ++ name)`. |
| 4 | Print | `putStr`, `putStrLn`, `printLn` | `putStrLn : String -> IO ()`. `printLn : Show a => a -> IO ()` (any showable). |
| 5 | String concat | `"a" ++ "b"` | No `+` for strings, no Python-style f-strings. Use `show` to turn non-strings into strings. |
| 6 | Immutability | `let x = 7` introduces `x`; you cannot reassign | A second `let x = 100` shadows in scope; the first `x` is unchanged. |
| 7 | Lists vs Vects | `List a` (any length); `Vect n a` (length `n` known at compile time) | Vect's length is a *type* parameter — the compiler checks indexing safety. |
| 8 | Maybe | `data Maybe a = Nothing \| Just a` | Idris's "this might be missing." No null. |
| 9 | Pattern matching | `f Nothing = 0; f (Just x) = x` | Multiple equations on the same name; first match wins. |
| 10 | Totality | `%default total` at top of file | Compiler proves every function terminates and covers all cases. |

## Things that bite Python users

- **No mutation.** `x = 5` creates a binding; you cannot then write `x = 6`. Use a new binding (`let y = 6`) or pass values through. Loops aren't `for i = 0; i++` — they're recursion or `traverse_`.
- **Type signatures on every top-level.** Idris won't infer them at module scope. Local `let`s are fine without.
- **`if` is an expression, not a statement.** `let kind = if n > 0 then "pos" else "neg"`. There must always be an `else` branch.
- **No print debugging mid-pure-function.** Pure functions can't `IO`. Use holes (`?foo`) and let the typechecker tell you what's there. Or refactor to return data and print at the boundary.
- **`String` is not `[Char]`.** Use `unpack : String -> List Char` and `pack : List Char -> String` to bridge.
- **`Int` vs `Nat` vs `Integer`.** `Int` is fixed-width; `Nat` is unary, type-level natural; `Integer` is unbounded. Default literal `42 : Integer` unless context forces otherwise.

## Things to demo when they come up naturally

- **Holes**: `f x = ?todo` typechecks, and the compiler tells you `?todo` has type X — drop into REPL with `:t todo` to inspect. Save until ch05 (Debugging).
- **Dependent types**: `Vect n Int` where `n` is a value. `replicate : (n : Nat) -> a -> Vect n a`. Save until ch06 (Lists) — show as the punchline.
- **`do` notation desugaring**: `do x <- m; f x` becomes `m >>= f`. Mention only when `>>=` shows up in an error message.
- **Records**: `record Point where constructor MkPoint; x, y : Int`. Save until ch07 (structuring data).
- **Interfaces** (Idris's typeclasses): `interface Show a where show : a -> String`. Save until ch04 (Functions) when defining your own.
- **`%default total`**: making the curriculum total-by-default forces termination thinking. If a function genuinely needs partiality (parsing user input that might loop), use `partial` explicitly.

## Compiler invocations the learner sees

| What | Command |
|------|---------|
| Typecheck only | `idris2 --check file.idr` |
| Typecheck + run | `idris2 --exec main file.idr` |
| REPL on a file | `idris2 file.idr` then `:exec main` |
| Typecheck a package | `idris2 --check chNN.ipkg` |
| Build a package | `idris2 --build chNN.ipkg` |

## Pack invocations the teacher sees

| What | Command |
|------|---------|
| Switch to nightly collection | `pack switch latest` |
| Install a package | `pack install http` |
| Build current dir's `.ipkg` | `pack build` |
| Run executable from `.ipkg` | `pack run chNN` |
