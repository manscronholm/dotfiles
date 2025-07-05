#/bin/bash

# Define source paths
ZSHRC="$HOME/.zshrc"
NVIM_CONFIG="$HOME/.config/nvim"
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
LAZYGIT_CONFIG="$HOME/.config/lazygit/config.yml"
WAYBAR_CONFIG="$HOME/.config/waybar"
HYPRLAND_CONFIG="$HOME/.config/hypr/hyprland.conf"
HYPRPAPER_CONFIG="$HOME/.config/hypr/hyprpaper.conf"
WOFI_CONFIG="$HOME/.config/wofi"
SWAYNC_CONFIG="$HOME/.config/swaync"

WALLPAPER="$HOME/.config/hypr/wallpaper/wallpaper.jpg"


# Define backup directory
BACKUP_DIR="/home/antabuz/Repositories/dotfiles"

# Ensure base backup directory exists
mkdir -p "$BACKUP_DIR"

# Copy .zshrc
if [ -f "$ZSHRC" ]; then
    mkdir -p "$BACKUP_DIR/zsh"
    cp "$ZSHRC" "$BACKUP_DIR/zsh"
    echo "Copied .zshrc to $BACKUP_DIR/zsh"
else
    echo "Warning: $ZSHRC not found"
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

# Copy kitty.conf
if [ -f "$KITTY_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/kitty"
    cp "$KITTY_CONFIG" "$BACKUP_DIR/kitty"
    echo "Copied kitty.conf to $BACKUP_DIR/kitty"
else
    echo "Warning: $KITTY_CONFIG not found"
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

# Copy hyprland config
if [ -f "$HYPRLAND_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/hyprland"
    cp "$HYPRLAND_CONFIG" "$BACKUP_DIR/hyprland"
    echo "Copied hyprland config to $BACKUP_DIR/hyprland"
else
    echo "Warning: $HYPRLAND_CONFIG not found"
fi

# Copy hyprpaper config
if [ -f "$HYPRPAPER_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/hyprpaper"
    cp "$HYPRPAPER_CONFIG" "$BACKUP_DIR/hyprpaper"
    echo "Copied hyprpaper config to $BACKUP_DIR/hyprpaper"
else
    echo "Warning: $HYPRPAPER_CONFIG not found"
fi

# Copy wallpaper config
if [ -f "$WALLPAPER" ]; then
    mkdir -p "$BACKUP_DIR/wallpaper"
    cp "$WALLPAPER" "$BACKUP_DIR/wallpaper"
    echo "Copied wallpaper config to $BACKUP_DIR/wallpaper"
else
    echo "Warning: $WALLPAPER not found"
fi

# Copy wofi directory
if [ -d "$WOFI_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/wofi"
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$WOFI_CONFIG/" "$BACKUP_DIR/wofi"
    echo "Copied wofi config to $BACKUP_DIR/wofi"
else
    echo "Warning: $WOFI_CONFIG not found"
fi

# Copy swaync directory
if [ -d "$SWAYNC_CONFIG" ]; then
    mkdir -p "$BACKUP_DIR/swaync"
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$SWAYNC_CONFIG/" "$BACKUP_DIR/swaync"
    echo "Copied swaync config to $BACKUP_DIR/swaync"
else
    echo "Warning: $SWAYNC_CONFIG not found"
fi


