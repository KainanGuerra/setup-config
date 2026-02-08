#!/usr/bin/env bash

set -e

echo "🚀 Starting Ubuntu Dev Setup..."

############################################
# Helpers
############################################

command_exists() {
  command -v "$1" >/dev/null 2>&1
}

install_if_missing() {
  if ! command_exists "$1"; then
    echo "📦 Installing $1..."
    eval "$2"
  else
    echo "✅ $1 already installed"
  fi
}

############################################
# Update system
############################################

echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y

############################################
# Base packages
############################################

sudo apt install -y \
  build-essential \
  ca-certificates \
  software-properties-common \
  apt-transport-https \
  gnupg \
  lsb-release

############################################
# curl
############################################

install_if_missing curl "sudo apt install -y curl"

############################################
# wget
############################################

install_if_missing wget "sudo apt install -y wget"

############################################
# Git
############################################

install_if_missing git "sudo apt install -y git"

############################################
# Zsh + Oh My Zsh
############################################

if ! command_exists zsh; then
  sudo apt install -y zsh
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "✨ Installing Oh My Zsh..."
  RUNZSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Set default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s "$(which zsh)"
fi

############################################
# NVM + Node + npm + npx
############################################

if [ ! -d "$HOME/.nvm" ]; then
  echo "📦 Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
fi

export NVM_DIR="$HOME/.nvm"
source "$NVM_DIR/nvm.sh"

if ! command_exists node; then
  echo "📦 Installing Node LTS..."
  nvm install --lts
  nvm use --lts
fi

############################################
# Python3 + pip
############################################

install_if_missing python3 "sudo apt install -y python3"
install_if_missing pip3 "sudo apt install -y python3-pip python3-venv"

############################################
# UV (Python fast package manager)
############################################

if ! command_exists uv; then
  echo "⚡ Installing uv..."
  curl -Ls https://astral.sh/uv/install.sh | sh
  export PATH="$HOME/.cargo/bin:$PATH"
fi

############################################
# Docker
############################################

if ! command_exists docker; then
  echo "🐳 Installing Docker..."

  sudo install -m 0755 -d /etc/apt/keyrings
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  sudo apt update

  sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

  sudo usermod -aG docker "$USER"
fi

############################################
# Gemini CLI
############################################

if ! command_exists gemini; then
  echo "🤖 Installing Gemini CLI..."
  npm install -g @google/gemini-cli
fi

############################################
# Final message
############################################

echo ""
echo "✅ Setup Completed!"
echo "⚠️ Please logout/login or run: newgrp docker"
echo ""
