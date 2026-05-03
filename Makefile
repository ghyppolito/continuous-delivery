# Continuous Delivery Tools Management
# Usage: make [target] TOOL=[tool_name]
# Example: make up TOOL=sonarqube

# Default tool
TOOL ?= sonarqube
TOOLS_DIR := tools
COMPOSE_FILE := $(TOOLS_DIR)/$(TOOL)/docker-compose.yml
ENV_FILE := $(TOOLS_DIR)/$(TOOL)/.env
ENV_EXAMPLE := $(TOOLS_DIR)/$(TOOL)/.env.example

# Colors for output
BLUE := \033[34m
GREEN := \033[32m
RED := \033[31m
RESET := \033[0m

.PHONY: help up down logs status restart shell check-tool

help:
	@echo "$(BLUE)Continuous Delivery - Infrastructure Management$(RESET)"
	@echo ""
	@echo "Usage: make [target] TOOL=[tool_name]"
	@echo ""
	@echo "Available Tools:"
	@ls -1 $(TOOLS_DIR)
	@echo ""
	@echo "Targets:"
	@echo "  $(GREEN)up$(RESET)        Start the specified tool (creates .env if missing)"
	@echo "  $(GREEN)down$(RESET)      Stop and remove containers"
	@echo "  $(GREEN)restart$(RESET)   Restart the containers"
	@echo "  $(GREEN)logs$(RESET)      View live logs"
	@echo "  $(GREEN)status$(RESET)    Show status of containers"
	@echo "  $(GREEN)shell$(RESET)     Open a shell in the tool container (service name defaults to tool name)"

check-tool:
	@if [ ! -d "$(TOOLS_DIR)/$(TOOL)" ]; then \
		echo "$(RED)Error: Tool '$(TOOL)' not found in $(TOOLS_DIR).$(RESET)"; \
		exit 1; \
	fi
	@if [ ! -f "$(COMPOSE_FILE)" ]; then \
		echo "$(RED)Error: docker-compose.yml not found for tool '$(TOOL)'.$(RESET)"; \
		exit 1; \
	fi

up: check-tool
	@echo "$(BLUE)Starting $(TOOL)...$(RESET)"
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "Creating .env from example..."; \
		cp $(ENV_EXAMPLE) $(ENV_FILE); \
	fi
	docker compose -f $(COMPOSE_FILE) up -d
	@echo "$(GREEN)$(TOOL) is up!$(RESET)"

down: check-tool
	@echo "$(BLUE)Stopping $(TOOL)...$(RESET)"
	docker compose -f $(COMPOSE_FILE) down
	@echo "$(GREEN)$(TOOL) stopped.$(RESET)"

restart: check-tool
	@echo "$(BLUE)Restarting $(TOOL)...$(RESET)"
	docker compose -f $(COMPOSE_FILE) restart

logs: check-tool
	docker compose -f $(COMPOSE_FILE) logs -f

status: check-tool
	docker compose -f $(COMPOSE_FILE) ps

shell: check-tool
	docker compose -f $(COMPOSE_FILE) exec $(TOOL) sh || docker compose -f $(COMPOSE_FILE) exec $(TOOL) bash
