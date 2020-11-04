.DEFAULT_GOAL := help
STACK         := sveltejs
NETWORK       := proxynetwork
WWW           := $(STACK)_www
WWWFULLNAME   := $(WWW).1.$$(docker service ps -f 'name=$(PRWWWOXY)' $(WWW) -q --no-trunc | head -n1)

%:
	@:

help:
	@grep -E '(^[a-zA-Z_-]+:.*?##.*$$)|(^##)' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[32m%-30s\033[0m %s\n", $$1, $$2}' | sed -e 's/\[32m##/[33m/'

apps/package-lock.json: apps/package.json
	cd apps && npm install

apps/node_modules: apps/package-lock.json
	cd apps && npm install

package-lock.json: package.json
	npm install

node_modules: package-lock.json
	npm install

build-ci: ## BUILD
	cd apps && npm run build

contributors: ## Contributors
	@npm run contributors

contributors-add: ## add Contributors
	@npm run contributors add

contributors-check: ## check Contributors
	@npm run contributors check

contributors-generate: ## generate Contributors
	@npm run contributors generate

docker-create-network: ## create network
	docker network create --driver=overlay $(NETWORK)

docker-deploy: ## deploy
	docker stack deploy -c docker-compose.yml $(STACK)

docker-image-pull: ## Get docker image
	docker image pull koromerzhin/nodejs:15.0.1-sveltejs

docker-logs: ## logs docker
	docker service logs -f --tail 100 --raw $(WWWFULLNAME)

docker-ls: ## docker service
	@docker stack services $(STACK)

docker-stop: ## docker stop
	@docker stack rm $(STACK)

git-commit: ## Commit data
	npm run commit

git-check: ## CHECK before
	@make contributors-check -i
	@make linter -i
	@git status

install: node_modules apps/node_modules ## Installation
	@make docker-deploy -i

linter: ## linter
	@make linter-readme -i

linter-readme: ## linter README.md
	@npm run linter-markdown README.md

ssh: ## ssh
	docker exec -ti $(WWWFULLNAME) /bin/bash