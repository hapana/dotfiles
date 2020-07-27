FROM docker:19.03.12-git

ARG USERNAME
ARG USERID

ENV SHELL zsh

RUN addgroup -g ${USERID} ${USERNAME}
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/home/$USERNAME" \
    --ingroup "$USERNAME" \
    --uid "$USERID" \
    "$USERNAME"

WORKDIR /home/$USERNAME

RUN apk --update add curl gcc bash ruby tmux neovim go su-exec

RUN apk --update add figlet task fzf jq fd the_silver_searcher shellcheck \
  tree htop nmap iftop sl zsh python3 nodejs npm

RUN ln -s /usr/bin/python3 /usr/bin/python

# https://www.unixmen.com/tldr-pages-simplified-alternative-unixlinux-man-pages/
RUN npm install -g tldr && \
  tldr --update

USER $USERID:$USERID

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# https://github.com/zdharma/zinit
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

RUN git clone git://github.com/wting/autojump.git && \
  cd autojump && zsh -c "SHELL=zsh python3 ./install.py"

