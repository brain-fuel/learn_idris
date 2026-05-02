# Learn Idris — Curriculum

A self-paced Idris 2 course adapted from *Automate the Boring Stuff with Python* (3rd ed) by Al Sweigart, plus its companion workbook. Designed for learners with **no prior coding experience** — but ports the topics in the **spirit** of Idris: total functions, dependent types, type-driven development. Where Python relies on a third-party library, this curriculum either pulls in an Idris 2 `pack` package or rolls a small pure-Idris equivalent.

## How to use this repo

You'll work through chapters in order. Each chapter is a small folder. Inside it you'll find:

- **`README.md`** — what this chapter teaches, in plain English. Read it first.
- **`exercises/`** — a sequence of tiny programs. Each one introduces *one* new idea. Open the file, do what the `-- TODO` comment says, save, run.
- **`miniproject/`** — a small program that combines what you learned. You'll build it from a spec.
- **`t/`** — automatic tests for the miniproject. Run them to check your work.
- **`chNN.ipkg`** — the Idris package for the chapter. Lists dependencies and lets `idris2 --check chNN.ipkg` typecheck the whole thing in one go.

## Where to start

1. **Teacher first**: read [`SETUP.md`](SETUP.md) and run the one-time setup.
2. **Learner**: open [`ch00-hello/README.md`](ch00-hello/README.md) and follow it.
3. Mark progress in [`PROGRESS.md`](PROGRESS.md) as you go.

## Chapters

See [`PROGRESS.md`](PROGRESS.md) for the full chapter list and your progress.

## How to run an Idris program

```bash
idris2 --exec main path/to/file.idr
```

To only typecheck (no run):

```bash
idris2 --check path/to/file.idr
```

## How to ask for help

When something doesn't work, copy the **exact** error message your terminal printed. Don't paraphrase. Idris's error tells you which type didn't fit where — it's almost always more useful than it looks the first time.
