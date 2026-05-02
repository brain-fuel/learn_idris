# Chapter 0 — Hello

**Goal:** open a terminal, run an Idris 2 program, change it, run it again.

That's the whole loop you'll use for everything else: **edit → save → typecheck/run → see what happened**.

---

## 1. What we'll do today

Three things:
- Run a tiny program someone else (me) wrote.
- Change one word in it.
- Run it again to see your change.

That's it. By the end you'll have a feel for the loop.

## 2. Open a terminal

If you're on Windows: open **Windows Terminal** (Start menu → "Terminal"), and click the dropdown arrow at the top → **Ubuntu**. You should see a prompt that ends with `$`.

If you don't see a `$` prompt, ask your teacher.

## 3. Look around

Type each of these. Hit Enter after each one.

```bash
pwd
```

`pwd` means "print working directory." It tells you where you are right now in the computer.

```bash
ls
```

`ls` means "list." It shows what's in the current folder.

Now go to this chapter's folder:

```bash
cd ~/johannes/learn_idris/ch00-hello
```

`cd` means "change directory." After this, `pwd` should show you a path that ends in `ch00-hello`.

## 4. Run the prewritten program

```bash
idris2 --exec main hello.idr
```

The first time you run an Idris program, it does two things:

1. **Typechecks** the program — proves the types fit together. If anything is wrong, it stops and tells you.
2. **Runs** the program.

For `hello.idr`, the program will say something to you and then **wait**. It's waiting for you to type your name. Type it and hit Enter.

You should see something like:

```
Hello! What's your name?
> Alice
Nice to meet you, Alice.
```

If you got that, **congratulations — you just ran an Idris program**. Take a breath.

## 5. Edit it

Open the file in nvim:

```bash
nvim hello.idr
```

You're now in an editor. To make changes you need to press `i` (this enters "insert mode"). The bottom of the screen will say `-- INSERT --`.

Use the arrow keys to move around. Find the line that says:

```idris
putStrLn "Hello! What's your name?"
```

Change `Hello!` to `Hi there!` (or any greeting you want). Just type as if it's a normal text editor — but only after you pressed `i`.

When you're done:

1. Press `Esc` (this leaves insert mode).
2. Type `:wq` and press Enter. (`:` opens a command line, `w` writes the file, `q` quits.)

You should be back at the terminal prompt.

## 6. Run it again

```bash
idris2 --exec main hello.idr
```

Now it greets you with your new wording. **You changed a program.**

## 7. Recap

The loop you just did is the loop for everything in this curriculum:

1. **Edit** the file.
2. **Save** it (`Esc`, then `:wq` in nvim).
3. **Run** it (`idris2 --exec main <filename>`).
4. **Look** at what it printed.
5. If it didn't do what you wanted, edit again.

## 8. Try the exercises

Open [`exercises/01-change-greeting.idr`](exercises/01-change-greeting.idr) in nvim and follow the `-- TODO` comment inside.

When you finish 01, do [`exercises/02-add-line.idr`](exercises/02-add-line.idr).

After that, you're done with ch00. Tick it off in `../PROGRESS.md` and move on to `ch01-basics`.

---

## If something went wrong

- **`idris2: command not found`** — Idris 2 isn't installed or isn't on your PATH. Ask your teacher.
- **`nvim: command not found`** — Try `vi` or `vim` or any editor your teacher set up. The editor doesn't have to be nvim.
- **Idris printed a long error** — copy it exactly when asking for help. Idris errors look scary but they always tell you which line and which type didn't fit.
- **The program just sits there** — It's probably waiting for you to type something and press Enter.
- **You're stuck in nvim** — Press `Esc`, then type `:q!` and Enter. That quits without saving. You can re-open the file with `nvim hello.idr`.
