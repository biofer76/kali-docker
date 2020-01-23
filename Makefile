PWD ?= pwd_unknown
PROJECT_NAME = "devxops/kali-docker"
export PROJECT_NAME

.PHONY: help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build kali-docker image
	docker build -t $(PROJECT_NAME) .

build-nc: ## Build kali-docker image without caching
	docker build --no-cache -t $(PROJECT_NAME) .