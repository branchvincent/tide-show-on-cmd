SHELL := /usr/bin/env fish
LC_VERSION := e6d56afd8dd14d8ce69d69326353f77d09e71c38

.PHONY: help
help: ## Show this help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z -]+:.*?## / {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort

.PHONY: install
install: ## Install the project
	@type -q fisher || begin; curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher >/dev/null; end
	@type -q tide || fisher install IlanCosman/tide >/dev/null
	@echo "Installing project..."
	@fisher install . >/dev/null

.PHONY: uninstall
uninstall: ## Uninstall the project
	@echo "Uninstalling project..."
	@fisher remove . >/dev/null

.PHONY: fmt
fmt: ## Format codebase
	@fish_indent --write **/*.fish

.PHONY: lint
lint: ## Lint codebase
	@fish_indent --check **/*.fish
	@echo **/*.fish | xargs -n1 fish --no-execute

littlecheck:
	@echo "Downloading littlecheck.py..."
	@curl -fsSL https://raw.githubusercontent.com/ridiculousfish/littlecheck/$(LC_VERSION)/littlecheck/littlecheck.py -o littlecheck
	@chmod +x littlecheck

.PHONY: test
test: install littlecheck ## Run tests
	@type -q mock || fisher install IlanCosman/clownfish >/dev/null
	@./littlecheck --progress tests/*.fish
