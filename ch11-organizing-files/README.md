# Chapter 11 — Organizing Files

**You'll learn:** how to walk directory trees, copy/move/rename files, and shell out for operations that aren't built into Idris's `System.Directory`. This is the chapter that makes Python's `shutil` honest — most heavy lifting becomes `system "mv ..."` calls.

## Status

Not yet authored. See [`../ch01-basics/`](../ch01-basics/) for the chapter template.

## Idris realization

| Python `shutil` / `os`              | Idris equivalent                                     |
|-------------------------------------|------------------------------------------------------|
| `os.listdir(d)`                     | `listDir d : IO (Either FileError (List String))`   |
| `os.walk(d)`                        | hand-recursion using `listDir` + `isDirectory`       |
| `shutil.copy(src, dst)`             | `system ("cp " ++ src ++ " " ++ dst)`                |
| `shutil.move(src, dst)`             | `system ("mv ...")`                                  |
| `os.makedirs(d)`                    | `createDir d` (errors if exists; check first)        |
| `os.remove(f)`                      | `removeFile f`                                       |

Headline shift: sometimes the right answer is shell-out. Idris doesn't pretend to wrap every coreutil — when `mv` will do, call `mv`.

## Pack dependencies

None — `System.Directory`, `System.File`, and `System.system` are in `base`.

## Miniproject (when authored)

Photo organizer: walk a directory of mixed `.jpg`, `.heic`, `.txt`, `.mov` files; move each into a typed subfolder (`images/`, `video/`, `notes/`); skip files already organized.
