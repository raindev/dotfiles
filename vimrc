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
" Extend % matching to tags and keywords
packadd! matchit
