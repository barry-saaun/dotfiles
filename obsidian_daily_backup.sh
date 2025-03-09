#!/bin/bash

VAULT_PATH="/Users/barry/Documents/Obsidian Vault"

cd "$VAULT_PATH" || exit

# Check if there are any changes
if ! /opt/homebrew/bin/git diff --quiet; then
	# Add all changes to the staging area
	/opt/homebrew/bin/git add .

	# Commit changes only if there are staged changes
	if ! /opt/homebrew/bin/git diff --cached --quiet; then
		/opt/homebrew/bin/git commit -m "Daily auto backup: $(date)"
		/opt/homebrew/bin/git push origin main
		echo "Changes committed and pushed."
		terminal-notifier -title "Obsidian Vault Backup Notification" -message "Changes committed and pushed."
	else
		echo "No changes to commit."
		terminal-notifier -title "Obsidian Vault Backup Notification" -message "No changes to commit."
	fi
else
	echo "No changes detected."
	terminal-notifier -title "Obsidian Vault Backup Notification" -message "No changes detected."
fi
