init:
	chezmoi init git@github.com:hapana/dotfiles.git --apply

add_zsh_scripts:
	chezmoi add ~/.oh-my-zsh/custom --recursive

apply_zsh_scripts:
	chezmoi apply ~/.oh-my-zsh/custom

apply_dot_config:
	chezmoi apply ~/.config/

apply_tmux:
	chezmoi apply ~/.tmux.conf
	chezmoi apply ~/.tmux/

apply_all: apply_zsh_scripts apply_dot_config apply_tmux
