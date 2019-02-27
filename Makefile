# Makefile for lazy people, like me
# The shell we use
SHELL := /bin/bash

# Get version form VERSION
#VERSION := $(shell cat VERSION)
DOCKER := $(bash docker)

# We like colors
# From: https://coderwall.com/p/izxssa/colored-makefile-for-golang-projects
RED=`tput setaf 1`
GREEN=`tput setaf 2`
RESET=`tput sgr0`
YELLOW=`tput setaf 3`

# Add the following 'help' target to your Makefile
# # And add help text after each target name starting with '\#\#'
.PHONY: help
help: ## This help message
	@echo -e "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

.PHONY: yamllint
yamllint: ## Run linter against all yaml files
	@echo ""
	@echo "$(YELLOW)==> Linting yaml files ...$(RESET)"
	@./_tests/yamlcheck.sh

.PHONY: linkcheck
linkcheck: ## Run linkcheck
	@echo ""
	@echo "$(YELLOW)==> Checking links ...$(RESET)"
	@docker run -v `pwd`:/srv/test testthedocs/ttd-linkcheck

.PHONY: check-changelog
check-changelog: ## Check that the Changelog is up2date
	@echo ""
	@echo "$(YELLOW)==> Validate Changelog ...$(RESET)"
	@.ci/check_changelog.sh
