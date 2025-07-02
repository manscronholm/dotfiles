#/bin/bash

# Define source paths
ZSHRC="$HOME/.zshrc"
NVIM_CONFIG="$HOME/.config/nvim"
KITTY_CONFIG="$HOME/.config/kitty/kitty.conf"
LAZYGIT_CONFIG="$HOME/.config/lazygit/config.yml"
WAYBAR_CONFIG="$HOME/.config/waybar"


# Define backup directory
BACKUP_DIR="/home/antabuz/Repositories/dotfiles"

# Copy .zshrc
if [ -f "$ZSHRC" ]; then
    cp "$ZSHRC" "$BACKUP_DIR/"
    echo "Copied .zshrc to $BACKUP_DIR"
else
    echo "Warning: $ZSHRC not found"
fi

# Copy nvim directory
if [ -d "$NVIM_CONFIG" ]; then
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$NVIM_CONFIG" "$BACKUP_DIR/"
    echo "Copied nvim config to $BACKUP_DIR"
else
    echo "Warning: $NVIM_CONFIG not found"
fi

# Copy kitty.conf
if [ -f "$KITTY_CONFIG" ]; then
    cp "$KITTY_CONFIG" "$BACKUP_DIR/"
    echo "Copied kitty.conf to $BACKUP_DIR"
else
    echo "Warning: $KITTY_CONFIG not found"
fi

# Copy lazygit config
if [ -f "$LAZYGIT_CONFIG" ]; then
    cp "$LAZYGIT_CONFIG" "$BACKUP_DIR/"
    echo "Copied kitty.conf to $BACKUP_DIR"
else
    echo "Warning: $LAZYGIT_CONFIG not found"
fi

# Copy waybar directory
if [ -d "$WAYBAR_CONFIG" ]; then
    rsync -av --delete \
        --exclude='.git' \
        --exclude='.github' \
        --exclude='.gitignore' \
        "$WAYBAR_CONFIG" "$BACKUP_DIR/"
    echo "Copied nvim config to $BACKUP_DIR"
else
    echo "Warning: $WAYBAR_CONFIG not found"
fi
