IDRIS2 ?= idris2

.PHONY: help
help:
	@echo "Targets:"
	@echo "  make verify-chNN    - typecheck exercises + _key, run miniproject test for chapter NN"
	@echo "  make typecheck-all  - typecheck every .idr in the workspace"
	@echo "  make compile-all    - build every miniproject _key/ to a runnable executable"
	@echo "  make clean          - remove build/ caches"

# Usage: make verify-ch01
verify-ch%:
	@chdir=$$(ls -d ch$**/ 2>/dev/null | head -n1); \
	  if [ -z "$$chdir" ]; then echo "No directory matching ch$**/"; exit 1; fi; \
	  chdir=$${chdir%/}; \
	  echo "==> typecheck $$chdir/exercises"; \
	  found=0; \
	  for f in $$chdir/exercises/*.idr $$chdir/exercises/_key/*.idr; do \
	    [ -f "$$f" ] || continue; \
	    found=1; \
	    $(IDRIS2) --check "$$f" >/dev/null || { echo "FAIL: $$f"; exit 1; }; \
	  done; \
	  if [ $$found -eq 0 ]; then \
	    echo "==> $$chdir has no exercises authored yet (see ch01-basics for the template)"; \
	    exit 1; \
	  fi; \
	  if [ -f "$$chdir/miniproject/_key/solution.idr" ]; then \
	    echo "==> typecheck $$chdir/miniproject (stub + _key)"; \
	    [ -f "$$chdir/miniproject/solution.idr" ] && $(IDRIS2) --check "$$chdir/miniproject/solution.idr" >/dev/null; \
	    $(IDRIS2) --check "$$chdir/miniproject/_key/solution.idr" >/dev/null || exit 1; \
	  fi; \
	  if [ -d "$$chdir/t" ] && ls $$chdir/t/*.idr >/dev/null 2>&1; then \
	    for tf in $$chdir/t/*.idr; do \
	      base=$$(basename "$$tf" .idr); \
	      lower=$$(echo $$base | tr A-Z a-z); \
	      echo "==> build $$tf -> build/exec/$$lower"; \
	      $(IDRIS2) -o $$lower "$$tf" >/dev/null || exit 1; \
	      echo "==> run build/exec/$$lower (default solution = learner stub)"; \
	      ./build/exec/$$lower || exit 1; \
	    done; \
	  fi; \
	  echo "OK $$chdir"

.PHONY: typecheck-all
typecheck-all:
	@echo "==> root package (lib/)"
	@$(IDRIS2) --typecheck learn-idris.ipkg >/dev/null || exit 1
	@find . -name '*.idr' -not -path '*/build/*' -not -path './lib/*' | while read f; do \
	  echo "==> $$f"; \
	  $(IDRIS2) --check "$$f" >/dev/null || exit 1; \
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
