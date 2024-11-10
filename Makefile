ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
SHELL := /bin/bash

include .env
export

APP_NAME := sqldb
DOCKER_IMAGE_TAG := $(APP_NAME):dev
LISTEN_PORT := 5432
PGDATA_HOST_DIR := ~/yag/data/pgdata

.PHONY: help
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.PHONY: docker-run
docker-run: ## Run dev docker container
	docker run --rm -it \
		--name yag-sqldb \
		-p $(LISTEN_PORT):$(LISTEN_PORT)/tcp \
		--env-file $(ROOT_DIR).env \
		--env-file $(ROOT_DIR)secrets.env \
		-v $(PGDATA_HOST_DIR):$(PGDATA) \
		$(DOCKER_IMAGE_TAG)
		bash

.PHONY: docker-build
docker-build: ## Build docker image
	$(MAKE) clean
	docker build \
		-t $(DOCKER_IMAGE_TAG) \
		--progress plain \
		.

.PHONY: clean
clean: ## Clean DB data
	sudo rm -rf $(PGDATA_HOST_DIR)
	mkdir $(PGDATA_HOST_DIR)
