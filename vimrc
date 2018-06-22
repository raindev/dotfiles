" Install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl --silent --fail --location
    \ --output ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'tpope/vim-surround'
call plug#end()

" Extend % matching to tags and keywords
" (built-in package)
packadd! matchit

" Disable vi compatibility
set nocompatible
" Do not highlight search results
set nohlsearch
" Use spaces instead of tabs
set expandtab
" Show partial commands and Visual mode selection size
set showcmd
" Display line numbers
set number
" Show command-line autocompletion list as a menu
set wildmenu
" Autocomplete to the end of string
set wildmode=full
" Increase command-line history size
set history=1000
" Enable file type detection,
" filetype plugins and indent files
filetype plugin indent on
" Enable syntax highlighting without touching color scheme
syntax enable

autocmd FileType gitcommit setlocal spell
