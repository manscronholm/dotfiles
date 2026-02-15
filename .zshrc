
# Path to Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

plugins=(
  fzf
  zsh-syntax-highlighting
)

# Disable OMZ theme (Starship will handle prompt)
ZSH_THEME=""

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh
zstyle ':omz:update' mode reminder

# Completion options
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true

# Catppuccin fzf colors
export FZF_DEFAULT_OPTS=" \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

# fzf setup
export FZF_DEFAULT_COMMAND="fd . -H $HOME"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_COMPLETION_TRIGGER='~~'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Editor
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Aliases
alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias cd..="cd .."
alias syncnvim='rsync -avh --delete ~/.config/nvim/ ~/repositories/dotfiles/nvim/'

# Starship prompt (safe to load last)
eval "$(starship init zsh)"

