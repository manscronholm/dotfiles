# dotfiles

Configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick Start

Clone the repo and run the install script for your platform. It installs all dependencies, sets up Oh My Zsh, and stows the configs automatically.

```bash
git clone https://github.com/manscronholm/dotfiles.git ~/git/dotfiles
cd ~/git/dotfiles
```

**macOS:**

```bash
./install-mac.sh
```

**Arch Linux:**

```bash
./install-linux.sh
```

The scripts are idempotent — safe to run multiple times. Existing config files are backed up to `~/.dotfiles-backup/` before stowing.

### What gets installed

| Category | Packages |
|---|---|
| Core | `stow`, `git`, `zsh` |
| Terminal | `alacritty`, `tmux`, `starship` |
| Editor | `neovim` |
| CLI tools | `fzf`, `fd`, `ripgrep`, `zoxide`, `lazygit` |
| Font | JetBrainsMono Nerd Font |
| Shell | Oh My Zsh, zsh-syntax-highlighting plugin |
| Tmux | TPM (Tmux Plugin Manager) |

## Manual Usage

If you prefer to install packages yourself and only use stow:

```bash
cd ~/git/dotfiles
```

**macOS:**

```bash
stow tmux zsh nvim starship lazygit alacritty-mac
```

**Linux:**

```bash
stow tmux zsh nvim starship lazygit alacritty-linux hyprland waybar
```

Use `stow -n -v <package>` for a dry-run to see what symlinks would be created without making changes.

To remove a package's symlinks:

```bash
stow -D <package>
```

## Packages

| Package | Target | Platform |
|---|---|---|
| `tmux` | `~/.tmux.conf` | Shared |
| `zsh` | `~/.zshrc` | Shared |
| `nvim` | `~/.config/nvim/` | Shared (OS detection for theme) |
| `starship` | `~/.config/starship/` | Shared |
| `lazygit` | `~/.config/lazygit/` | Shared |
| `alacritty-mac` | `~/.config/alacritty/` | macOS |
| `alacritty-linux` | `~/.config/alacritty/` | Linux |
| `hyprland` | `~/.config/hypr/` | Linux |
| `waybar` | `~/.config/waybar/` | Linux |
| `powershell` | Manual deploy | Windows |

## Notes

- The `nvim` config uses platform detection in `init.lua` to load Omarchy theme integration on Linux and standalone Catppuccin on macOS.
- `pre-omarchy/` is an archive of previous configs and is not a stow package.
