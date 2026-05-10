# learn_idris on the web

Full-stack Idris 2 frontend for the curriculum in this repo's chapter
directories. See `/home/brainfuel/.claude/plans/i-want-to-turn-eventual-tide.md`
for the architecture plan.

## Status

Task 1 (scaffolding) only. Modules are stubs; nothing runs yet. `make
web-typecheck` is the green-light signal that the layout parses.

## Layout

```
web/
  shared/         # Idris source shared by server + client (codegen-agnostic)
  content-build/  # Pre-build IO executable that emits Generated/Routes.idr
  server/         # Idris -> Chez Scheme; depends on web-shared
  scheme-host/    # Chez .ss files that own sockets + HTTP/WS framing
  client/         # Idris -> JS (browser); depends on web-shared, dom-mvc
  sandbox/        # Node worker spawning idris2 in firejail per session
  infra/          # Cloudflare Pages + Worker, Docker for origin
  scripts/        # Build orchestration shell scripts
  t/              # Cross-cutting integration tests
  iron-sieve/     # Coverage decoration + mutation testing harness
```

## Build

```sh
make -C web web-typecheck    # Typechecks every .idr in web/ (current target)
```

Once stubs grow into real modules:

```sh
make -C web web-deps         # pack install-deps for all four ipkgs
make -C web web-build        # idris2 --build for each ipkg
make -C web web-test         # hedgehog suites + sandbox smoke + integration
make -C web web-run          # spawn dev: scheme-host + sandbox + esbuild watch
```

## License

EPL-2.0. Same as the parent repo.
