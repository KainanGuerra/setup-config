# Ubuntu Dev Setup

An automated bash script to set up a complete development environment on Ubuntu.

## Overview

This script automates the installation and configuration of essential development tools and dependencies for Ubuntu. It sets up your system with modern development tools, package managers, and containers infrastructure in one command.

## Prerequisites

- Ubuntu-based Linux distribution
- Internet connection
- `sudo` access

## What Gets Installed

### System Utilities
- **build-essential** - Compilers and build tools
- **curl** - Command-line data transfer tool
- **wget** - File download utility
- **git** - Version control system

### Shell & Terminal
- **Zsh** - Modern shell
- **Oh My Zsh** - Zsh configuration framework

### Node.js Ecosystem
- **NVM** (Node Version Manager) - Node.js version management
- **Node.js LTS** - JavaScript runtime
- **npm** - Node package manager
- **Gemini CLI** - Google Gemini command-line tool

### Python Ecosystem
- **Python 3** - Python runtime
- **pip3** - Python package manager
- **uv** - Fast Python package manager (Astral)

### Container & Infrastructure
- **Docker** - Container platform
- **Docker CLI** - Docker command-line interface
- **Docker Compose** - Multi-container orchestration
- **Buildx Plugin** - Docker image building extension

### Additional Base Packages
- ca-certificates
- software-properties-common
- apt-transport-https
- gnupg
- lsb-release

## Usage

### Run the script:

```bash
bash index.sh
```

The script will:
1. Update system packages
2. Install all base packages and utilities
3. Check for existing installations and skip already-installed tools
4. Configure Zsh as the default shell
5. Install NVM and Node.js LTS if not present
6. Set up Python and package managers
7. Install Docker with proper user permissions

## Important Notes

⚠️ **After running the script, you may need to:**
- Log out and log back in for shell changes to take effect
- Or run: `newgrp docker` to apply Docker group membership without logging out

## Features

✅ **Idempotent** - Safe to run multiple times; skips already-installed tools  
✅ **Error handling** - Exits on first error with `set -e`  
✅ **User-friendly** - Detailed progress messages with emoji indicators  
✅ **Automated** - Requires minimal user interaction  

## Customization

To modify the script:
1. Edit `index.sh` to add/remove tools
2. Comment out sections you don't need
3. Adjust version specifications as needed

## Troubleshooting

**Permission denied:**
```bash
chmod +x index.sh
```

**Script fails at a specific step:**
- Run the installation command manually to see the detailed error
- Check internet connectivity
- Ensure you have sufficient disk space

**NVM not found after script completes:**
- Open a new terminal session or run `source ~/.nvm/nvm.sh`
- Verify NVM installation: `echo $NVM_DIR`

## License

This setup script is provided as-is for development convenience.
