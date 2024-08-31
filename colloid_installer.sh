#!/bin/bash

# Repository
REPO="vinceliuice/Colloid-icon-theme"

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m'

get_latest_release_tag() {
  echo -e "${CYAN}Fetching the latest release tag...${NC}"
  TAG=$(curl --silent "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

  if [ -z "$TAG" ]; then
    echo -e "${RED}Failed to fetch the latest release tag.${NC}"
    exit 1
  fi

  echo -e "${GREEN}Latest release tag is: $TAG${NC}"
}

# Download the release
download_latest_release() {
  DOWNLOAD_URL="https://github.com/$REPO/archive/refs/tags/$TAG.zip"
  echo -e "${CYAN}Downloading the latest release from ${DOWNLOAD_URL}...${NC}"
  curl -L -o latest_release.zip "$DOWNLOAD_URL"

  if [ ! -f "latest_release.zip" ]; then
    echo -e "${RED}Failed to download the latest release.${NC}"
    exit 1
  fi

  echo -e "${CYAN}Extracting the zip file...${NC}"
  unzip -o latest_release.zip

  EXTRACTED_DIR=$(unzip -Z -1 latest_release.zip | head -n 1 | cut -d '/' -f 1)
  cd "$EXTRACTED_DIR" || exit
}

# Clean up
clean_up() {
  cd ..
  rm -f latest_release.zip
}

remove_old_directories() {
  echo -e "${CYAN}Checking for old Colloid-icon-theme directories...${NC}"
  for dir in Colloid-icon-theme-*; do
    if [[ -d $dir ]]; then
      echo -e "${RED}Removing existing directory: $dir${NC}"
      rm -rf "$dir"
    fi
  done
}

# Colorscheme
choose_scheme() {
  echo -e "${YELLOW}Choose a folder colorscheme variant:${NC}"
  echo -e "1) ${GREEN}Default${NC}"
  echo -e "2) ${GREEN}Nord${NC}"
  echo -e "3) ${GREEN}Dracula${NC}"
  echo -e "4) ${GREEN}Gruvbox${NC}"
  echo -e "5) ${GREEN}Everforest${NC}"
  echo -e "6) ${GREEN}Catppuccin${NC}"
  echo -e "7) ${GREEN}All${NC}"
  echo -e -n "${MAGENTA}Enter your choice [1-7]: ${NC}"
  read -r scheme_choice

  case $scheme_choice in
    1) SCHEME="default" ;;
    2) SCHEME="nord" ;;
    3) SCHEME="dracula" ;;
    4) SCHEME="gruvbox" ;;
    5) SCHEME="everforest" ;;
    6) SCHEME="catppuccin" ;;
    7) SCHEME="all" ;;
    *) echo -e "${RED}Invalid choice! Defaulting to 'default'.${NC}"; SCHEME="default" ;;
  esac
}

# Folder color variant
choose_theme() {
  echo -e "${YELLOW}Choose a folder color variant:${NC}"
  echo -e "1) ${GREEN}Blue (Default)${NC}"
  echo -e "2) ${GREEN}Purple${NC}"
  echo -e "3) ${GREEN}Pink${NC}"
  echo -e "4) ${GREEN}Red${NC}"
  echo -e "5) ${GREEN}Orange${NC}"
  echo -e "6) ${GREEN}Yellow${NC}"
  echo -e "7) ${GREEN}Green${NC}"
  echo -e "8) ${GREEN}Teal${NC}"
  echo -e "9) ${GREEN}Grey${NC}"
  echo -e "10) ${GREEN}All${NC}"
  echo -e -n "${MAGENTA}Enter your choice [1-10]: ${NC}"
  read -r theme_choice

  case $theme_choice in
    1) THEME="default" ;;
    2) THEME="purple" ;;
    3) THEME="pink" ;;
    4) THEME="red" ;;
    5) THEME="orange" ;;
    6) THEME="yellow" ;;
    7) THEME="green" ;;
    8) THEME="teal" ;;
    9) THEME="grey" ;;
    10) THEME="all" ;;
    *) echo -e "${RED}Invalid choice! Defaulting to 'default'.${NC}"; THEME="default" ;;
  esac
}

# KDE Plasma tinting option
is_gnome() {
  if [[ "$(echo $XDG_CURRENT_DESKTOP)" == "GNOME" || "$(echo $XDG_SESSION_DESKTOP)" == "gnome" ]]; then
    return 0
  else
    return 1
  fi
}

choose_notint() {
  if is_gnome; then
    echo -e "${CYAN}GNOME detected. Skipping KDE Plasma tinting option.${NC}"
    NOTINT_FLAG=""
  else
    echo -e "${YELLOW}Disable Follow ColorScheme for folders on KDE Plasma?${NC}"
    echo -e "1) ${GREEN}Yes${NC}"
    echo -e "2) ${GREEN}No${NC}"
    echo -e -n "${MAGENTA}Enter your choice [1-2]: ${NC}"
    read -r notint_choice

    case $notint_choice in
      1) NOTINT_FLAG="--notint" ;;
      2) NOTINT_FLAG="" ;;
      *) echo -e "${RED}Invalid choice! Defaulting to 'No'.${NC}"; NOTINT_FLAG="" ;;
    esac
  fi
}

# Start script
echo -e "${BLUE}Starting Colloid Icon Theme Installer...${NC}"
get_latest_release_tag
choose_scheme
choose_theme
choose_notint
remove_old_directories
download_latest_release
echo -e "${CYAN}Running the install script...${NC}"
./install.sh -s "$SCHEME" -t "$THEME" $NOTINT_FLAG
clean_up
echo -e "${GREEN}Installation completed.${NC}"
