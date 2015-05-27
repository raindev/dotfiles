"----------Plugins----------

source $HOME/.vundle.vim

"----------Options----------

" Backup files before overwriting
set backup
" Store all backups in a single directory
set backupdir=~/.vim/backup/
" Hide abandoned buffers not unload
set hidden
" Increase number of search patterns and command-line commands to remember
set history=200
" Show cursor and displayed text position
set ruler
" Disable cursor blinking for normal, visual and command-line modes
set guicursor=n-v-c:blinkon0
" Hide right and left scrollbars
set guioptions-=rL
" Display partial commands and visual mode selection size
set showcmd
" Perform incremental search
set incsearch
" Highlight search results
set hlsearch
" Continue line indentation
set autoindent
" Load vimrc configuration from current folder on startup
set exrc
" Replace tabs with spaces
set expandtab
" Set tab width
set tabstop=2
" Indentation width
set shiftwidth=2
" Make tilda (~) behave as operator
set tildeop
" Line numbering, hybrid mode
set relativenumber	" show relative line numbers
set number	" set absolute line number (for current line)

"----------Mappings----------

" Set leader as easily accessible for both hands
let mapleader=' '

" Suspend current search results highlighting
map <silent> <leader>h :nohlsearch<CR>

" Allow saving of files as sudo when I forgot to start Vim using sudo.
cmap w!! w !sudo tee > /dev/null %<CR>

" Absolute/hybrid line numbering toggle
nmap <silent> <C-n> :set invrelativenumber<cr>

" Distraction-free writing
map <F12> :Goyo<CR>

" Highlight current file in NERDTree
map <F2> :NERDTreeFind<CR>

"--------Autocommands--------

" Enable file type detection, plugin and indentation files loading
filetype plugin indent on
syntax enable

augroup vimrc
  autocmd!

  " Keep line width for text files sane
  autocmd FileType text setlocal textwidth=78
  autocmd FileType java setlocal tabstop=4 shiftwidth=4

  autocmd BufNewFile,BufReadPost *.gradle  set filetype=groovy

  " Launch both distraction-free and hyperfocus writing plugins simultaneously
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!

augroup END

"-------Plugin configs-------

" Use only Git-tracked files for CtrlP search
let g:ctrlp_user_command = ['.git/',
      \ 'git --git-dir=%s/.git ls-files --cached --others --exclude-standard']
