# Chapter 10 — Reading & Writing Files

**You'll learn:** how to read a file with `readFile`, write one with `writeFile`, and chunk large files line-by-line. File operations live in `IO` and return `Either FileError String` because they can fail (file missing, no permission).

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python concept                          | Idris form                                                 |
|-----------------------------------------|------------------------------------------------------------|
| `open(path).read()`                     | `readFile path : IO (Either FileError String)`             |
| `open(path, "w").write(s)`              | `writeFile path s : IO (Either FileError ())`              |
| `for line in open(path):`               | `readFile` then `lines content`                            |
| `with open(path):`                      | `withFile path Read $ \handle => ...`                      |
| `os.path.exists(path)`                  | `exists path : IO Bool`                                    |

Headline shift: file ops can fail, and Idris makes you handle the error. No silently-swallowed exceptions.

## Pack dependencies

None — `System.File` is in `base`.

## Miniproject (when authored)

A daily-journal helper: `journal.idr add "what I did today"` appends to `journal.txt` with a timestamp; `journal.idr show` prints the last 7 days.
