REPO_NAME := $(shell gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null || echo "")

github: 
	@if [ -z "$(REPO_NAME)" ]; then \
		echo "Error: Could not determine repository. Make sure you're in a git repo with a GitHub remote."; \
		exit 1; \
	fi
	@echo "Enabling workflow write permissions for $(REPO_NAME)..."
	@gh api repos/$(REPO_NAME)/actions/permissions/workflow \
		--method PUT \
		--field default_workflow_permissions=write \
		--field can_approve_pull_request_reviews=false
	@echo "✓ Workflow permissions updated"
