function thelp
echo '
  [cmd] c                      - new window
  [cmd] [num]                  - move windows
  [cmd] [arrow-key]            - move panes
  [cmd] %                      - Split vertically
  [cmd] "                      - Split horizontally
  [cmd] [                      - Copy mode (switch to vim)
    shift v                      - select lines
    y                          - copy lines
    o                          - open in browser
  [cmd] ]                      - Paste
  [cmd] :rename-window <name>  - Rename window
  [cmd] <space>                - Change layout
'
end


function reload_tmux
  tmux source ~/.tmux.conf
end

if test "$TMUX" = ""
  exec tmux
end
