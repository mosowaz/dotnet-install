#!/bin/bash
set -eo pipefail

# Remove old .NET packages
sudo apt-get remove 'dotnet*' 'aspnet*' 'netstandard*' -y

echo -e "Installing required dependencies...\n"
if ! command -v wget >/dev/null 2>&1 then
  sudo apt-get update -qq
  sudo apt-get install -y wget
fi

# Download Microsoft package repository
echo -e "\nDownloading Microsoft package repository..."
wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

# Update package lists
sudo apt-get update -qq

# Install .NET 10 SDK
echo "Installing dotnet package..."
sudo apt-get install -y dotnet-sdk-10.0

# Verify installation
dotnet --version
dotnet --list-sdks
