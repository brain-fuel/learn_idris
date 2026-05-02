# Chapter 9 — Pattern Matching (substitute for Regex)

**You'll learn:** Python's `re` module has no direct counterpart in the Idris 2 ecosystem. Instead, Idris culture leans on **parser combinators** — small, composable functions that match input. They're more verbose for one-off "find a phone number" tasks but type-safe and total. This chapter teaches a small parser combinator library and uses it the way Python uses regex.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

Build (or import from `parser-json` style) a tiny parser combinator core:

| Python regex                       | Parser combinator                                |
|------------------------------------|--------------------------------------------------|
| `re.match(r"\d+", s)`              | `parse digits s`                                 |
| `re.search(r"\d{3}-\d{4}", s)`     | hand-write `phoneNumber` parser                  |
| `re.findall(...)`                  | `many (try ...)`                                 |
| `re.sub(...)`                      | parse + transform + reassemble                   |

Headline shift: a parser is **a function** that takes a string and returns either a parsed value with the rest of the string, or a parse error. Parsers compose with `<|>` (alternative), `>>=` (sequence), `many`, `some`.

## Pack dependencies

None for the hand-rolled core; later exercises may pull in `parser-json` or `parser-toml` patterns for inspiration.

## Miniproject (when authored)

Phonebook scraper: given a free-form list of contacts in a text file, extract every phone number that matches the US format `\d{3}-\d{3}-\d{4}`.
