# Mini-project: Photo Organizer

You'll build a tiny file-classifier: read a directory path, look at each file's extension, and move it into a subfolder for its category.

## What it should do

Read **one line** of stdin (a directory path). List every file in that directory. For each file, decide a category from its extension:

- `.jpg`, `.jpeg`, `.png`, `.heic` → `images`
- `.mov`, `.mp4` → `video`
- `.txt`, `.md` → `notes`
- anything else → `other`

Then `mkdir` the category subdir if it doesn't exist, `mv` the file into it, and print `moved <name> -> <category>/<name>`. Skip the four category dirs themselves (so a re-run doesn't try to move `images` into `other/images`).

Example run (with the test driver's pre-created fixture files):

```
$ echo /tmp/learn_idris_ch11_test | idris2 --no-banner --exec main solution.idr
moved clip.mov -> video/clip.mov
moved junk.bin -> other/junk.bin
moved note1.txt -> notes/note1.txt
moved photo1.jpg -> images/photo1.jpg
```

(Order is alphabetical because `listDir` results are sorted before iteration.)

## Where to write your code

Open `solution.idr`. The `main` skeleton (read path, `listDir`, sort, iterate) is already wired. Three `-- TODO` blocks:

1. **`extension : String -> String`** — return the lowercase trailing `.xxx`. See ch11 exercise 05 for the same logic.
2. **`classify : String -> String`** — branch on the extension to return `images`/`video`/`notes`/`other`. See ch11 exercise 06.
3. **`organizeOne root name`** — print the `moved …` line. Optionally also `system "mkdir -p …"` and `system "mv …"` to actually move the file. The test driver only checks stdout, so disk-side moves are not required to pass the test.

You'll use:

- `listDir` from `System.Directory`.
- `system` from `System` to shell out to `mkdir -p` and `mv`.
- `unpack`, `pack`, `break`, `reverse`, `toLower` for the extension parser.

## How to test

Make a test directory:

```bash
mkdir -p /tmp/photos
touch /tmp/photos/a.jpg /tmp/photos/b.txt /tmp/photos/c.mov
echo /tmp/photos | idris2 --no-banner --exec main solution.idr
ls /tmp/photos     # should show images/, notes/, video/ now
```

Then run the automatic test from the repo root:

```bash
make verify-ch11
```

The test driver creates four files (`photo1.jpg`, `note1.txt`, `clip.mov`, `junk.bin`) under `/tmp/learn_idris_ch11_test`, runs your program, and checks the output mentions all four moves.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the extension parser: `break (== '.')` on the **reversed** char list lets you find the last `.` rather than the first.
