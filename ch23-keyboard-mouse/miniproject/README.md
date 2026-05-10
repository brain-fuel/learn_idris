# Mini-project: Mouse-Mover

You'll build a tiny GUI-automation tool: read `X Y` coordinates from stdin, shell out to `xdotool` to move the mouse there, then read the cursor's reported position back.

## Prerequisites

You need `xdotool` on your `$PATH`, plus an X11 display the tool can act on. The test driver wraps your program in `xvfb-run -a`, so the test acts on a virtual display (`:99`) and **does not touch your real cursor**. Running outside the test (with `$DISPLAY=:0`) **will** move your real cursor — that's how you confirm it works.

This is Linux/WSL2 territory; macOS uses different tools.

## What it should do

The program is a REPL that reads stdin line-by-line. Each line is `<X> <Y>` (two integers, space-separated). For each line:

1. Shell `xdotool mousemove <X> <Y>` to move the cursor.
2. Shell `xdotool getmouselocation` and capture its stdout (something like `x:100 y:200 screen:0 window:1234`).
3. Parse the `x:` and `y:` tokens out.
4. Print two lines:
   ```
   moved to <X> <Y>
   now at x:<X> y:<Y>
   ```

On end-of-input (empty line), print `quit` and stop.

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
moved to 100 200
now at x:100 y:200
moved to 300 400
now at x:300 y:400
quit
```

## Where to write your code

Open `solution.idr`. The REPL `loop` and the `mkSpeakCmd`-style helpers' signatures are already declared. Five `-- TODO` blocks:

1. **`mouseMove x y`** — `System.system ("xdotool mousemove " ++ show x ++ " " ++ show y)`. See exercise 03.
2. **`readXdotool cmd`** — shell the command redirected to `/tmp/learn_idris_ch23_tmp.txt`, `readFile` it back, return the contents. See exercise 06.
3. **`parseMouseLine`** — split the captured string on spaces, then each token on `:`, take the second segment of the `x:` and `y:` tokens, `cast` them. See exercise 07.
4. **`moveAndConfirm`** — call `mouseMove`, print `moved to X Y`, call `readXdotool "xdotool getmouselocation"`, parse, print `now at x:X y:Y`. See exercise 09.
5. **`loop`** — split each stdin line on spaces, take the first two tokens as `xs` and `ys`, call `moveAndConfirm (cast xs) (cast ys)`, recurse. On empty line, print `quit`.

You'll use:

- `System.system` from `System`.
- `System.File.readFile`.
- `Data.String.split` (call `forget` for a plain `List`).
- `cast : String -> Int`.

## How to test

If you have a real X session, try:

```bash
echo '100 200' | idris2 --no-banner --exec main solution.idr
# your real cursor should now be at (100, 200)
```

For a no-op-on-cursor smoke test, wrap in `xvfb-run`:

```bash
xvfb-run -a sh -c 'cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr'
```

Then run the automatic test from the repo root:

```bash
make verify-ch23
```

The test wraps your program in `xvfb-run`, pipes the fixture (`100 200 / 300 400`), and checks the output contains `moved to 100 200`, `moved to 300 400`, `x:100`, `x:300`, and `quit`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is parsing `xdotool`'s output: it's space-separated `key:value` tokens, so `split (== ' ')` then `split (== ':')` lets you peel out the `x:` and `y:` integers without a regex.
