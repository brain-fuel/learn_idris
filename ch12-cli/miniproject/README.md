# Mini-project: `ic` — PPM-to-ASCII converter

You'll build a tiny image-conversion CLI: read a PPM image, render each pixel as one ASCII character based on its brightness, write the result to a text file.

## What it should do

Read **one line** of stdin shaped like a CLI invocation:

```
--in <path-to-ppm> --out <path-to-text> [--invert]
```

Then:

1. Parse the flags into an `Opts` record.
2. Validate that `--in` and `--out` were supplied (else print `error: missing --in` / `error: missing --out`).
3. Read the input file. The fixture is a `P3` PPM:

   ```
   P3
   <width> <height>
   <max-channel-value>
   R G B  R G B  …   (width × height triples)
   ```

4. For each pixel, average R+G+B → brightness 0..255 → an index into the 10-character ramp `" .:-=+*#%@"` (space = darkest, `@` = brightest). If `--invert`, reverse the ramp.
5. Write the resulting ASCII art (one row per line) to the output path.
6. Print `wrote <out>: <width>x<height>` to stdout.

> **Why stdin instead of `argv`?** `idris2 --exec main` doesn't pass user args through, so the test harness reads the CLI string from a single line of stdin to keep all chapters uniform.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
wrote /tmp/learn_idris_ch12_ic_out.txt: 3x2
```

(`fixtures/tiny.ppm` is a 3×2 image: red/green/blue pixels on top, black/grey/white on the bottom.)

## Where to write your code

Open `solution.idr`. Four `-- TODO` blocks:

1. Define `record Opts where constructor MkOpts; input : String; output : String; invert : Bool`.
2. Write `parseFlags : List String -> Opts -> Opts` — recursive case-pattern over the token list, peeling off one flag (and its value) per iteration. See ch12 exercise 06.
3. Write `validate : Opts -> Either String Opts` — check the two paths are non-empty. See ch12 exercise 07.
4. Fill in `main`: `getLine`, parse, validate, `readFile` the PPM, render, `writeFile`, print the success line.

You'll use:

- `words` to split the stdin line into a `List String`.
- Record-update syntax `{ input := v } o`.
- `mapMaybe parseInteger` to turn the pixel-token strings into `List Integer`.
- `pack` and `unpack` for the brightness-to-character mapping.

## How to test

Run it manually:

```bash
echo '--in fixtures/tiny.ppm --out /tmp/out.txt' \
  | idris2 --no-banner --exec main solution.idr
cat /tmp/out.txt   # see the ASCII art
```

Then run the automatic test from the repo root:

```bash
make verify-ch12
```

The test pipes the fixture and checks the output contains `wrote /tmp/learn_idris_ch12_ic_out.txt` and `3x2`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the `chunkRows` step: you want `width × height` brightness values laid out as `height` rows of `width` characters each, which means `drop (3 * width)` pixel-tokens between rows.
