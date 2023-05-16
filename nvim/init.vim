" enable system clipboard support
set clipboard+=unnamedplus

" force use of hjkl for movement
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" no swap file
" swap file forbids editing of a file that is already open in another buffer
set noswapfile

" save undo-tree to disk
set undofile
set undodir=$HOME/.config/nvim/undo
set undolevels=10000
set undoreload=10000

" show relative line numbers
set number
set relativenumber

" use 4 spaces for tabs by default
" copy indent from current line when starting a new line
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
