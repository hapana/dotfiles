#! /bin/bash
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
ln -s ~/dotfiles/.config/zsh-scripts/git.zsh ~/.oh-my-zsh/custom/
ln -s ~/dotfiles/.config/zsh-scripts/zsh.zsh ~/.oh-my-zsh/custom/
ln -s ~/dotfiles/.config/zsh-scripts/aliases.zsh ~/.oh-my-zsh/custom/
