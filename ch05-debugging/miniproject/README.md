# Mini-project: Fix the Buggy Calculator

You'll take a calculator that **compiles fine but prints the wrong answer** and use the chapter's debugging tools — `printLn` traces, holes, the REPL — to track down three bugs.

## What it should do (after you fix it)

Same shape as the ch04 calculator: read one line of `<int> <op> <int>`, print the result. With stdin `12 + 7` the program should print `19`.

Right now, with stdin `12 + 7`, the program prints `0`. That's because `apply` ignores its arguments and always returns `Just 0`.

Example run (with the fixture, **after** you fix the bugs):

```
$ echo '12 + 7' | idris2 --no-banner --exec main solution.idr
19
```

## Where to write your code

Open `solution.idr`. The starter file lists three bugs in its top comment:

1. **`apply` ignores its operator and operands.** Replace the catch-all `apply _ _ _ = Just 0` with real clauses for `"+"`, `"-"`, `"*"`, `"/"`.
2. **No catch-all for unknown operators.** After adding the four operator clauses, add a final `apply _ _ _ = Nothing` so unknown ops fall through to `error`.
3. **No divide-by-zero guard.** The `apply "/"` clause must check `b == 0` and return `Nothing` if so.

The point of this miniproject isn't writing the code (you already wrote it in ch04) — it's **using the debugging tools the chapter taught**:

- Sprinkle `printLn` to dump intermediate values.
- Replace any expression you're unsure about with `?hole` and ask the REPL `:t hole` to see what type Idris expects there.
- Reload the file in the REPL after each edit (`:r`).

## How to test

Run it manually after each fix:

```bash
echo '12 + 7' | idris2 --no-banner --exec main solution.idr
```

Then run the automatic test from the repo root:

```bash
make verify-ch05
```

The test pipes the fixture (`12 + 7`) into your program and checks the output contains `19`.

## Stuck?

Look at `_key/solution.idr` — that's a working version (it's effectively the ch04 solution). Try the REPL approach first: `idris2 ch05-debugging/miniproject/solution.idr`, then `:t apply`, then experiment.
