FROM docker:19.03.12-git
#FROM docker:19.03.12-git

WORKDIR /root

RUN apk --update add curl gcc bash ruby tmux neovim go

RUN apk --update add figlet task fzf jq fd the_silver_searcher shellcheck \
  tree htop nmap iftop sl zsh python3 nodejs npm

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# https://github.com/zdharma/zinit
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"

RUN git clone git://github.com/wting/autojump.git && \
  cd autojump && zsh -c "SHELL=zsh python3 ./install.py"

# https://www.unixmen.com/tldr-pages-simplified-alternative-unixlinux-man-pages/
RUN npm install -g tldr && \
  tldr --update

ENTRYPOINT [ "zsh" ]
