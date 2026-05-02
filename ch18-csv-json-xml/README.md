# Chapter 18 — CSV / JSON / XML

**You'll learn:** three parsers / serializers. CSV via `parser-tsv` (with comma instead of tab). JSON via the pack `json` package. XML hand-written with parser combinators (no XML pack package exists).

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

### CSV
| Python                              | Idris                                              |
|-------------------------------------|----------------------------------------------------|
| `csv.reader(open("f.csv"))`         | `parser-tsv` configured for `,` separator         |
| `csv.writer(...).writerow([...])`   | hand-format `,`-joined rows                        |

### JSON
| Python                              | Idris                                              |
|-------------------------------------|----------------------------------------------------|
| `json.load(open("f.json"))`         | `parseJSONFile "f.json"` from pack `json`         |
| `json.dumps(d)`                     | `Show` instance on a JSON value                    |

### XML
The pack ecosystem has no XML package as of nightly-260327. Build a tiny XML parser using parser combinators (the technique from ch09) — enough for the miniproject's needs, no more.

## Pack dependencies

- `parser-tsv`
- `json`

Install: `pack install parser-tsv json`.

## Miniproject (when authored)

A multi-format converter: read a CSV of `name,email,age`, emit JSON and XML versions of the same data. Practice all three in one go.
