# Mini-project: Phone-Number Scraper

You'll build a tiny scraper that reads free-form text from stdin and prints every US phone number it finds. No regex library — you'll write the matcher with the parser combinators from the chapter exercises.

## What it should do

Read **all** of stdin. Find every substring that matches the format `\d{3}-\d{3}-\d{4}` (three digits, dash, three digits, dash, four digits). Print each match on its own line, in the order they appear. Bare digit runs without the right dashes don't count.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
555-123-4567
800-555-0199
415-867-5309
```

(Input had two lines: `Call me at 555-123-4567 anytime, or my office number is 800-555-0199.` / `For sales reach out to 415-867-5309. ignore 12-3 or 5551234567.` — the last two are correctly skipped.)

## Where to write your code

Open `solution.idr`. The starter is mostly empty — the chapter taught you the building blocks, the miniproject asks you to assemble them. Four `-- TODO` blocks:

1. **Parser combinator core.** Copy in your `Parser` record + `pchar`, `pdigit`, `pseq`, `pcount` (and a small `digitsToStr` helper) from the exercises.
2. **`phone : Parser String`.** Chain four steps in sequence — `pcount 3 pdigit`, `pchar '-'`, `pcount 3 pdigit`, `pchar '-'`, `pcount 4 pdigit` — and on full success, glue the matched digits back together with dashes.
3. **`findAll : List Char -> List String`** sliding scan. Try `phone` at each position; on a hit, emit the match and skip past it; otherwise advance by one character. Mark it `partial` (the `drop (length …)` step makes the totality checker unhappy).
4. **`main`.** Slurp **all** of stdin (loop over `getLine` until `fEOF stdin` is true — `import System.File.Virtual`), then run `findAll` on the unpacked contents and print each match with `putStrLn`.

You'll use:

- `unpack`/`pack` to move between `String` and `List Char`.
- The combinators you wrote in exercises 04–10.
- `System.File.Virtual.fEOF` for end-of-stdin detection.

## How to test

Run it manually:

```bash
cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch09
```

The test pipes the fixture into your program and checks all three real numbers (`555-123-4567`, `800-555-0199`, `415-867-5309`) appear in the output.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is `findAll`: when `phone` succeeds, you must advance past the **whole** match (12 chars) before retrying — otherwise you can re-detect the same number from position 1, 2, 3, …
