# Mini-project: Address Book (REPL)

You'll build a tiny address-book REPL backed by a `SortedMap String Contact` — add a contact, look one up, list them all.

## What it should do

The program reads commands from stdin, one line at a time, and loops until it sees `quit` or end-of-input:

- `add NAME EMAIL` → store the contact, print `ok`.
- `lookup NAME` → print `NAME: EMAIL` if found, else `not found`.
- `list` → print every contact, sorted by name (the map is ordered).
- `quit` (or empty line) → exit.
- Anything else → print `?` and continue.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
> ok
> ok
> Alice: alice@x.com
> Alice: alice@x.com
Bob: bob@y.com
>
```

## Where to write your code

Open `solution.idr`. The framework — record `Contact`, type alias `Book = SortedMap String Contact`, the REPL `loop`, the `lookup` and `quit` arms — is already wired up. Two `-- TODO` blocks remain:

1. **`add` arm.** Replace the `putStrLn "PLACEHOLDER"` stub with code that inserts `(name, MkContact email)` into `book`, prints `ok`, and recurses with the updated book.
2. **`list` arm.** Replace its stub with `for_ (Data.SortedMap.toList book)` printing each entry via `showC`, then recurse with the same `book`.

You'll use:

- `insert`, `lookup`, and `Data.SortedMap.toList` from `Data.SortedMap`.
- Record field access — `c.email` works on a `Contact`.
- The `partial` keyword on `loop` and `main` (it recurses on user input, not on a structurally smaller value, so Idris can't prove totality — that's expected).

## How to test

Run it manually and type a few commands:

```bash
idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch07
```

The test pipes the fixture (`add Alice / add Bob / lookup Alice / list / quit`) into your program and checks the output contains `Alice: alice@x.com`, `Bob: bob@y.com`, and `ok`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is remembering the loop has to recurse with `book'` (the updated map) after `add`, but with `book` (unchanged) after `list` and `lookup`.
