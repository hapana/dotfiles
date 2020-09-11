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
  -v $(pwd)/config/task/task_data:/home/$USERNAME/.task \
  -v $(pwd)/config/task/taskrc:/home/$USERNAME/.taskrc \
  --rm \
  -it home \
  /bin/zsh
