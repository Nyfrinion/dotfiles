#!/bin/bash

# List of programs to install
programs=(
    "ranger"         # Terminal file manager
    "mc"             # Midnight Commander
    "fzf"            # Fuzzy finder
    "stow"           # Manage dotfiles
    "kitty"          # Terminal emulator
    "fish"           # Fish shell
    "zsh"            # Zsh shell + plugins
    "zsh-syntax-highlighting"
    "zsh-autosuggestions"
    "tmux"           # Terminal multiplexer
    "git"            # Version control system
    "neovim"         # Text editor
    "htop"           # System monitor
    "curl"           # Command-line tool for data transfer
    "vim"            # Just cuz
    "firefox"        # Internet browser
    "thunar"         # File manager
    "blender"        # 3d modeler
    "godot"          # Game engine
    "emacs"          # Text editor + OS
    "i3blocks"       # i3 status bar+
    "acpi"           # Battery status
    "pactl"     # Volume manager
    "brightnessctl"  # Brightness manager
)

# Function to check if a package is installed
is_installed() {
    pacman -Q $1 &>/dev/null
}

# Install each program if not already installed
for program in "${programs[@]}"; do
    if ! is_installed "$program"; then
        echo "Installing $program..."
        sudo pacman -S --noconfirm $program
    else
        echo "$program is already installed."
    fi
done

# Fish specific setup (optional)
if is_installed "fish"; then
    echo "Setting Fish as default shell..."
    chsh -s /usr/bin/fish
fi

# Ranger preview support (optional)
if is_installed "ranger"; then
    echo "Setting up ranger preview support..."
    # Install catimg for image previews (example setup)
    sudo pacman -S --noconfirm catimg
    # Modify ranger's configuration for previewing
    echo "Preview setup completed. You can edit ranger's config for further customizations."
fi

echo "All programs installed successfully. Setup Complete."
