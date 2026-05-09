# Chapter 3 — Loops

**You'll learn:** how to do something *many times* in a language with no `for i = 0; i++`. Idris uses recursion for general looping; for typical "do this for each item" cases, `for_` and `traverse_` from `Data.List` are the workhorses.

## Idris realization

| Python concept                | Idris form                                       |
|-------------------------------|--------------------------------------------------|
| `for x in xs: print(x)`       | `for_ xs $ \x => putStrLn x`                     |
| `for i in range(n): ...`      | `for_ [0 .. n] $ \i => ...`                      |
| `while cond: ...`             | recursive helper that pattern-matches on `cond`  |
| `sum(xs)`                     | `foldl (+) 0 xs` (or `sum` from `Foldable`)      |
| `[f(x) for x in xs]`          | `map f xs`                                       |
| `[x for x in xs if pred(x)]`  | `filter pred xs`                                 |

Headline shift: a Python `while` loop is recursion in Idris — write a small helper that calls itself with the new state. The compiler checks that recursion terminates (totality).

## Pack dependencies

None.

## Miniproject

Print FizzBuzz from 1 to 100, but do it three different ways (recursion, `for_` over a range, list comprehension via `map`).
