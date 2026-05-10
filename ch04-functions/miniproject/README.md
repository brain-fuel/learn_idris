# Mini-project: One-Line Calculator

You'll build a tiny calculator: read one line shaped like `12 + 7`, print `19`. Wrong input prints `error`.

## What it should do

Read **one line** of stdin shaped like `<int> <op> <int>` — three space-separated tokens. The operator is one of `+`, `-`, `*`, `/`. Then:

- If everything parses and the math works → print the result.
- If anything is off (bad operator, non-integer token, divide-by-zero, wrong number of tokens) → print `error`.

Example run (with the fixture):

```
$ echo '12 + 7' | idris2 --no-banner --exec main solution.idr
19
```

Other examples:

```
$ echo '20 / 4' | …    # 5
$ echo '5 / 0'  | …    # error
$ echo 'hi'     | …    # error
```

## Where to write your code

Open `solution.idr`. Two `-- TODO` blocks:

1. Fix the body of `apply`. Three of the four operator clauses currently return `Just 0`. Replace each with the right arithmetic. The `/` clause needs a divide-by-zero guard: return `Nothing` when `b == 0`, else `Just (a \`div\` b)`.
2. In `main`, replace the two `putStrLn "FIXME"` lines so:
   - on success → `printLn r` (prints the integer)
   - on `Nothing` → `putStrLn "error"`

You'll use:

- `parseInteger` from `Data.String` (returns `Maybe Integer`).
- `words` to split a line on whitespace.
- Pattern matching on a 3-element list to confirm token count.

## How to test

Run it manually:

```bash
echo '12 + 7' | idris2 --no-banner --exec main solution.idr
echo '5 / 0'  | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch04
```

The test pipes the fixture (`12 + 7`) into your program and checks the output contains `19`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the divide-by-zero guard inside the `apply "/"` clause.
