set nocompatible              " be iMproved, required
syntax on
filetype plugin indent on
" filetype off                  " required

" --------------- Plugins installed -------------------------------------------

" Get plugging!
call plug#begin('~/.vim/plugged')

" Syntax plugins
Plug 'ap/vim-css-color'
Plug 'chase/vim-ansible-yaml'
Plug 'digitaltoad/vim-jade'
Plug 'ekalinin/Dockerfile.vim'
Plug 'rosenfeld/conque-term'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'w0rp/ale'
Plug 'itspriddle/vim-shellcheck'
Plug 'moll/vim-node'
Plug 'hashivim/vim-terraform'
Plug 'towolf/vim-helm'
Plug 'google/vim-jsonnet'
Plug 'deoplete-plugins/deoplete-go', { 'do': 'make'}
Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.vim/plugged/gocode/vim/symlink.sh' }
Plug 'ervandew/supertab'

" Utility plugins
Plug 'AndrewRadev/sideways.vim'
Plug 'bling/vim-airline'
Plug 'danro/rename.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rking/ag.vim'
Plug 'ruanyl/vim-gh-line'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'dhruvasagar/vim-table-mode'
Plug 'neomake/neomake'

" For navigating with vim and tmux
Plug 'christoomey/vim-tmux-navigator'

" Requires external fzf binary
set rtp+=/usr/local/opt/fzf
Plug 'junegunn/fzf.vim'

"Split join go structs
Plug 'AndrewRadev/splitjoin.vim'
call plug#end()

syntax on                     " Turn syntax on
filetype plugin indent on     " Set to detect filetype
set re=1                      " Enable newer regexs

let g:tagbar_left=1           " Vim tagbar shortcut

" --------------- Color and Scheme Preferences --------------------------------

" colorscheme base16-default

set t_ut=             " Disable deleted coloring
set t_Co=256          " Force 256 colors
syn sync fromstart    " Calculate syntax colors from start of file

" Turn off visual/audible bell
set visualbell
set t_vb=

" Forces a syntax hl refresh
nnoremap <leader>S :syn sync fromstart<CR>

" Remap no highlight to return
nnoremap <CR> :noh<CR>

" airline config
let g:airline_theme='dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#branch#enabled = 0  " turn off git branch
highlight clear LineNr

" --------------- Indentation and Formatting ----------------------------------

set autoindent      " Copy indent from current line when starting a new one
set smarttab        " <Tab> depends on the value of 'shiftwidth'
set expandtab       " Use appropriate numebr of spaces rather than tab
set shiftround      " Round indent to multiple of shiftwidth
set nowrap          " Don't wrap lines longer than width of the window
set scrolloff=5     " minimal number of lines above/below cursor on scrolling
set tabstop=2       " number of spaces that a <Tab> counts for normally
set softtabstop=2   " number of spaces that a <Tab> counts for while editing
set shiftwidth=2    " Values used by smarttab setting

" --------------- General Settings --------------------------------------------

set nu                            " Turn on numbers
set ruler                         " Show line and col
"set mouse=a                       " Enable mouse scrolling, pane selection
set nobackup                      " Prevents potential slow write
set statusline+=%F                " Put filepath in status
set laststatus=2                  " Set status to visible
set fdm=marker                    " Set default fold method to marker
set backspace=indent,eol,start    " Allow backspace over everything in insert mode
" set textwidth=80                  " Default line length in chars

" For non-neovim editors
if !has('nvim')
  set ttymouse=xterm2             " Support tmux 2.2 mouse escape sequences
endif

" HARDMODE
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Call out to fzf
nnoremap <leader>t :call fzf#vim#gitfiles('.')<cr>
autocmd BufRead * set tags=./tags,tags;$HOME        " Look for tags

" Linewise completion
imap <C-@> <C-Space>
inoremap <C-Space> <C-x><C-l>

" --------------- ColorColumn Toggling ----------------------------------------

" Alternately toggles a color column on or off. Mapped to leader key c.
function! g:ToggleColorColumn()
  if &colorcolumn != ''
    setlocal colorcolumn&
  else
    " Column is positioned 1 col past textwidth
    setlocal colorcolumn=+1
  endif
endfunction

nnoremap <leader>C :call g:ToggleColorColumn()<CR>

" --------------- Searching Settings ------------------------------------------

set hlsearch        " highlight all matches of a search pattern
set incsearch       " Show where the pattern, while typying a search command
set smartcase       " Override 'ignorecase' for upper case search patterns
set ignorecase      " Ignore case of normal letters

" --------------- Filetype Preferences ----------------------------------------

