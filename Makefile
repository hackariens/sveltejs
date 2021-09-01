include make/general/Makefile
STACK         := sveltejs
NETWORK       := proxylampy
include make/docker/Makefile

SUPPORTED_COMMANDS := linter
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

GREEN := \033[0;32m
RED := \033[0;31m
YELLOW := \033[0;33m
NC := \033[0m
NEED := ${GREEN}%-20s${NC}: %s\n
MISSING :=${RED}ARGUMENT missing${NC}\n
ARGUMENTS := make ${PURPLE}%s${NC} ${YELLOW}ARGUMENT${NC}\n

install: node_modules ## Installation
	@make docker deploy -i

linter: ### Scripts Linter
ifeq ($(COMMAND_ARGS),all)
	@make linter readme -i
else ifeq ($(COMMAND_ARGS),readme)
	@npm run linter-markdown README.md
else
	@printf "${MISSING}"
	@echo "---"
	@printf "${ARGUMENTS}" linter
	@echo "---"
	@printf "${NEED}" "all" "## Launch all linter"
	@printf "${NEED}" "readme" "linter README.md"
endif