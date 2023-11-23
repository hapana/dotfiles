#alias vim=/usr/local/bin/nvim
# for sops

function vhelp
 '
 # Switch between buffers
 :b<buffer number>
 :bd delete current tab

 # Table mode
 \tm
 Enter | or || to format automatically

 # Float term
 \f

 # Markdown preview
 ctrl + p

 # Pretter
 \p
 :noa w # to write without formatting

 # Ansi
 :AnsiEsc

 # Ag
 \a search for the word you're on
 :ag <term> search the dir

 # In window
 e    to open file and close the quickfix window
 o    to open (same as enter)
 go   to preview file (open but maintain focus on ag.vim results)
 t    to open in new tab
 T    to open in new tab silently
 h    to open in horizontal split
 H    to open in horizontal split silently
 v    to open in vertical split
 gv   to open in vertical split silently
 q    to close the quickfix window

 # Marks
 ma  Set mark at a
 'a  Go to mark a
 \`a  Go to line and column for a

 # Macros
 qa    to start recording at mark a
 q     to stop recording
 @a    to run macro at mark a
 200@a to run the macro at mark a 200 times
 '
end

alias vim nvim
export EDITOR nvim
