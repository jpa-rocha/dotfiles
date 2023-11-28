#! /usr/bin/bash

RIPGREP_VERSION='13.0.0'
RIPGREP_FILE="ripgrep_${RIPGREP_VERSION}_amd64.deb"
SHARKFD_VERSION='8.7.1'
SHARKFD_FILE="fd-musl_${SHARKFD_VERSION}_amd64.deb"

# Regular text colors
BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[0;37m'

# Bold text colors
BOLD_BLACK='\033[1;30m'
BOLD_RED='\033[1;31m'
BOLD_GREEN='\033[1;32m'
BOLD_YELLOW='\033[1;33m'
BOLD_BLUE='\033[1;34m'
BOLD_PURPLE='\033[1;35m'
BOLD_CYAN='\033[1;36m'
BOLD_WHITE='\033[1;37m'

# Background colors
BG_BLACK='\033[40m'
BG_RED='\033[41m'
BG_GREEN='\033[42m'
BG_YELLOW='\033[43m'
BG_BLUE='\033[44m'
BG_PURPLE='\033[45m'
BG_CYAN='\033[46m'
BG_WHITE='\033[47m'

# Reset text formatting
RESET='\033[0m'

echo -e ""
echo -e "${YELLOW}Checking for updates:${RESET}"
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install xsel
echo -e ""

echo -e "${YELLOW}##############################################################################${RESET}"
echo -e "${YELLOW}########################## ${BOLD_GREEN}Installing Dependencies${YELLOW} ###########################${RESET}"
echo -e "${YELLOW}##############################################################################${RESET}"

echo -e ""

# check / install rg
if ! command -v rg &> /dev/null
then
    echo -e "rg: ${BOLD_RED}NOT INSTALLED${RESET}"
    curl -LO "https://github.com/BurntSushi/ripgrep/releases/download/${RIPGREP_VERSION}/${RIPGREP_FILE}"
    sudo dpkg -i "${RIPGREP_FILE}"
    rm ${RIPGREP_FILE}
    echo -e "rg: ${BOLD_GREEN}INSTALLED${RESET}"
else
    echo -e "rg: ${BOLD_GREEN}INSTALLED${RESET}"
fi

# check / instal fd

if ! command -v fd &> /dev/null
then
    echo -e "fd: ${BOLD_RED}NOT INSTALLED${RESET}"
    curl -LO "https://github.com/sharkdp/fd/releases/download/${SHARKFD_VERSION}/${SHARKFD_FILE}"
    sudo dpkg -i "${SHARKFD_FILE}"
    ln -s "$(which fdfind)" ~/.local/bin/fdi
    rm ${SHARKFD_FILE}
    echo -e "fd: ${BOLD_GREEN}INSTALLED${RESET}"
else
    echo -e "fd: ${BOLD_GREEN}INSTALLED${RESET}"
fi

# check npm

if ! command -v npm &> /dev/null
then
    echo -e "npm: ${BOLD_RED}NOT INSTALLED${RESET}"
    sudo apt install -y npm
    echo -e "npm: ${BOLD_GREEN}INSTALLED${RESET}"
else
    echo -e "npm: ${BOLD_GREEN}INSTALLED${RESET}"
fi


# check rust
if ! command -v rustup &> /dev/null
then
    echo -e "rust: ${BOLD_RED}NOT INSTALLED${RESET}"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    echo -e "rust: ${BOLD_GREEN}INSTALLED${RESET}"
else
    echo -e "rust: ${BOLD_GREEN}INSTALLED${RESET}"
fi

