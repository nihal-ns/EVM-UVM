# Set your main branch name. It's usually "main" or "master".
MAIN_BRANCH = main

# Default commit message if none is provided via M=
M ?= "wip: auto-commit from makefile"

.PHONY: commit sync

##
## commit: Adds all current changes (including deletions) and creates a commit
##
## Usage:
##   make commit M="Your commit message"
##
commit:
	@echo "--- Adding all changes and committing ---"
	@git add -A
	@git commit -m "$(M)" || echo "No changes to commit."


##
## sync: Syncs your feature branch with main and pushes the update
##
## Usage:
##   make sync BRANCH=sub
##
sync:
	# (0) Check if BRANCH variable was provided
	@if [ -z "$(BRANCH)" ]; then \
		echo "ERROR: BRANCH variable is not set."; \
		echo "Usage: make sync BRANCH=<your-branch-name>"; \
		exit 1; \
	fi

	@echo "--- Starting sync for branch: $(BRANCH) ---"

	# (1) Switch to main branch
	@echo "--- (1/8) Switching to $(MAIN_BRANCH) ---"
	@git checkout $(MAIN_BRANCH)

	# (2) Git pull
	@echo "--- (2/8) Pulling latest $(MAIN_BRANCH) from remote ---"
	@git pull

	# (3) Switch to user branch
	@echo "--- (3/8) Switching to your branch: $(BRANCH) ---"
	@git checkout $(BRANCH)

	# (4) Git rebase main
	@echo "--- (4/8) Rebasing $(BRANCH) on top of $(MAIN_BRANCH) ---"
	@git rebase $(MAIN_BRANCH)

	# (5) Switch to main branch
	@echo "--- (5/8) Switching back to $(MAIN_BRANCH) ---"
	@git checkout $(MAIN_BRANCH)

	# (6) Git rebase user branch (This fast-forwards 'main' to match your branch)
	@echo "--- (6/8) Fast-forwarding $(MAIN_BRANCH) to $(BRANCH)'s state ---"
	@git rebase $(BRANCH)

	# (7) Git push (Pushes the updated 'main' branch)
	@echo "--- (7/8) Pushing updated $(MAIN_BRANCH) to remote ---"
	@git push

	# (8) Switch to user branch
	@echo "--- (8/8) Switching back to your branch: $(BRANCH) ---"
	@git checkout $(BRANCH)

	@echo "--- Sync complete for $(BRANCH) ---"
