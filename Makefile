NVIM ?= nvim
STYLUA ?= stylua

.PHONY: test check format format-check extras check-extras

test:
	$(NVIM) --headless -u tests/minimal_init.lua \
		-c "lua dofile('tests/smoke.lua')" -c qa

format:
	$(STYLUA) lua colors scripts/generate-extras.lua tests

format-check:
	$(STYLUA) --check lua colors scripts/generate-extras.lua tests

extras:
	$(NVIM) --headless -u NONE -l scripts/generate-extras.lua

check-extras: extras
	git diff --exit-code -- extras

check: format-check test check-extras
