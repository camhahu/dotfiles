# Things I've installed that I use/reference here
# homebrew
# sublime text
# bat - a cat(1) clone
# zsh
# oh-my-zsh
# git
# node-version-manager nvm

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Use ~/.config for apps that respect XDG (like lazygit on macOS)
export XDG_CONFIG_HOME="$HOME/.config"

# Add homebrew to PATH, necessary for M1/M2 Macs
export PATH=$PATH:/opt/homebrew/bin

# Make Sublime text my default text editor
export EDITOR=nvim

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


alias cr="$HOME/github-like-amazon.sh"


plugins=(git)

source $ZSH/oh-my-zsh.sh


# Dotfiles location
export DOTFILES="$HOME/Documents/Projects/_dotfiles"

alias sauce="source ~/.zshrc"
alias zshrc="$EDITOR $DOTFILES/zsh/.zshrc"
alias wp="cd ~/Documents/Projects"
alias terminal-config="$EDITOR $DOTFILES/ghostty/.config/ghostty/config"
alias termconf="terminal-config"
alias tmuxconf="$EDITOR $DOTFILES/tmux/.tmux.conf"

# tmux
# tmux aliases
alias tls='tmux ls'
alias tns='tmux new -s'
alias tas='tmux attach -t'
alias tks='tmux kill-session -t'

alias wpfh="$HOME/Documents/Projects/fluent-how"
alias elag="$HOME/Documents/Projects/agent-repos/enhance-labs"
# Bat is better than Cat for viewing files

alias rungs="$HOME/Documents/Projects/rungs/bin/rungs"
alias gurl="$HOME/Documents/Projects/gurl/bin/gurl"




# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Gemini CLI
export GOOGLE_CLOUD_PROJECT="vertical-web-464104-t5"

# Mise (Version Management)
eval "$(~/.local/bin/mise activate zsh)"

alias nvimrc="nvim $DOTFILES/nvim/.config/nvim/"
alias n="nvim ."

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


alias occ="nvim $DOTFILES/opencode/.config/opencode/command"
alias lg=lazygit
alias oc=opencode
alias dotfiles="cd $DOTFILES && opencode"
alias please='sudo $(fc -ln -1)'

# Port utilities
port() { lsof -i :$1 }
killport() { lsof -ti :$1 | xargs kill -9 }

# Auto suggestions
# Installed from here: https://github.com/zsh-users/zsh-autosuggestions/blob/master/INSTALL.md
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Terminal command syntax highlighting
# Must be at the end of zshrc
# Installed from here: https://github.com/zsh-users/zsh-syntax-highlighting/blob/master/INSTALL.md
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/camhahu/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/camhahu/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/camhahu/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/camhahu/google-cloud-sdk/completion.zsh.inc'; fi
