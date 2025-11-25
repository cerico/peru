_tldr:
	@$(MAKE) info
	@$(MAKE) _commands

_commands:
	@echo Available commands
	@echo ------------------
	@grep '^[[:alpha:]][^:[:space:]]*:' Makefile makefiles/*.mk | cut -d ':' -f 2 | sort -u | sed 's/^/make /'

_status:
	@limactl list $(VM_NAME)

_create:
	@echo "Creating VM with Lima..."
	@echo "Using config: lima.yaml"
	@limactl start --name=$(VM_NAME) lima.yaml
	@echo "Waiting for VM to be ready..."
	@sleep 3
	@echo "✓ VM created: $(VM_NAME)"
	@echo ""
	@$(MAKE) setup
	@echo ""
	@$(MAKE) info
