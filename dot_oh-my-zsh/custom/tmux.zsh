thelp (){
 cat << EOF
                             - command key
[cmd] c                      - new window
[cmd] [num]                  - move windows
[cmd] [arrow-key]            - move panes
[cmd] %                      - Split vertically
[cmd] "                      - Split horizontally
[cmd] [                      - Copy mode (switch to vim)
  shift v                      - select lines
  y                          - copy lines
[cmd] ]                      - Paste
[cmd] :rename-window <name>  - Rename window
[cmd] <space>                - Change layout
EOF
}

reload_tmux () {
  tmux source ~/.tmux.conf
}

if [ "$TMUX" = "" ]; then exec tmux; fi
