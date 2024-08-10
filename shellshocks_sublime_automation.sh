#!/bin/bash

# Define colors
DARK_ELECTRIC_BLUE='\033[0;94m'
GREEN='\033[0;32m'
RED='\033[0;31m'
Purple='\033[0;35m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color

# Function to check if a command exists

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Checks if dependencies are installed. If not it will install them.

check_and_install() {
    PACKAGE=$1
    if ! command_exists "$PACKAGE"; then
        echo -e "${Purple}$PACKAGE is not installed. Installing...${NC}"
        sudo apt-get update && sudo apt-get install -y "$PACKAGE"
        if [ $? -ne 0 ]; then
            echo -e "${RED}Failed to install $PACKAGE. Please install it manually.${NC}"
            exit 1
        fi
        echo -e "${GREEN}$PACKAGE installed successfully.${NC}"
    else
        echo -e "${GREEN}$PACKAGE is already installed.${NC}"
    fi
}

# List of dependencies

DEPENDENCIES=("curl" "jq" "python3-termcolor" "pv" "git" "unzip" "p7zip-full" "gzip" "rsync" "awk" "sed" "openssl" "xclip" "xsel" "mpv")

# Install dependencies before anything else
for dep in "${DEPENDENCIES[@]}"; do
    check_and_install "$dep"
done

# GitHub URL to the sound file (use the raw URL for direct streaming)

Scourge_horn_mp3="https://raw.githubusercontent.com/Shellshock9001/mp3/main/scourge_horn.ogg"

# Function to clean up all mpv processes
cleanup() {
    echo -e "${RED}Cleaning up mpv processes...${NC}"
    pkill -f "mpv --no-terminal"
}

# Set trap to clean up mpv processes on exit
trap cleanup EXIT

# Preload sound file from GitHub: https://github.com/Shellshock9001/mp3 silently to ensure it's cached

echo -e "${Purple}Preloading scourge_horn.ogg sound file...${NC}"
mpv --no-terminal --cache=yes --cache-secs=10 --mute --no-video "$Scourge_horn_mp3" --length=1
echo -e "${GREEN}Preloading complete.${NC}"

# Check if Sublime Text is installed; if not, install it
if command_exists subl; then
    echo -e "${ORANGE}Sublime Text is already installed.${NC}"
else
    echo -e "${ORANGE}Sublime Text is not installed. Installing now...${NC}"

    # Ensure apt is set up to work with https sources
    sudo apt-get install apt-transport-https -y

    # Install the GPG key
    wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg > /dev/null

    # Select the channel to use (Stable)
    echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

    # Update apt and install Sublime Text
    sudo apt-get update
    sudo apt-get install sublime-text -y

    # Verify the installation
    if command_exists subl; then
        echo -e "${GREEN}Sublime Text installation successful.${NC}"
    else
        echo -e "${RED}Sublime Text installation failed.${NC}"
        exit 1
    fi
fi

echo -e "${ORANGE}Sublime Text setup complete.${NC}"

# Hardcoded package names. Separate with just spaces, no commas
PACKAGE_NAMES=("1337 Color Scheme" "Monokai Blueberry Color Scheme")

CHANNEL_URL="https://packagecontrol.io/channel_v3.json"
CHANNEL_FILE="channel_v3.json"

# Download the channel file from https://packagecontrol.io/channel_v3.json.
echo -e "${Purple}Downloading the channel file...${NC}"
curl -s -o "$CHANNEL_FILE" "$CHANNEL_URL"

# Check if the download was successful
if [ ! -f "$CHANNEL_FILE" ]; then
    echo -e "${RED}Failed to download the channel file.${NC}"
    exit 1
fi

# Define the install path
SUBLIME_PACKAGES_PATH="$HOME/.config/sublime-text/Installed Packages"

# Iterate over each package name that you chose
for PACKAGE_NAME in "${PACKAGE_NAMES[@]}"; do
    echo -e "${Purple}Processing package: ${PACKAGE_NAME}${NC}"

    # Replace spaces with underscores for the package file name
    PACKAGE_FILE_NAME="${PACKAGE_NAME// /_}.sublime-package"

    # Check if the package is already installed
    if [ -f "$SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME" ]; then
        echo -e "${GREEN}Package $PACKAGE_NAME is already installed at $SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME. Skipping...${NC}"
        continue
    fi

    # Search for the package in the channel file
    PACKAGE_URL=$(jq -r --arg PACKAGE_NAME "$PACKAGE_NAME" '
      .packages_cache[] |
      .[] |
      select(.name == $PACKAGE_NAME) |
      .releases[0].url' "$CHANNEL_FILE")

    # Check if the package was found
    if [ -z "$PACKAGE_URL" ]; then
        echo -e "${RED}Package $PACKAGE_NAME not found in channel_v3.json${NC}"
        continue
    fi

    # Get the content length
    CONTENT_LENGTH=$(curl -sI "$PACKAGE_URL" | grep -i Content-Length | awk '{print $2}' | tr -d '\r')

    # Download the package with a progress bar and time estimate, only if Content-Length is available
    if [ -n "$CONTENT_LENGTH" ]; then
        echo -e "${Purple}Downloading $PACKAGE_NAME...${NC}"
        curl -L "$PACKAGE_URL" | pv -p -t -e -r -s "$CONTENT_LENGTH" > "$SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME"
    else
        echo -e "${Purple}Downloading $PACKAGE_NAME without Content-Length...${NC}"
        curl -L -o "$SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME" "$PACKAGE_URL"
    fi

    # Check if the package was downloaded successfully
    if [ ! -f "$SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME" ]; then
        echo -e "${RED}Failed to download $PACKAGE_NAME package.${NC}"
        continue
    fi

    echo -e "${GREEN}Package $PACKAGE_NAME installed successfully at $SUBLIME_PACKAGES_PATH/$PACKAGE_FILE_NAME${NC}"
done

# Final goodbye message
echo -e "${DARK_ELECTRIC_BLUE}Don't forget to follow me on LinkedIn: https://www.linkedin.com/in/gustavoflores9001/ and GitHub: https://github.com/Shellshock9001/${NC}"

# Plays scourge_horn.ogg mp3 file when the script is complete.
mpv --no-terminal "$Scourge_horn_mp3"