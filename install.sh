#! /usr/bin/bash
CONFIG_PATH="$HOME/.config/dotfiles/"
BASHRC="$HOME/.zshrc"
GO_VERSION="1.22.3"
GO_FILE="go${GO_VERSION}.linux-amd64.tar.gz"
NVIM_VERSION="0.10.0"
NVIM_FOLDER="nvim-linux64"
NVIM_FILE="${NVIM_FOLDER}.tar.gz"

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

function check_bashrc {
    local file_path="$1"
    local line_to_check="$2"

    # Check if the line is present in the file
    if ! grep -Fxq "$line_to_check" "$file_path"; then
        echo "$line_to_check" >> "$file_path"
    fi
}

function install_go {
    sudo curl -LO "https://go.dev/dl/${GO_FILE}"
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "${GO_FILE}" 
    check_bashrc "${BASHRC}" "export PATH=\$PATH:/usr/local/go/bin"
    sudo rm ${GO_FILE}
    echo -e "go: ${BOLD_GREEN}INSTALLED"
}

function install_nvim {
    sudo curl -LO "https://github.com/neovim/neovim/releases/download/stable/${NVIM_FILE}"
    tar -C "${CONFIG_PATH}" -xzf "${NVIM_FILE}"

    # clean up
    sudo rm -rf "$HOME/nvim/nvim-linux64/"
    sudo rm -rf "$HOME/.config/nvim"
    sudo rm -rf "$HOME/nvim"
    sudo rm -rf "/usr/bin/nvim"

    mv "${CONFIG_PATH}${NVIM_FOLDER}" "$HOME/nvim"
    sudo rm -rf ${NVIM_FOLDER}
    sudo rm -rf ${NVIM_FILE}
    if [ ! -d "$folder_path" ]; then
        ln -s "${CONFIG_PATH}/nvim" "$HOME/.config/nvim"
    fi
    # create symlink
    if [ ! -f "/usr/bin/nvim" ]; then
        sudo ln -s "$HOME/nvim/bin/nvim" "/usr/bin/nvim"
    fi
    if ! command -v nvim &> /dev/null
        then
            echo -e "nvim: ${BOLD_RED}NOT INSTALLED"
            exit 1
        else
            echo -e "nvim: ${BOLD_GREEN}INSTALLED"
            folder_path="$HOME/.config/nvim"
            # setup config folder
            # add aliases
            check_bashrc "${BASHRC}" "alias vi='nvim'"
            check_bashrc "${BASHRC}" "alias vim='nvim'"
    fi
}

echo -e "${YELLOW}Install dependencies? (y/n)${RESET}"
read -r dependencies

if [ "$dependencies" == "y" ]
then
    echo -e "${YELLOW}##############################################################################${RESET}"
    echo -e "${YELLOW}########################## ${BOLD_GREEN}Installing Dependencies${YELLOW} ###########################${RESET}"
    echo -e "${YELLOW}##############################################################################${RESET}"

    echo -e ""
    echo -e "${YELLOW}Checking for updates...${RESET}"
    sudo dnf update
    sudo dnf upgrade -y
    sudo dnf install -y xclip curl gcc make clang fzf zsh 

    cp .zshrc $HOME/
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
    test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    if ! grep -Fxq "eval \"\$($(brew --prefix)/bin/brew shellenv)\""  "${BASHRC}"; then
        echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> "${BASHRC}"
    fi
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sudo cp ./fonts/*.ttf /usr/share/fonts/
    sudo fc-cache -f -v

    echo -e ""

    # check / install rg
    if ! command -v rg &> /dev/null
    then
        echo -e "rg: ${BOLD_RED}NOT INSTALLED${RESET}"
	sudo dnf install ripgrep
        echo -e "rg: ${BOLD_GREEN}INSTALLED${RESET}"
    else
        echo -e "rg: ${BOLD_GREEN}INSTALLED${RESET}"
    fi

    # check / instal fd

    if ! command -v fd &> /dev/null
    then
        echo -e "fd: ${BOLD_RED}NOT INSTALLED${RESET}"
	sudo dnf install fd-find
        echo -e "fd: ${BOLD_GREEN}INSTALLED${RESET}"
    else
        echo -e "fd: ${BOLD_GREEN}INSTALLED${RESET}"
    fi

    # check npm

    if ! command -v npm &> /dev/null
    then
        echo -e "npm: ${BOLD_RED}NOT INSTALLED${RESET}"
        sudo dnf install -y npm
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
        echo -e "${YELLOW}Checking for updates...${RESET}"
        rustup update
        echo -e "rust: ${BOLD_GREEN}INSTALLED${RESET}"
    fi

    # check go
    if ! command -v go &> /dev/null
    then
        install_go
    else
        echo -e "Checking for updates..."
        check_version=$(go version)
        if [[ $check_version == *"$GO_VERSION"* ]]; then
            echo -e "go: ${BOLD_GREEN}INSTALLED"
        else
            install_go
        fi
    fi
fi

echo -e "${YELLOW}Install NVIM? (y/n)${RESET}"
read -r get_nvim

if [ "$get_nvim" == "y" ]
then
    echo -e ""

    echo -e "${YELLOW}##############################################################################${RESET}"
    echo -e "${YELLOW}############################## ${BOLD_GREEN}Installing NVIM${YELLOW} ###############################${RESET}"
    echo -e "${YELLOW}##############################################################################${RESET}"

    echo -e ""

    # nvim
    if ! command -v nvim &> /dev/null
    then
        install_nvim
    else
        echo -e "Checking for updates..."
        check_version=$(nvim --version)
        if [[ $check_version == *"$NVIM_VERSION"* ]]; then
            echo -e "nvim: ${BOLD_GREEN}INSTALLED"
        else
            install_nvim
        fi
        
    fi
fi

echo -e "${YELLOW}Install TMUX? (y/n)${RESET}"
read -r get_tmux

if [ "$get_tmux" == "y" ]
then
    echo -e ""

    echo -e "${YELLOW}##############################################################################${RESET}"
    echo -e "${YELLOW}############################## ${BOLD_GREEN}Installing TMUX${YELLOW} ###############################${RESET}"
    echo -e "${YELLOW}##############################################################################${RESET}"

    echo -e ""

    # tmux
    if ! command -v tmux &> /dev/null
    then
        sudo dnf install tmux
        echo -e "tmux: ${BOLD_GREEN}INSTALLED${RESET}"
    else
            echo -e "tmux: ${BOLD_GREEN}INSTALLED${RESET}"
    fi
    
    tmux_config="$HOME/.config/tmux"
    if [ ! -d "$tmux_config" ]; then
        ln -s "${CONFIG_PATH}/tmux" "$HOME/.config/tmux"
    fi
    tmux_bash=$"if command -v tmux &>/dev/null && [ -z \"$TMUX\" ]; then tmux attach -t default || tmux new -s default"
    if ! grep -Fxq "${tmux_bash}"  "${BASHRC}"; then
        echo "$tmux_bash" >> "${BASHRC}"
        echo "fi" >> "${BASHRC}"

    fi
fi
