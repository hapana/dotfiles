#! /bin/bash

# Only install oh-my-zsh if it doesn't exist
if [ ! -d ~/.oh-my-zsh/ ]; then
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
fi

# Get current dir of script and set zsh script dir
DIR="$(dirname "${BASH_SOURCE[0]}")"
ZSH_DIR=~/.oh-my-zsh/custom/
DOTFILES_DIR=~/code/dotfiles

# Get script files in current dir
scripts=($(ls $DIR/*.zsh))

for script in "${scripts[@]}"
do
  if ! [ -L $ZSH_DIR/$(basename $script) ]; then
    echo "Linking ${script}"
    ln -s $DOTFILES_DIR/$script $ZSH_DIR
  else
    echo "${script} already exists"
  fi
done
