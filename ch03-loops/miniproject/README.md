# Mini-project: FizzBuzz 1–20

You'll build the classic FizzBuzz: print the numbers 1 through 20, swapping in `Fizz`, `Buzz`, or `FizzBuzz` on the multiples.

## What it should do

For every `n` from 1 to 20, print one line:

- If `n` is a multiple of **15** → `FizzBuzz`
- Else if `n` is a multiple of **3** → `Fizz`
- Else if `n` is a multiple of **5** → `Buzz`
- Otherwise → the number itself, e.g. `7`

Example run:

```
$ idris2 --no-banner --exec main solution.idr
1
2
Fizz
4
Buzz
Fizz
7
8
Fizz
Buzz
11
Fizz
13
14
FizzBuzz
16
17
Fizz
19
Buzz
```

## Where to write your code

Open `solution.idr`. The starter already loops 1..20 with `for_` and prints whatever `label` returns — but `label n = show n`, so right now you only see numbers.

One `-- TODO` block: rewrite `label` as a chain of `if ... else if`:

- `n \`mod\` 15 == 0` → `"FizzBuzz"`
- `n \`mod\`  3 == 0` → `"Fizz"`
- `n \`mod\`  5 == 0` → `"Buzz"`
- otherwise → `show n`

The order matters — check 15 before 3 and 5, or you'll never reach the `FizzBuzz` branch.

## How to test

Run it manually:

```bash
idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch03
```

The test runs your program and checks the output contains `Fizz`, `Buzz`, `FizzBuzz`, `11`, and `19`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The chapter's exercises walk through the same logic with three different loop shapes (recursion, `for_`, list comprehension); the miniproject just sticks with `for_`.
