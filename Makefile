.PHONY: help bootstrap flush doctor

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-15s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Initialize system packages and core toolchain
	@echo "=> Executing system bootstrap..."
	@bash ./os/linux/bootstrap

flush: ## Purge editor server entropy and dead WSL IPC sockets
	@echo "=> Purging editor server caches..."
	@rm -rf ~/.vscode-server ~/.cursor-server
	@echo "=> Cleaving dead IPC sockets..."
	@rm -rf /tmp/vscode-ipc-* /tmp/vscode-server-* /run/user/1000/vscode-ipc-*
	@echo "=> Environment flushed. Reconnect your editors from Windows host."

doctor: ## Verify environment integrity and tool status
	@echo "=> Running diagnostic suite..."
	@bash ./scripts/doctor