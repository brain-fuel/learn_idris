# Mini-project: Guess-The-Number

You'll build a one-shot guessing game that compares your guess to a hidden number.

## What it should do

When the user runs it, the program should:

1. Print a prompt that mentions the range (1–10).
2. Read **one line** of input — the player's guess.
3. Compare it to the secret (hardcoded to **7**) and print one of:
   - `Too low.`
   - `Too high.`
   - `Correct!`
4. If the input isn't a number, print `That's not a number.` instead.

Example run (with the fixture):

```
$ echo 7 | idris2 --no-banner --exec main solution.idr
I'm thinking of a number between 1 and 10.
Your guess: Correct!
```

## Where to write your code

Open `solution.idr`. Two `-- TODO` blocks:

1. Replace the `FIXME-prompt` line with a real prompt that mentions the 1–10 range.
2. Replace the single catch-all branch under `case compare g secret of` with three branches: `LT`, `GT`, `EQ`.

You'll use:

- `parsePositive {a = Nat}` from `Data.String` to turn a `String` into `Maybe Nat`.
- `compare` returns one of `LT`, `GT`, `EQ` — the same three constructors you saw in the chapter exercises.

## How to test

Run it manually:

```bash
echo 5 | idris2 --no-banner --exec main solution.idr
echo 7 | idris2 --no-banner --exec main solution.idr
echo abc | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch02
```

The test pipes the fixture (`7`) into your program and checks the output contains `thinking` and `Correct`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is matching all three `compare` constructors with the right print line each.
