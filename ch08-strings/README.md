# Chapter 8 — Strings & Text Editing

**You'll learn:** Idris's `String` type plus the helpers in `Data.String` for slicing, splitting, joining, case conversion. Idris keeps `String` and `List Char` separate — you bridge with `pack` and `unpack`.

## Idris realization

| Python concept              | Idris form                                                   |
|-----------------------------|--------------------------------------------------------------|
| `s.upper()`                 | `toUpper s` (per-char via unpack/map/pack, or `Data.String.toUpper`) |
| `s.lower()`                 | `toLower s`                                                  |
| `s.split(",")`              | `split (== ',') s` from `Data.String`                        |
| `",".join(xs)`              | `joinBy ", " xs`                                             |
| `len(s)`                    | `length s`                                                   |
| `s[2:5]`                    | `substr 2 3 s` (start, length)                               |
| `s in t`                    | `isInfixOf s t`                                              |
| `s.replace(a, b)`           | hand-roll via `unpack` + `map` + `pack`, or use `Data.String` |
| f-strings                   | `++` and `show`                                              |

Headline shift: a `String` is opaque — to walk character by character, `unpack s : List Char`, do work, `pack` back.

## Pack dependencies

None — `Data.String` is in `base`.

## Miniproject

Take a paragraph of text and emit a histogram of word counts, ignoring case + punctuation. Outputs sorted descending.
