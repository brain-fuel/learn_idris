# Mini-project: Birthday Card

You'll build a tiny program that prints a personalised birthday card.

## What it should do

When the user runs it, the program should:

1. Ask for a **name** (the person whose birthday it is — "Alice", "Mr. Bean", "Grandpa").
2. Ask for an **age** (any number — "9", "47", "100").
3. Print **two lines** of a birthday card that include both the name and the age.

Example run:

```
$ idris2 --exec main solution.idr
What's the recipient's name?
> Alice
How old are they?
> 9
Happy birthday, Alice!
You're 9 today — have a great year!
```

(Your card can be any two lines you want — as long as the name and the age both show up.)

## Where to write your code

Open `solution.idr` in this folder. There's a starter file with `-- TODO` comments. Fill them in, one at a time.

You only need things you've already seen in `hello.idr`:

- `putStrLn "..."` to print a line.
- `name <- getLine` to read a line the user typed.
- `++` to glue strings together (`"Hello, " ++ name`).

No need to turn the age into a number — leave it as a string.

## How to test

When you think it's working:

```bash
idris2 --exec main solution.idr
```

Type any name and age you like and see your card.

Then run the automatic test from the repo root:

```bash
make verify-ch00
```

The test runs your program with these answers:

- name: `Alice`
- age: `9`

It checks that both `Alice` and `9` show up in your output. If they do, the test passes!

## Stuck?

Look at `_key/solution.idr` — that's a working version. Try on your own first.
