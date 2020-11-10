init:
	chezmoi init git@github.com:hapana/dotfiles.git
	chezmoi execute-template --init < ~/.local/share/chezmoi/.chezmoi.toml.tmpl

add_zsh_scripts:
	chezmoi add ~/.oh-my-zsh/custom --recursive

apply_zsh_scripts:
	chezmoi apply ~/.oh-my-zsh/custom

apply_dot_config:
	chezmoi apply ~/.config/

apply_tmux:
	chezmoi apply ~/.tmux.conf
	chezmoi apply ~/.tmux/

apply_task:
	chezmoi apply ~/.taskrc

apply_all:
	chezmoi apply

install_lsp:
	# Node
	npm install -g dockerfile-language-server-nodejs
	# Bash
	npm i -g bash-language-server
	# Go
	curl -o /tmp/tf-lsp.tar.gz -L https://github.com/juliosueiras/terraform-lsp/releases/download/v0.0.10/terraform-lsp_0.0.10_darwin_amd64.tar.gz
	sudo tar -C /usr/local/bin/ -xzf /tmp/tf-lsp.tar.gz && sudo rm /usr/local/bin/README.md /usr/local/bin/LICENSE /tmp/tf-lsp.tar.gz
	go get -u github.com/sourcegraph/go-langserver
	# Python
	curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py
	python /tmp/get-pip.py
	pip install python-language-server==0.34.1
	# Not quite lsp, but needed for python3
	pip3 install neovim-remote
