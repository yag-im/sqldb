ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
SHELL := /bin/bash

include .env
export

APP_NAME := sqldb
DOCKER_IMAGE_TAG := $(APP_NAME):dev
LISTEN_PORT := 5432
HOST_PGDATA_DIR := $(DATA_DIR)/pgdata
PGDATA_DIR := /var/lib/postgresql/data

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
		-v $(HOST_PGDATA_DIR):$(PGDATA_DIR) \
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
	sudo rm -rf $(HOST_PGDATA_DIR)
	mkdir -p $(HOST_PGDATA_DIR)
