.PHONY: help install sync docker-start docker-stop run-local run-debug run-docker clean

help: ## Show this help message
	@echo 'Usage: make [target]'
	@echo ''
	@echo 'Available targets:'
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  %-20s %s\n", $$1, $$2}' $(MAKEFILE_LIST)

install: ## Install dependencies using uv
	@uv sync

sync: ## Sync dependencies
	@uv sync

docker-start: ## Start Docker container for development
	@bash scripts/docker-start.sh

docker-stop: ## Stop Docker container
	@docker stop dgi-dev-deploy-0 || true
	@docker rm dgi-dev-deploy-0 || true

run-local: ## Run model locally (requires Ascend toolkit)
	@bash scripts/run-local.sh

run-debug: ## Run in debug mode
	@bash scripts/run-debug.sh

run-docker: ## Run model in Docker container
	@bash scripts/run-docker.sh

clean: ## Clean generated files
	@rm -fr kernel_meta fusion_result.json
	@find . -type d -name __pycache__ -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name '*.pyc' -delete 2>/dev/null || true
