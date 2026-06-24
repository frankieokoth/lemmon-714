.PHONY: help bootstrap install doctor repair flush backup-windows

help: ## Show this help message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

bootstrap: ## Initialize system packages and core toolchain
	@echo "=> Executing system bootstrap..."
	@bash ./os/linux/bootstrap.sh

install: ## Deploy configuration symlinks to home directory
	@echo "=> Deploying workspace topology..."
	@bash ./scripts/install.sh

doctor: ## Verify environment integrity and tool status
	@echo "=> Running diagnostic suite..."
	@bash ./scripts/doctor.sh

repair: ## Reset development environment state
	@echo "=> Executing environment repair..."
	@bash ./scripts/repair.sh

flush: repair ## Alias for repair (purge editor servers and dead IPC sockets)

backup-windows: ## Export Windows host application inventory
	@echo "=> Capturing Windows host state..."
	@powershell.exe -ExecutionPolicy Bypass -File ./scripts/backup-windows.ps1