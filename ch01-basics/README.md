# Chapter 1 — Basics

**You'll learn:** how to make Idris print things, do arithmetic, name values, and ask the user for input.

By the end you'll build a **Mad Libs** silly-story generator.

---

## How this chapter is organized

You'll work through ten tiny programs in `exercises/`, in order. Each one introduces **one new idea**. They're each only a few lines long.

For every exercise:

1. Open the file in nvim.
2. Read the comment block at the top — it explains what to do.
3. Make the change the `-- TODO:` line asks for.
4. Save (`Esc`, `:wq`).
5. Run it: `idris2 --exec main exercises/01-say-hello.idr` (replace the filename for each one).
6. Look at what it printed. Did it match what you expected?

If you get stuck, peek at the matching file in `exercises/_key/` — that's a completed version. **Try on your own first.**

---

## The ten new ideas

In order, the ten exercises teach you:

| #  | New idea                                       | What you'll see                                  |
|----|------------------------------------------------|--------------------------------------------------|
| 01 | `putStrLn` prints a line                       | `putStrLn "Hello!"`                              |
| 02 | numbers and arithmetic                         | `printLn (2 + 3)`                                |
| 03 | strings (text in quotes)                       | `putStrLn "I love pizza."`                       |
| 04 | gluing strings with `++`                       | `putStrLn ("Hello, " ++ "world")`                |
| 05 | `let` names a value                            | `let x = 7 in printLn x`                         |
| 06 | new `let` shadows the old name (no mutation!)  | `let x = 7 in let x = 100 in printLn x`          |
| 07 | math on names                                  | `let a = 3; b = 4 in printLn (a + b)`            |
| 08 | numbers inside strings need `show`             | `putStrLn ("Hi, you are " ++ show age ++ "!")`   |
| 09 | reading input with `getLine`                   | `name <- getLine`                                |
| 10 | combining everything                           | small interactive program                        |

> **Heads up — different from Python:** in Idris, **values cannot change**. Once you say `let x = 7`, `x` stays `7` forever in that scope. To use a new value, you write a *new* `let`. Exercise 06 shows this in action. This is the headline difference between Idris and Python; pay attention to it.

## After the exercises: Mad Libs

Open `miniproject/README.md` and follow it. You'll write a small program that asks for some silly words and prints a 3-line story.

## Done?

Tick chapter 1 in `../PROGRESS.md` once:

- All ten exercises typecheck and run without errors.
- `idris2 --exec main miniproject/solution.idr` prints a story using your input.
- The verifier passes: `make verify-ch01` from the repo root.

---

## Words you might hear

- **expression** — a piece of code that has a value. `2 + 3` is an expression. `"hello"` is one too.
- **type** — the kind a value is. `7 : Integer` reads "7 has type Integer." Idris always knows the type of every value.
- **`do` block** — a recipe of steps that involve the outside world (printing, reading input). Each step inside a `do` runs in order.
- **binding** — giving a name to a value with `let`. The name and the value are stuck together for the rest of that scope.
- **`putStrLn`** — short for "put string + line." Prints a string and adds a newline.
- **`getLine`** — reads one line of input from the terminal. Type: `IO String`.
- **`++`** — the operator that glues two strings together. (Also glues two lists; we'll meet that in ch06.)
- **`show`** — turns any value (a number, a Bool, a list) into a `String` so you can print it or glue it.
