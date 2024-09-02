#!/bin/bash

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
RED='\033[0;31m'
NC='\033[0m'

# SUDO
if [ "$EUID" -ne 0 ]; then
  echo -e "${YELLOW}This script requires superuser privileges. Please enter your password.${NC}"
  sudo -v
fi

# Get the latest release URL
get_latest_release() {
  curl -s https://api.github.com/repos/th-ch/youtube-music/releases/latest \
  | grep "browser_download_url.*\.rpm" \
  | cut -d '"' -f 4
}

# Download and install
install_latest_rpm() {
  local url=$(get_latest_release)
  local file_name=$(basename "$url")
  
  echo -e "${YELLOW}Downloading the latest .rpm file: ${file_name}${NC}"
  curl -L -o "$file_name" "$url"
  
  if [ $? -eq 0 ]; then
    echo -e "${GREEN}Downloaded successfully.${NC}"
    echo -e "${YELLOW}Installing ${file_name}${NC}"
    sudo rpm -i "$file_name"
    if [ $? -eq 0 ]; then
      echo -e "${GREEN}Installed successfully.${NC}"
    else
      echo -e "${RED}Installation failed. Please try again.${NC}"
      exit 1
    fi
  else
    echo -e "${RED}Download failed. Please try again.${NC}"
    exit 1
  fi
}

# Menu
echo -e "${CYAN}YouTube Music Installer${NC}"
echo -e "${CYAN}-----------------------${NC}"
echo -e "${YELLOW}This script will install the latest RPM version of YouTube Music from ${CYAN}https://github.com/th-ch/youtube-music${NC}"
echo -e "${CYAN}1. Continue with the installation${NC}"
echo -e "${CYAN}0. Exit${NC}"

read -p "Please choose an option (1 or 0): " choice

case $choice in
  1)
    install_latest_rpm
    ;;
  0)
    echo -e "${CYAN}Exiting the installer.${NC}"
    exit 0
    ;;
  *)
    echo -e "${RED}Invalid option. Please choose 1 to continue or 0 to exit.${NC}"
    exit 1
    ;;
esac

echo -e "${GREEN}This script is made possible by Burhanverse.${NC}"
