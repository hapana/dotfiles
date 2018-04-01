set expandtab
set tabstop=2
set shiftwidth=2

set nu
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.config/nvim/plugged')

" File explorer
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Pretty tabs
Plug 'bling/vim-airline'
let g:airline#extensions#tabline#enabled = 1

" Line stuff up
Plug 'godlygeek/tabular'

" 0o0o0ojOO linting
Plug 'w0rp/ale'
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
packloadall
let g:ale_sign_column_always = 1
let g:airline#extensions#ale#enabled = 1

call plug#end()
