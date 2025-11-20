#/bin/bash

# Define source paths
STARSHIP_CONFIG="$HOME/.config/starship.toml"
NVIM_CONFIG="$HOME/.config/nvim"
ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"
LAZYGIT_CONFIG="$HOME/.config/lazygit/config.yml"
WAYBAR_CONFIG="$HOME/.config/waybar"
HYPR_CONFIG="$HOME/.config/hypr"

# Define backup directory
BACKUP_DIR="/home/antabuz/repositories/dotfiles"

# Ensure base backup directory exists
mkdir -p "$BACKUP_DIR"
# Copy starship.toml
if [ -f "$STARSHIP_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/starship"
    cp "$STARSHIP_CONFIG" "$BACKUP_DIR/starship"
    echo "Copied starship.toml to $BACKUP_DIR/starship"
else
    echo "Warning: $STARSHIP_CONFIG not found"
fi

# Copy nvim directory
if [ -d "$NVIM_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/nvim"
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$NVIM_CONFIG/" "$BACKUP_DIR/nvim"
    echo "Copied nvim config to $BACKUP_DIR/nvim"
else
    echo "Warning: $NVIM_CONFIG not found"
fi

# Copy alacritty.toml
if [ -f "$ALACRITTY_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/alacritty"
    cp "$ALACRITTY_CONFIG" "$BACKUP_DIR/alacritty"
    echo "Copied alacritty.toml to $BACKUP_DIR/alacritty"
else
    echo "Warning: $ALACRITTY_CONFIG not found"
fi

# Copy lazygit config
if [ -f "$LAZYGIT_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/lazygit"
    cp "$LAZYGIT_CONFIG" "$BACKUP_DIR/lazygit"
    echo "Copied lazygit config to $BACKUP_DIR/lazygit"
else
    echo "Warning: $LAZYGIT_CONFIG not found"
fi

# Copy waybar directory
if [ -d "$WAYBAR_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/waybar"
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$WAYBAR_CONFIG/" "$BACKUP_DIR/waybar"
    echo "Copied waybar config to $BACKUP_DIR/waybar"
else
    echo "Warning: $WAYBAR_CONFIG not found"
fi

# Copy hypr config
if [ -f "$HYPR_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/hypr"
    cp "$HYPR_CONFIG" "$BACKUP_DIR/hypr"
    echo "Copied hyprland config to $BACKUP_DIR/hypr"
else
    echo "Warning: $HYPR_CONFIG not found"
fi
