"----------Plugins----------

call plug#begin()

" Fuzzy search
Plug 'ctrlpvim/ctrlp.vim'
" File browser

" Distraction-free writing
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

" Code formatting
Plug 'Chiel92/vim-autoformat'

" Insert matching braces, quotes, etc.
Plug 'jiangmiao/auto-pairs'

" Languages support
Plug 'rust-lang/rust.vim'
Plug 'cespare/vim-toml'

" REST client
Plug 'diepm/vim-rest-console'

call plug#end()

"----------Options----------

" Backup files before overwriting
set backup
" Store all backups in a single directory
set backupdir=~/.vim/backup/
" Hide abandoned buffers not unload
set hidden
" Increase number of search patterns and command-line commands to remember
set history=1000
" Show cursor and displayed text position
set ruler
set fillchars=vert:\    " Do not use vertical split characters
" Display partial commands and visual mode selection size
set showcmd
" Perform incremental search
set incsearch
" Highlight search results
set hlsearch
" Continue line indentation
set autoindent
" Round indentation to multiple of
set shiftround
" Wrap lines by words
set linebreak
" Keep indentation when wrapping lines…
set breakindent
" …only shift them a little bit more
set breakindentopt=shift:2
" Jump to the matching bracket when typed a one
set showmatch
" Replace tabs with spaces
set expandtab
" Set tab width
set tabstop=4
" Indentation width
set shiftwidth=2
" Use 'shiftwidth' when indenting start of line, 'tabstop' otherwise
set smarttab
" Make tilda (~) behave as operator
set tildeop
" Line numbering, hybrid mode
set relativenumber " show relative line numbers
set number " set absolute line number (for current line)
" No backspace madness
set backspace=
" Allow Vim to set a terminal title
set title
" Place new window below on split
set splitbelow
" Show trailing characters and tabs
set list
set listchars=tab:▸\ ,trail:·
" Enable %-matching for <>
set matchpairs+=<:>

"----------Mappings----------

" Make Y behave consistently with other capitals
map Y y$

" Set leader as easily accessible for both hands
let mapleader=' '

" Suspend current search results highlighting
map <silent> <leader>h :nohlsearch<CR>

" Toggle spell checker
map <silent> <leader>s :set invspell<CR>

map <leader>w :write<CR>
map <leader>p :CtrlP .<CR>

" Allow saving of files as sudo when I forgot to start Vim using sudo.
cmap w!! w !sudo tee > /dev/null %<CR>

" Absolute/hybrid line numbering toggle
nmap <silent> <C-n> :set invrelativenumber<cr>

" Distraction-free writing
map <F12> :Goyo<CR>

" Highlight current file in NERDTree
function! HighlightCurrent()
  let pathlist = split(expand('%'), '/')
  exec "Explore " . getcwd()
  while 1
    let elem = remove(pathlist, 0)
    if !search(elem, 'W')
      break
    endif
    if !empty(pathlist)
      exec "normal \<CR>"
    else
      break
    endif
  endwhile
endfunction
map <F2> :call HighlightCurrent()<CR>

map <silent> <leader>f :Autoformat<CR>

"--------Autocommands--------

" Enable file type detection, plugin and indentation files loading
filetype plugin indent on
syntax enable

augroup vimrc
  autocmd!

  " Reload vimrc automatically
  autocmd BufWritePost .vimrc source %

  " Keep line width for text files sane
  autocmd FileType text setlocal textwidth=78
  autocmd FileType java,xml setlocal tabstop=4 shiftwidth=4
  autocmd FileType gitcommit setlocal spell

  autocmd BufNewFile,BufReadPost *.gradle set filetype=groovy

  " Launch both distraction-free and hyperfocus writing plugins simultaneously
  autocmd User GoyoEnter Limelight
  autocmd User GoyoLeave Limelight!

  " Hightlight cursor position in current window only
  autocmd VimEnter,WinEnter * setlocal cursorline cursorcolumn
  autocmd WinLeave * setlocal nocursorline nocursorcolumn

augroup END

"-------Plugin configs-------

" Use only Git-tracked files for CtrlP search
let g:ctrlp_user_command = ['git ls-files --others --exclude-standard']
" Prefer tree view in netrw
let g:netrw_liststyle=3
