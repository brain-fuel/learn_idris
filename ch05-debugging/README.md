# Chapter 5 — Debugging

**You'll learn:** Idris's debugging tools are *very* different from Python's. Instead of inserting `print(x)` statements, you insert `?holes` — a hole is a placeholder the typechecker fills in for you, telling you exactly what type of value is expected at that spot. Combined with the REPL, this is "type-driven development."

## Idris realization

| Python tool                  | Idris equivalent                                         |
|------------------------------|----------------------------------------------------------|
| `print(x)` in middle of code | `?todo` hole; `:t todo` in REPL inspects context         |
| `pdb` step debugger          | `:exec main` from REPL, `printLn` at boundaries          |
| stack traces                 | type errors point to the exact line + which type didn't fit |
| `assert x == 1`              | a unit test (a top-level `IO ()` you `--exec` to run)    |
| `try/except`                 | `Either err val`, pattern-match on `Left`/`Right`        |

Headline shift: most "debugging" in Idris is **before** you run the program. A hole + `:t` will tell you what's wrong without ever executing anything.

## Pack dependencies

None.

## Miniproject (when authored)

Take a buggy small program, replace the bug-line with `?fix`, query its type in the REPL, write the right expression, and ship.
