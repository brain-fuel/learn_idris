# Mini-project: Read-Aloud (Text-to-Speech)

You'll build a tiny TTS wrapper: read a line of text, shell out to `espeak-ng` to produce a WAV file, then sanity-check the WAV by reading its bytes and verifying the RIFF magic header.

## Prerequisites

You need `espeak-ng` on your `$PATH`. On Debian/Ubuntu: `sudo apt install espeak-ng`. The miniproject writes the WAV to disk rather than playing audio so the test stays headless and deterministic.

## What it should do

Read **one line** of stdin. Shell `espeak-ng -v en -w /tmp/learn_idris_ch24_speech.wav '<text>'` (single-quote the text so spaces are safe). Then:

1. Print `wrote /tmp/learn_idris_ch24_speech.wav`.
2. `readFile` the WAV bytes.
3. Take the first 4 bytes — if they are `RIFF`, the file is a valid WAV. Print `RIFF header: yes` or `RIFF header: no`.
4. Print `size: <N> bytes` (the byte count of the file).

Example run (with the fixture):

```
$ cat fixtures/input.txt | idris2 --no-banner --exec main solution.idr
wrote /tmp/learn_idris_ch24_speech.wav
RIFF header: yes
size: 18432 bytes
```

(The exact byte count depends on the espeak-ng version. The test only pins the `wrote …` and `RIFF` substrings.)

## Where to write your code

Open `solution.idr`. The starter prints `FIXME` placeholders. The helpers `shellQuote`, `mkSpeakCmd`, `wavMagic`, and `isRiff` are already defined. Fill in `main`:

1. `text <- getLine`.
2. `_ <- System.system (mkSpeakCmd text outPath)` to invoke espeak-ng.
3. Print `wrote <outPath>`.
4. `Right bytes <- readFile outPath` (handle the `Left` case with an error message).
5. Compute `riff = isRiff bytes` and `size = length bytes`.
6. Print `RIFF header: yes`/`no` based on `riff`, then `size: <show size> bytes`.

You'll use:

- `System.system` from `System`.
- `System.File.readFile` (returns the file contents as a `String` of bytes — Idris doesn't distinguish text from binary at this level).
- `pack (take 4 (unpack s))` to grab the first 4 bytes as a `String` (the existing `wavMagic` helper does this).

> **Why disk-not-speakers?** A real read-aloud bot would call `espeak-ng <text>` (no `-w`) to play the audio through ALSA. The `-w` flag instead writes a WAV file you can inspect, which is what the test harness checks. The chapter exercises walk through both modes.

## How to test

Run it manually:

```bash
echo 'hello world' | idris2 --no-banner --exec main solution.idr
xxd /tmp/learn_idris_ch24_speech.wav | head    # peek at the bytes — first 4 should be `RIFF`
```

For audio output (real speakers), drop the `-w` flag and run espeak-ng directly:

```bash
espeak-ng -v en 'hello world'
```

Then run the automatic test from the repo root:

```bash
make verify-ch24
```

The test deletes the prior WAV, runs your program with the fixture (`hello world`), and checks the output contains `wrote /tmp/learn_idris_ch24_speech.wav` and `RIFF`.

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first. The trickiest bit is the bytes-as-string trick: `readFile` happily reads binary data into a `String`, and `pack (take 4 (unpack s))` gives you the first 4 raw bytes — comparing that to `"RIFF"` is enough to confirm the file's a real WAV.
