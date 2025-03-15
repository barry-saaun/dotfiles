#!/bin/bash

VAULT_PATH="/Users/barry/Documents/Obsidian Vault"
GIT_PATH="/opt/homebrew/bin/git"
TERMINAL_NOTIFIER_PATH="/opt/homebrew/bin/terminal-notifier"

cd "$VAULT_PATH" || exit

# Check if there are any changes
if ! "$GIT_PATH" diff --quiet; then
	# Add all changes to the staging area
	"$GIT_PATH" add .

	# Commit changes only if there are staged changes
	if ! "$GIT_PATH" diff --cached --quiet; then
		"$GIT_PATH" commit -m "Daily auto backup: $(date)"
		"$GIT_PATH" push origin main
		echo "Changes committed and pushed."
		"$TERMINAL_NOTIFIER_PATH" -title "Git Backup Notification" -message "Changes committed and pushed."
	else
		echo "No changes to commit."
		"$TERMINAL_NOTIFIER_PATH" -title "Git Backup Notification" -message "No changes to commit."
	fi
else
	echo "No changes detected."
	"$TERMINAL_NOTIFIER_PATH" -title "Git Backup Notification" -message "No changes detected."
fi
