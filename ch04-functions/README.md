# Chapter 4 — Functions

**You'll learn:** how to define your own functions in Idris. Every top-level function gets a type signature on its own line (`name : Type`), then the equation(s) (`name args = expr`). Functions are total by default in this curriculum: the compiler proves they terminate and cover every case.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept                          | Idris form                                                 |
|-----------------------------------------|------------------------------------------------------------|
| `def add(x, y): return x + y`           | `add : Int -> Int -> Int` then `add x y = x + y`           |
| default argument `def f(x, y=2):`       | wrap as a record with `default` field; or curry            |
| keyword args `f(x=1, y=2)`              | named record fields, or implicit args `{x : ..}`           |
| `lambda x: x + 1`                       | `\x => x + 1`                                              |
| `f(g(x))`                               | `f (g x)` — function application is whitespace             |
| `*args`, `**kwargs`                     | take a `List a` or pass a record                           |

Headline shift: every function has a type. The signature is your contract; the compiler enforces it. When you forget a case, Idris tells you exactly which input shape isn't handled.

## Pack dependencies

None.

## Miniproject (when authored)

Build a tiny calculator: parse a line like `12 + 7` and print the result. Practices defining a small AST, pattern-matching on it, and recursive evaluation.
