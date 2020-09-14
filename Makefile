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
