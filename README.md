# My Dotfiles

This is based on [Chez
Moi](https://github.com/twpayne/chezmoi/blob/master/docs/QUICKSTART.md) due to
its feature richness and the fact that it runs from a binary and is hosted on
brew.

What I need to get this going:

1. Download this repo
1. Unzip it: `mkdir -p ~/.local/share/chezmoi && unzip -d ~/.local/share/chezmoi
   ~/Downloads/dotfiles-master.zip`
1. Install `brew /usr/bin/ruby -e "$(curl -fsSL
   https://raw.githubusercontent.com/Homebrew/install/master/install)"`
1. Probably `brew install git`
1. `brew bundle`
1. Run `chezmoi apply` to apply it all
1. Update git remote: `git remote set-url origin
   git@github.com:hapana/dotfiles.git`

# Post Init Steps

1. Run `/usr/local/opt/fzf/install` for fzf
1. Run `PlugInstall` in vim
1. Coc plugins:
  - coc-go
  - coc-docker
  - coc-sh
  - coc-python
  - coc-prettier

# SSH Keygen

`ssh-keygen -t ed25519 -a 100` (since 2014 or so)
