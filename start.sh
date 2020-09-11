#! /bin/bash

set -euo pipefail

USERNAME=$USER
CURRENT_USER=$(id -u ${USER})

docker build \
  --build-arg USERNAME=$USER \
  --build-arg USERID=$CURRENT_USER \
  -t home .

docker run \
  -u $CURRENT_USER:$CURRENT_USER \
  -v $(pwd)/config/zsh-scripts:/home/$USERNAME/.oh-my-zsh/custom \
  -v $(pwd)/config/task/taskrc:/home/$USERNAME/.taskrc \
  -v $(pwd)/config/fzf/fzf.zsh:/home/$USERNAME/.fzf.zsh \
  -v $(pwd)/config/zsh/zsh_history:/home/$USERNAME/.zsh_history \
  -v $(pwd)/config/zsh/zshrc:/home/$USERNAME/.zshrc \
  -v $(pwd)/config/tmux/tmux.conf:/home/$USERNAME/.tmux.conf \
  --rm \
  -it home \
  tmux
