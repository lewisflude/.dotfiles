" Lewis Flude's Vim Configuration
set nocompatible

call plug#begin('~/.vim/plugged')

Plug 'tpope/vim-sensible'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()

" General Settings
set number
set visualbell
set showcmd
set showmode

" Syntax Highlighting
syntax on

" Set Leader
let mapleader=","

" Swapfiles
set noswapfile
set nobackup
set nowb

" Indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

filetype plugin on
filetype plugin indent on

" Scrolling
set scrolloff=8
set sidescrolloff=15
set sidescroll=1

" FZF
nmap <Leader>f :GFiles<CR>

" NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
