# Chapter 6 — Lists

**You'll learn:** Idris has two list-like types. `List a` is a list of any length. `Vect n a` is a list of *exactly `n`* elements — and `n` is a **type-level value**, so the compiler can prove indexing is safe at compile time. This is the punchline that distinguishes Idris from most other languages.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept             | Idris form                                                |
|----------------------------|-----------------------------------------------------------|
| `[1, 2, 3]`                | `[1, 2, 3] : List Int` (or `Vect 3 Int`)                  |
| `xs[0]`                    | `head xs` returns `Maybe a`; on `Vect`, `head xs` is total |
| `xs.append(y)`             | no append-in-place; `xs ++ [y]` returns a new list        |
| `len(xs)`                  | `length xs : Nat` for `List`, `n` for `Vect n a`          |
| `xs + ys`                  | `xs ++ ys`                                                |
| `xs.sort()`                | `sort xs` from `Data.List` returns a new list             |
| immutability               | always — no mutation; everything returns a fresh list     |

Headline punchline: `Vect n a` makes off-by-one errors compile errors. `index 5 xs` only typechecks when `xs : Vect n a` and `5` can be proven `< n`.

## Pack dependencies

None — `Data.List` and `Data.Vect` are in `base`.

## Miniproject (when authored)

Take a CSV-like list of student scores and produce: average, top three, bottom three, count of passing scores. Build it with `List`, then re-build it with `Vect` and notice which off-by-one mistakes the compiler caught.
