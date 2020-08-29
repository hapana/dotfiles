PATH=$PATH:~/go/bin:/usr/local/bin

bindkey -v

PATH=$PATH:~/go/bin:/usr/local/bin
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export PATH="/usr/local/sbin:$PATH"
PS1='$(kube_ps1)'$PS1$'\n''> '
export FZF_BASE=/usr/bin/fzf
ZSH_TMUX_AUTOSTART=true
