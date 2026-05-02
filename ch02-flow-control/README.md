# Chapter 2 — Flow Control

**You'll learn:** how to make a program *decide*. Idris's tools for branching are `if/then/else` (an *expression*, not a statement — it must always have an `else`), pattern-matching with `case ... of`, and guards on function clauses.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template (README + ten exercises + miniproject + test driver). Once exercises exist, run `make verify-ch02` from the repo root.

## Idris realization

| Python concept            | Idris form                                                |
|---------------------------|-----------------------------------------------------------|
| `if x: ...`               | `if x then ... else ...` (always needs `else`)            |
| `if/elif/else`            | `case` of with `_` catch-all, or guards `\| cond = expr`  |
| `bool(x)` truthiness      | `Bool` is `True`/`False` only — no implicit truthiness    |
| `and`, `or`, `not`        | `&&`, `\|\|`, `not`                                       |
| `==`, `!=`                | `==`, `/=` (interface `Eq`)                               |

Headline difference: `if` in Idris is an **expression** that returns a value, so every `if` must have an `else`. There is no "fall through with no return" — each branch produces a value of the same type.

## Pack dependencies

None — `prelude` and `base` are enough.

## Miniproject (when authored)

A small command-line guessing game: pick a number 1–10, ask the user to guess, branch on too-high / too-low / correct.
