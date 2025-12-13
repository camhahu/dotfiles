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

# Add homebrew to PATH, necessary for M1/M2 Macs
export PATH=$PATH:/opt/homebrew/bin

# Make Sublime text my default text editor
export EDITOR=nvim

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


alias cr='/Users/camhahu/github-like-amazon.sh'


plugins=(git)

source $ZSH/oh-my-zsh.sh


alias sauce="source ~/.zshrc"
alias zshrc="$EDITOR ~/.zshrc"
alias wp="cd ~/Documents/Projects"
alias terminal-config="$EDITOR /Users/camhahu/.config/ghostty/config"
alias termconf="terminal-config"
alias tmuxconf="$EDITOR ~/.tmux.conf"

# tmux
# tmux aliases
alias tls='tmux ls'
alias tns='tmux new -s'
alias tas='tmux attach -t'
alias tks='tmux kill-session -t'

alias wpfh='/Users/camhahu/Documents/Projects/fluent-how'
alias elag='/Users/camhahu/Documents/Projects/agent-repos/enhance-labs'
# Bat is better than Cat for viewing files

alias rungs="/Users/camhahu/Documents/Projects/rungs/bin/rungs"
alias gurl="/Users/camhahu/Documents/Projects/gurl/bin/gurl"




# pnpm
export PNPM_HOME="/Users/camhahu/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Gemini CLI
export GOOGLE_CLOUD_PROJECT="vertical-web-464104-t5"

# Mise (Version Management)
eval "$(~/.local/bin/mise activate zsh)"

alias nvimrc="nvim ~/.config/nvim/"

# opencode
export PATH=/Users/camhahu/.opencode/bin:$PATH

# bun completions
[ -s "/Users/camhahu/.bun/_bun" ] && source "/Users/camhahu/.bun/_bun"


alias occ="nvim /Users/camhahu/.config/opencode/command"
alias lg=lazygit
alias oc=opencode
