# Dotfiles

My personal configuration files for development environments.

## Overview

This repository contains my dotfiles and system configurations, allowing me to quickly set up a consistent development environment across machines.

## Components

### 🖥️ Kitty Terminal
- **Theme**: Tokyo Night Night
- Custom terminal configuration optimized for development work

### 🐚 Shell (Zsh)
- **Prompt**: Starship with custom configuration
- Custom aliases and functions
- Optimized shell environment

### ✍️ Neovim
- Complete Neovim configuration
- Plugin setup and custom key mappings

## Installation

### Prerequisites
- [Kitty Terminal](https://sw.kovidgoyal.net/kitty/)
- Zsh
- [Starship Prompt](https://starship.rs/)
- [Neovim](https://neovim.io/)

### Quick Setup
```bash
# Clone this repository
git clone https://github.com/YOUR_USERNAME/dotfiles.git ~/dotfiles

# TODO: Add installation script with symlinks
# For now, manually symlink configs:

# Kitty
ln -sf ~/dotfiles/kitty_config ~/.config/kitty

# Shell configs
ln -sf ~/dotfiles/shell/.zshrc ~/.zshrc
ln -sf ~/dotfiles/shell/.zprofile ~/.zprofile
ln -sf ~/dotfiles/shell/starship.toml ~/.config/starship.toml

# Neovim
ln -sf ~/dotfiles/nvim ~/.config/nvim


Structure
dotfiles/
├── kitty_config/          # Kitty terminal configuration
│   ├── kitty.conf        # Main Kitty config
│   └── themes/           # Theme files
├── shell/                # Zsh and prompt configs
│   ├── .zshrc           # Main zsh configuration
│   ├── .zprofile        # Zsh profile
│   └── starship.toml    # Starship prompt config
└── nvim/                 # Neovim configuration
Usage
These configurations are designed to be modular. You can:

Use individual components independently
Customize any configuration to fit your workflow
Add new tool configurations as needed

Future Additions

 Automated installation script
 Git configuration
 Additional development tools configs
 Platform-specific notes (Linux, macOS, WSL)

Notes

Requires Nerd Fonts for proper icon rendering in terminal
Configurations are updated regularly as my workflow evolves


Author: Mauricio Santamaria
License: MIT

