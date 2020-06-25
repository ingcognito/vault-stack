SHELL := /bin/bash -e

export PROJECT_NAME="vault-stack"

ifndef BRANCH_NAME
	BRANCH_NAME = $(shell git rev-parse --abbrev-ref HEAD)
endif

export BRANCH_NAME

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

deploy:
	docker stack deploy --with-registry-auth -c=deploy-stack.yml ${PROJECT_NAME}-${BRANCH_NAME}
