# Mini-project: Mad Libs

You'll build a tiny silly-story generator. The program asks for a few words and then prints a story that uses them.

## What it should do

When the user runs it, the program should:

1. Ask for an **animal** (any animal — "cat", "elephant", "octopus").
2. Ask for a **verb** (an action word — "jump", "sing", "explode").
3. Ask for a **place** (any place — "the moon", "Grandma's kitchen", "Antarctica").
4. Ask for a **funny adjective** (a describing word — "sparkly", "smelly", "invisible").
5. Print **three lines** of story that use all four words.

Example run:

```
$ idris2 --exec main solution.idr
An animal: cat
A verb: jump
A place: the moon
A funny adjective: sparkly

Once upon a time, a sparkly cat decided to jump all the way to the moon.
Everyone there was very surprised.
The end.
```

(Your story can be any silly sentences you want — as long as all four words appear.)

## Where to write your code

Open `solution.idr` in this folder. There's a starter file with `-- TODO` comments. Fill them in.

## How to test

When you think it's working:

```bash
idris2 --exec main solution.idr
```

Type any silly answers and see what happens.

Then run the automatic test from the repo root:

```bash
make verify-ch01
```

The test runs your program with these answers:

- animal: `cat`
- verb: `jump`
- place: `the moon`
- adjective: `sparkly`

It checks that all four of those words show up in your output. If they do, the test passes!

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first.
