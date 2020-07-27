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
  --rm \
  -it home \
  /bin/zsh
