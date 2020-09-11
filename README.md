# My Dotfiles

This is based on [Chez
Moi](https://github.com/twpayne/chezmoi/blob/master/docs/QUICKSTART.md) due to
its feature richness and the fact that it runs from a binary and is hosted on
brew.

What I need to get this going:

1. Download this repo: `wget -o /tmp/dotfiles.zip
   https://github.com/hapana/dotfiles/archive/master.zip && unzip -d
   ~/.local/share/chezmoi /tmp/dotfiles.zip`
1. Install brew /usr/bin/ruby -e "$(curl -fsSL
   https://raw.githubusercontent.com/Homebrew/install/master/install)"
1. `brew bundle`
1. Run `chezmoi apply` to apply it all
