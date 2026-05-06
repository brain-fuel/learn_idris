IDRIS2 ?= idris2

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make verify-chNN    - typecheck exercises + _key, run miniproject test for chapter NN"
	@echo "  make bootstrap-pack - pack install-deps for every chapter with a pack.toml"
	@echo "  make typecheck-all  - typecheck every .idr in the workspace"
	@echo "  make compile-all    - build every miniproject _key/ to a runnable executable"
	@echo "  make clean          - remove build/ caches"

# idris2 --check exits 0 even on "Error: Module not found" (upstream quirk).
# We capture stdout+stderr and grep for ^Error: to fail-fast on real problems.
# IDRIS2_PACKAGE_PATH alone makes pack-installed modules visible but not loaded —
# we also need explicit -p flags for each transitive dep. The PACK_HTTP_FLAGS
# table below enumerates http's transitive closure in the nightly-260327
# collection. Future waves adding new pack deps extend this with parallel tables.
PACK_HTTP_FLAGS := -p http -p tls -p contrib -p sop -p elab-util -p base64 -p utf8 -p ref1 -p network -p linear

# Usage: make verify-ch01
verify-ch%:
	@chdir=$$(ls -d ch$**/ 2>/dev/null | head -n1); \
	  if [ -z "$$chdir" ]; then echo "No directory matching ch$**/"; exit 1; fi; \
	  chdir=$${chdir%/}; \
	  PFLAGS=""; \
	  if [ -f "$$chdir/pack.toml" ]; then \
	    chipkg=$$(ls $$chdir/*.ipkg | head -n1); \
	    echo "==> pack install-deps $$chipkg (project-local pack.toml)"; \
	    (cd "$$chdir" && pack --no-prompt install-deps "$$(basename $$chipkg)") >/dev/null || { echo "FAIL: pack install-deps $$chipkg"; exit 1; }; \
	    export IDRIS2_PACKAGE_PATH="$$(cd $$chdir && pack package-path)"; \
	    if grep -qE '^depends.*\bhttp\b' "$$chipkg"; then PFLAGS="$(PACK_HTTP_FLAGS)"; fi; \
	  fi; \
	  echo "==> typecheck $$chdir/exercises"; \
	  found=0; \
	  for f in $$chdir/exercises/*.idr $$chdir/exercises/_key/*.idr; do \
	    [ -f "$$f" ] || continue; \
	    found=1; \
	    out=$$($(IDRIS2) $$PFLAGS --check "$$f" 2>&1); \
	    if echo "$$out" | grep -qE '^Error:'; then echo "$$out"; echo "FAIL: $$f"; exit 1; fi; \
	  done; \
	  if [ $$found -eq 0 ]; then \
	    echo "==> $$chdir has no exercises authored yet (see ch01-basics for the template)"; \
	    exit 1; \
	  fi; \
	  if [ -f "$$chdir/miniproject/_key/solution.idr" ]; then \
	    echo "==> typecheck $$chdir/miniproject (stub + _key)"; \
	    if [ -f "$$chdir/miniproject/solution.idr" ]; then \
	      out=$$($(IDRIS2) $$PFLAGS --check "$$chdir/miniproject/solution.idr" 2>&1); \
	      if echo "$$out" | grep -qE '^Error:'; then echo "$$out"; echo "FAIL: $$chdir/miniproject/solution.idr"; exit 1; fi; \
	    fi; \
	    out=$$($(IDRIS2) $$PFLAGS --check "$$chdir/miniproject/_key/solution.idr" 2>&1); \
	    if echo "$$out" | grep -qE '^Error:'; then echo "$$out"; echo "FAIL: $$chdir/miniproject/_key/solution.idr"; exit 1; fi; \
	  fi; \
	  if [ -d "$$chdir/t" ] && ls $$chdir/t/*.idr >/dev/null 2>&1; then \
	    for tf in $$chdir/t/*.idr; do \
	      base=$$(basename "$$tf" .idr); \
	      lower=$$(echo $$base | tr A-Z a-z); \
	      echo "==> build $$tf -> build/exec/$$lower"; \
	      $(IDRIS2) $$PFLAGS -o $$lower "$$tf" >/dev/null || exit 1; \
	      echo "==> run build/exec/$$lower (default solution = learner stub)"; \
	      ./build/exec/$$lower || exit 1; \
	    done; \
	  fi; \
	  echo "OK $$chdir"

.PHONY: bootstrap-pack
bootstrap-pack:
	@for d in ch*/; do \
	  if [ -f "$$d/pack.toml" ]; then \
	    chipkg=$$(ls $$d/*.ipkg | head -n1); \
	    echo "==> pack install-deps $$chipkg"; \
	    (cd "$$d" && pack --no-prompt install-deps "$$(basename $$chipkg)") || exit 1; \
	  fi; \
	done; \
	echo "OK pack bootstrap"

.PHONY: typecheck-all
typecheck-all:
	@echo "==> root package (lib/)"
	@$(IDRIS2) --typecheck learn-idris.ipkg >/dev/null || exit 1
	@for chdir in ch*/; do \
	  chdir=$${chdir%/}; \
	  PFLAGS=""; \
	  if [ -f "$$chdir/pack.toml" ]; then \
	    chipkg=$$(ls $$chdir/*.ipkg | head -n1); \
	    export IDRIS2_PACKAGE_PATH="$$(cd $$chdir && pack package-path)"; \
	    if grep -qE '^depends.*\bhttp\b' "$$chipkg"; then PFLAGS="$(PACK_HTTP_FLAGS)"; fi; \
	  else \
	    unset IDRIS2_PACKAGE_PATH; \
	  fi; \
	  for f in $$(find "$$chdir" -name '*.idr' -not -path '*/build/*' 2>/dev/null); do \
	    echo "==> $$f"; \
	    out=$$($(IDRIS2) $$PFLAGS --check "$$f" 2>&1); \
	    if echo "$$out" | grep -qE '^Error:'; then echo "$$out"; echo "FAIL: $$f"; exit 1; fi; \
	  done; \
	done; \
	echo "OK all"

.PHONY: compile-all
compile-all:
	@find . -path '*/miniproject/_key/solution.idr' | while read f; do \
	  dir=$$(dirname "$$f"); \
	  echo "==> build $$f"; \
	  (cd "$$dir" && $(IDRIS2) -o solution solution.idr >/dev/null) || exit 1; \
	done; \
	echo "OK all"

.PHONY: clean
clean:
	@find . -type d -name build -exec rm -rf {} + 2>/dev/null; true
