# Dotfiles

Always use `--no-folding` with stow since `~/.config` is a real directory, not a symlink.

New computer setup:

```sh
open https://brew.sh
```

```sh
xcode-select --install
```

```sh
brew install git stow neovim tmux starship lazygit git-delta ripgrep fd mise zsh-autosuggestions zsh-syntax-highlighting
```

```sh
brew install --cask ghostty zed sublime-text font-hack-nerd-font
```

```sh
open https://ohmyz.sh
```

```sh
mkdir -p ~/Documents/Projects
```

```sh
git clone <repo-url> ~/Documents/Projects/_dotfiles
```

```sh
cd ~/Documents/Projects/_dotfiles
```

```sh
stow -v -t ~ --no-folding --ignore='\.DS_Store' zsh git nvim tmux starship lazygit ghostty zed opencode
```

```sh
source ~/.zshrc
```

```sh
ghostty +show-config
```

Adding new dotfiles:

1. Create a directory, e.g. `ghostty`
2. Within `ghostty`, create a directory structure that matches where the dotfile is. ghostty is at `/.config/ghostty/config` so we create `ghostty/.config/ghostty/config` in this repo.
3. `stow --adopt -v -t ~ --no-folding ghostty` to adopt the new dotfile - this command is dangerous, always get a human to do it

Adding new files within a specific directory:

1. Make your new file, e.g. `opencode/.config/opencode/command`
2. Run `stow -v -t ~ --no-folding opencode` to restow the directory (idempotent)
