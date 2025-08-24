#!/bin/bash

# macOS Login Screen Wallpaper Manager
# Usage: ./login_wallpaper.sh [set|revert] [image_path]

SCRIPT_NAME="$(basename "$0")"
BACKUP_DIR="$HOME/.login_wallpaper_backup"
BACKUP_FILE="$BACKUP_DIR/original_settings.plist"

show_help() {
	echo "Usage: $SCRIPT_NAME [COMMAND] [OPTIONS]"
	echo ""
	echo "Commands:"
	echo "  --set <image_path>    Set login screen wallpaper to specified image"
	echo "  --revert              Restore original login screen wallpaper"
	echo "  --help                Show this help message"
	echo ""
	echo "Examples:"
	echo "  $SCRIPT_NAME set ~/Pictures/login-bg.jpg"
	echo "  $SCRIPT_NAME revert"
}

check_requirements() {
	# Check if running on macOS
	if [[ "$(uname)" != "Darwin" ]]; then
		echo "Error: This script only works on macOS" >&2
		exit 1
	fi

	# Check if desktoppr is installed
	if ! command -v desktoppr &>/dev/null; then
		echo "Installing desktoppr..."
		if command -v brew &>/dev/null; then
			brew install desktoppr
		else
			echo "Error: desktoppr not found and Homebrew not available" >&2
			echo "Please install desktoppr manually or install Homebrew first" >&2
			echo "Homebrew: https://brew.sh" >&2
			echo "desktoppr: https://github.com/scriptingosx/desktoppr" >&2
			exit 1
		fi
	fi
}

create_backup() {
	echo "Creating backup of current settings..."
	mkdir -p "$BACKUP_DIR"

	# Backup current login window settings
	sudo defaults export /Library/Preferences/com.apple.loginwindow "$BACKUP_FILE" 2>/dev/null || {
		echo "Warning: Could not backup login window preferences"
	}

	echo "Backup created at: $BACKUP_FILE"
}

set_login_wallpaper() {
	local image_path="$1"

	# Validate image file
	if [[ ! -f "$image_path" ]]; then
		echo "Error: Image file not found: $image_path" >&2
		exit 1
	fi

	# Check if file is an image
	if ! file "$image_path" | grep -qE "(JPEG|PNG|GIF|TIFF|BMP)" 2>/dev/null; then
		echo "Warning: File may not be a valid image format"
	fi

	# Convert to absolute path
	image_path="$(realpath "$image_path")"

	echo "Setting login screen wallpaper to: $image_path"

	# Create backup if it doesn't exist
	if [[ ! -f "$BACKUP_FILE" ]]; then
		create_backup
	fi

	# Set the login window background
	sudo defaults write /Library/Preferences/com.apple.loginwindow DesktopPicture "$image_path"

	# Alternative method using desktoppr for login screen
	sudo desktoppr loginwindow "$image_path" 2>/dev/null || {
		echo "Warning: desktoppr method failed, using defaults method only"
	}

	echo "Login screen wallpaper set successfully!"
	echo "Changes will take effect after next logout/login or system restart"
}

revert_wallpaper() {
	if [[ ! -f "$BACKUP_FILE" ]]; then
		echo "Error: No backup found. Cannot revert changes." >&2
		echo "Backup should be located at: $BACKUP_FILE" >&2
		exit 1
	fi

	echo "Reverting to original login screen wallpaper..."

	# Remove the custom setting
	sudo defaults delete /Library/Preferences/com.apple.loginwindow DesktopPicture 2>/dev/null || {
		echo "No custom DesktopPicture setting found to remove"
	}

	# Try to restore from backup
	sudo defaults import /Library/Preferences/com.apple.loginwindow "$BACKUP_FILE" 2>/dev/null || {
		echo "Warning: Could not restore from backup file"
	}

	# Reset to system default using desktoppr
	sudo desktoppr loginwindow default 2>/dev/null || {
		echo "Warning: Could not reset using desktoppr"
	}

	echo "Login screen wallpaper reverted successfully!"
	echo "Changes will take effect after next logout/login or system restart"
}

# Main script logic
case "${1:-}" in
"set" | "-s" | "--set")
	if [[ -z "${2:-}" ]]; then
		echo "Error: Image path required for 'set' command" >&2
		show_help
		exit 1
	fi
	check_requirements
	set_login_wallpaper "$2"
	;;
"revert" | "-r" | "--revert")
	revert_wallpaper
	;;
"help" | "-h" | "--help")
	show_help
	;;
"")
	echo "Error: No command specified" >&2
	show_help
	exit 1
	;;
*)
	echo "Error: Unknown command '$1'" >&2
	show_help
	exit 1
	;;
esac
