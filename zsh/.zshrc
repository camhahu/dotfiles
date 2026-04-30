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

# Local user binaries
export PATH="$HOME/.local/bin:$PATH"

# Make Sublime text my default text editor
export EDITOR=nvim

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"


alias cr="$HOME/github-like-amazon.sh"

alias cattle="/Users/camhahu/Documents/Projects/cattle.sh/packages/cli/dist/cattle"

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

# Mise (Version Management)
eval "$(~/.local/bin/mise activate zsh)"

alias nvimrc="nvim $DOTFILES/nvim/.config/nvim/"
alias n="nvim ."

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


alias occ="nvim $DOTFILES/opencode/.config/opencode/command"
opencode() {
  OPENCODE_ENABLE_EXA=1 command opencode "$@"
}

alias lg=lazygit
alias oc=opencode
alias commit="opencode run --command commit"
alias dotfiles="cd $DOTFILES && opencode"
alias please='sudo $(fc -ln -1)'
alias pls='sudo $(fc -ln -1)'
alias wtc='wt switch -c'
alias warden='/Users/camhahu/.bun/bin/warden'

feat() {
  local feature_name="$1"
  local window_id
  local left_pane
  local right_pane

  if [ -z "$TMUX" ]; then
    echo "feat: must be run inside tmux"
    return 1
  fi

  if ! command -v wt >/dev/null 2>&1; then
    echo "feat: wt command not found"
    return 1
  fi

  if [ -z "$feature_name" ]; then
    printf "Feature name: "
    read -r feature_name
  fi

  if [ -z "$feature_name" ]; then
    echo "feat: feature name is required"
    return 1
  fi

  wt switch -c "$feature_name" || return $?

  left_pane="$(tmux new-window -d -P -F '#{pane_id}' -n "$feature_name")" || return $?
  window_id="$(tmux display-message -p -t "$left_pane" '#{window_id}')" || return $?

  tmux set-option -w -t "$window_id" allow-passthrough off || return $?

  right_pane="$(tmux split-window -d -h -t "$left_pane" -P -F '#{pane_id}')" || return $?

  tmux respawn-pane -k -t "$left_pane" 'opencode' || return $?

  tmux select-window -t "$window_id" || return $?
  tmux select-pane -t "$right_pane" || return $?
}

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

eval "$(starship init zsh)"

# browser
export PATH="/Users/camhahu/.browser/bin:$PATH"

# opencode
export PATH=/Users/camhahu/.opencode/bin:$PATH

# sentry
export PATH="/Users/camhahu/.sentry/bin":$PATH

# cargo
export PATH="$HOME/.cargo/bin:$PATH"

if command -v wt >/dev/null 2>&1; then eval "$(command wt config shell init zsh)"; fi

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
