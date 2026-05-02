# Chapter 7 — Dictionaries / Structuring Data

**You'll learn:** how to associate keys with values (`SortedMap` from `Data.SortedMap`) and how to define your own data shapes with records. Records are the Idris answer to "I want a struct" — a named bundle of fields, each with a type.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept                    | Idris form                                                   |
|-----------------------------------|--------------------------------------------------------------|
| `d = {"x": 1, "y": 2}`            | `d = fromList [("x", 1), ("y", 2)] : SortedMap String Int`   |
| `d["x"]`                          | `lookup "x" d : Maybe Int` (no key = `Nothing`)              |
| `d["x"] = 9`                      | `insert "x" 9 d` returns a new map                           |
| `class Point: x: int; y: int`     | `record Point where constructor MkPoint; x, y : Int`         |
| `p.x`                             | `p.x` (or `x p`) — record fields are functions               |
| dataclasses, named tuples         | one mechanism: `record`                                      |
| `dict.keys()`, `.values()`        | `keys d`, `values d`                                         |

Headline shift: there is no `KeyError`. Lookup returns `Maybe a`, and the compiler forces you to handle the `Nothing` case before you can use the value.

## Pack dependencies

None — `Data.SortedMap` is in `base`.

## Miniproject (when authored)

Build a simple address book backed by a `SortedMap String Contact` where `Contact` is a record. Support add, remove, lookup-by-name, list-all.
