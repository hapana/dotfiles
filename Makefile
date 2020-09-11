init:
	chezmoi init git@github.com:hapana/dotfiles.git --apply

add_scripts:
	chezmoi add ~/.oh-my-zsh/custom --recursive

apply_scripts:
	chezmoi apply ~/.oh-my-zsh/custom
