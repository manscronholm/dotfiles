# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# fzf catppuccin
export FZF_DEFAULT_OPTS=" \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"

# fzf stuff
export FZF_DEFAULT_COMMAND="fd . -H $HOME" 
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND" 
export FZF_COMPLETION_TRIGGER='~~' 
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh 

# Theme
ZSH_THEME="catppuccin"
CATPPUCCIN_FLAVOR="mocha"
CATPPUCCIN_SHOW_TIME=true  

zstyle ':omz:update' mode reminder
plugins=(fzf)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

alias zshconfig="mate ~/.zshrc"
alias ohmyzsh="mate ~/.oh-my-zsh"
alias cd..="cd .."
alias syncnvim='rsync -avh --delete ~/.config/nvim/ ~/Repositories/dotfiles/nvim/'

export PATH=$PATH:/home/antabuz/.spicetify
