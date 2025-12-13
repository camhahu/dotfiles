# Dotfiles

Adding new dotfiles:

1. Create a directory, e.g. `ghostty`
2. Within `ghostty`, create a directory structure that matches where the dotfile is. ghostty is at `/.config/ghostty/config` so we create `ghostty/.config/ghostty/config` in this repo.
3. `stow --adopt -v -t ~ ghostty` to adopt the new dotfile - this command is dangerous, always get a human to do it

Adding new files within a specific directory:

1. Make your new file, e.g. `opencode/.config/opencode/command`
2. Run `stow -v -t ~ --no-folding opencode` to restow the directory (idempotent)