au FileType python setlocal formatprg=autopep8\ -             " Use autopep8 for python gq
au FileType make,go set noexpandtab                           " Force tabs in makefiles
au BufRead,BufNewFile Make.*,Makefile,makefile set ft=make    " Set filetype
au BufRead,BufNewFile package.json set ft=javascript          " Force JSON hl
au BufReadPost *.pegjs set syntax=javascript                  " Force JS hl
au BufRead,BufNewFile *.pro set syntax=prolog                 " Detect prolog
au BufRead,BufNewFile Gemfile set ft=ruby                     " Set ruby syntax for Gemfiles
au BufRead,BufNewFile *.md set ft=markdown                    " Set markdown ft
au BufRead,BufNewFile *.tex set ft=tex                        " Set latex filetype

" --------------- General Shortcuts -------------------------------------------

" Delete the current file and buffer
nnoremap <Leader>d :call delete(expand('%')) <bar> bdelete!

" Paste from system clipboard
nmap <leader>P :read !pbpaste <CR>

" Enable cut/copy into system clipboard
" Standard Ctrl-C/X shortcuts
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>

" Shortcut to destroy trailing whitespace
nmap <leader>s :%s/\v\s+$//<CR>

" Search using silversurfer (ag) for word under cursor
nnoremap <Leader>a :Ag <C-r><C-w><CR>

" Make current file executable
nnoremap <Leader>x :w <bar> !chmod a+x % <CR><CR>

" Shortcut shifting parameters sideways
nmap ,h :SidewaysLeft <CR>
nmap ,l :SidewaysRight <CR>

" --------------- Folding! ----------------------------------------------------

" Map space to toggle current fold
noremap <Space> za

" Set foldmethod to indent by default
set foldmethod=indent
set foldlevel=99

" Turn foldcolumn viewing on for a fold visualization
nnoremap <leader>f :call FoldColumnToggle()<cr>
function! FoldColumnToggle()
  if &foldcolumn
    setlocal foldcolumn=0
  else
    setlocal foldcolumn=4
  endif
endfunction

" Configure fold status text
if has("folding")

  function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
  endfunction
  set foldtext=NeatFoldText()

endif

" --------------- TinyOS Preferences ------------------------------------------

" Alias the NesC filetype to C
autocmd BufRead,BufNewFile *.nc set ft=c

" --------------- My Customs ------------------------------------------

" Shortcut to set up new command aliases
fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

" Copy to clipboard when yanking
"set clipboard=unnamed

" --------------- NerdTree ------------------------------------------
" Nerd tree toggle
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFocus<CR>

let NERDTreeShowHidden=1

" Enable deoplete: https://github.com/Shougo/deoplete.nvim
let g:deoplete#enable_at_startup = 1

" ALE
let g:ale_sign_column_always = 1
let g:ale_completion_enabled = 1

" --------------- Go ------------------------------------------
" Go Aliases
call SetupCommandAlias("gt","GoTest")
call SetupCommandAlias("gi","GoImports")
call SetupCommandAlias("gc","GoCoverage")
call SetupCommandAlias("gr","!go run main.go")

" Run go imports on save
let g:go_fmt_command = "goimports"

set completeopt+=noselect

let g:python_host_prog = '/usr/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python3_host_skip_check = 1

let g:deoplete#sources#go#gocode_binary = $GOPATH.'/bin/gocode'
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']
let g:deoplete#sources#go#fallback_to_source = 0
let g:deoplete#sources#go#use_cache = 0

let g:go_code_completion_enabled = 1
let g:go_gocode_unimported_packages = 0
let g:go_gocode_propose_source = 1

" Not supported by different gocode
let g:deoplete#sources#go#source_importer = 0
let g:deoplete#sources#go#builtin_objects = 0
let g:deoplete#sources#go#unimported_packages = 0

" Using a backup messes up fsnotify
set nowritebackup

" --------------- Neomake ------------------------------------------
"  This runs programs asynchronously

function! MyOnBattery()
  if has('macunix')
    return match(system('pmset -g batt'), "Now drawing from 'Battery Power'") != -1
  elsif has('unix')
    return readfile('/sys/class/power_supply/AC/online') == ['0']
  endif
  return 0
endfunction

if MyOnBattery()
  call neomake#configure#automake('w')
else
  call neomake#configure#automake('nw', 1000)
endif

" Other

" Turn off swap files
set noswapfile

call SetupCommandAlias("spell","set spell spelllang=en_us")
call SetupCommandAlias("copy","!pbcopy && pbpaste")
call SetupCommandAlias("readme","set textwidth=80")
