# Introduction
This script is designed to automate the installation of dependencies, download and install Sublime Text along with specific packages, and finally, play a sound file from a GitHub repository once the script completes its execution. The script is structured to ensure that all necessary components are installed and configured properly, with safeguards to handle potential errors.

# Script Overview
The script performs the following tasks:

- Defines color codes for terminal output to make the script's output more readable and organized.
- Checks and installs dependencies to ensure all required tools are available.
- Preloads a sound file from a GitHub repository to ensure it is ready to be played at the end of the script.
- Installs Sublime Text and specific packages, verifying their successful installation.
- Plays a sound file upon script completion as a final indication of success.
- Cleans up any background processes related to mpv that were started during the script execution.

## Define colors
```bash
DARK_ELECTRIC_BLUE='\033[0;94m'
GREEN='\033[0;32m'
RED='\033[0;31m'
Purple='\033[0;35m'
ORANGE='\033[0;33m'
NC='\033[0m' # No Color
```
## These color codes are used to format the text output in the terminal. They make the script's output more visually appealing and easier to understand.

DARK_ELECTRIC_BLUE: Used for the final message.
GREEN: Used to indicate success.
RED: Used to indicate errors or important notices.
Purple: Used for general informational messages.
ORANGE: Used for warnings or notices.
NC: Resets the color back to the default.

## Function to Check If a Command Exists
This function checks whether a given command is available on the system. It takes one argument (the command to check) and returns true if the command exists, or false otherwise.
```bash
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
```
## Function to Install Dependencies
This function ensures that a specified package is installed on the system. It first checks if the package exists using the command_exists function. If the package is not found, it attempts to install it using apt-get. If the installation fails, the script exits with an error.
```bash
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
```
## List of Dependencies
This array lists all the dependencies that the script will check and install if necessary. These dependencies are essential for various operations within the script.
```bash
DEPENDENCIES=("curl" "jq" "python3-termcolor" "pv" "git" "unzip" "p7zip-full" "gzip" "rsync" "awk" "sed" "openssl" "xclip" "xsel" "mpv")
```
## Install Dependencies Before Anything Else
This loop iterates over each dependency in the DEPENDENCIES array and uses the check_and_install function to ensure they are installed.
```bash
for dep in "${DEPENDENCIES[@]}"; do
    check_and_install "$dep"
done
```
## GitHub URL to the Sound File
This variable stores the URL to the sound file that will be preloaded and played at the end of the script. The file is hosted on GitHub and can be replaced with any other direct link to an audio file.
```bash
Scourge_horn_mp3="https://raw.githubusercontent.com/Shellshock9001/mp3_files/main/scourge_horn.ogg"
```
## Function to Clean Up All mpv Processes
This function is designed to terminate all mpv processes that were started by the script. It ensures that no lingering processes remain after the script completes.
```bash
cleanup() {
    echo -e "${RED}Cleaning up mpv processes...${NC}"
    pkill -f "mpv --no-terminal"
}
```
## Setting a Trap to Clean Up on Exit
This command sets up a trap that will automatically invoke the cleanup function when the script exits, ensuring that all mpv processes are cleaned up.
```bash
trap cleanup EXIT
```
## Preloading the Sound File
This section preloads the sound file from GitHub to ensure it is cached and ready to be played at the end of the script. The mpv command here is run with --mute and --no-video to preload the file silently.
- Customization: Adjust the --cache-secs parameter to change how much of the file is preloaded.
```bash
echo -e "${Purple}Preloading scourge_horn.ogg sound file...${NC}"
mpv --no-terminal --cache=yes --cache-secs=10 --mute --no-video "$Scourge_horn_mp3" --length=1
echo -e "${GREEN}Preloading complete.${NC}"
```
## Checking and Installing Sublime Text
This block checks if Sublime Text is installed. If not, it adds the Sublime Text repository, installs the GPG key, and installs Sublime Text. It then verifies the installation and proceeds accordingly.
```bash
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
```
## Sublime Text Package Installation
This section of the script handles downloading and installing specific Sublime Text packages. It uses jq to parse the channel file and find the correct URLs for the packages.

- Customization: Add or remove packages from the PACKAGE_NAMES array as needed.

```bash
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
```
## Final Goodbye Message
This is a final message. 
Friendly reminder to follow my social media pages.
```bash
echo -e "${DARK_ELECTRIC_BLUE}Don't forget to follow me on LinkedIn: https://www.linkedin.com/in/gustavoflores9001/ and GitHub: https://github.com/Shellshock9001/${NC}"
```
## Playing the Sound File
Finally, the script plays the preloaded sound file using mpv. This serves as an audible indication that the script has completed successfully.
```bash
mpv --no-terminal "$Scourge_horn_mp3"
```
## Conclusion
This script is designed to be flexible and customizable while ensuring that all necessary components are installed and configured correctly. By following the detailed explanations provided in this documentation, users can modify the script to suit their specific needs.
