" Install vim-plug if not present
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl --silent --fail --location
    \ --output ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/site/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-sleuth'
Plug 'andymass/vim-matchup'
Plug 'rust-lang/rust.vim'
Plug 'udalov/kotlin-vim'
Plug 'keith/swift.vim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-orgmode/orgmode'
Plug 'cocopon/iceberg.vim'
call plug#end()

" Enable true color support
set termguicolors
colorscheme iceberg
set background=light

" Do not highlight search results
set nohlsearch
" Navigate to search results immediately
set incsearch
" Use spaces instead of tabs
set expandtab
" Show partial commands and Visual mode selection size
set showcmd
" Show current position in the file
set ruler
" Use space as vertical split character
set fillchars=vert:\ "<- space
" Show trailing characters, tabs and non-breakable spaces
set list
set listchars=tab:▸\ ,trail:·,nbsp:⍽
" Display line numbers
set number
" Show command-line autocompletion list as a menu
set wildmenu
" Autocomplete to the end of string
set wildmode=full
" Increase command-line history size
set history=1000
" Hide abandoned buffers instead of unloading
set hidden
" Keep backup if file is overwritten
set backup
" Create backupdir if doens't exist
if !isdirectory($HOME.'/.cache/nvim/backup')
  call mkdir($HOME.'/.cache/nvim/backup/', 'p')
endif
" Save all backups in one place rather than in .
set backupdir=~/.cache/nvim/backup
" Create swap directory if doens't exist
if !isdirectory($HOME.'/.cache/nvim/swap')
  call mkdir($HOME.'/.cache/nvim/swap/', 'p')
endif
" Save all swap files in one place rather than in .
set directory=~/.cache/nvim/swap
" Save netrw history and bookmarks outside of configs dir
let g:netrw_home = '~/.cache/nvim/'

" Enable file type detection,
" filetype plugins and indent files
filetype plugin indent on
" Enable syntax highlighting without touching color scheme
syntax enable

augroup vimrc
  " Remove vimrc autocommands if added already
  autocmd!

  " Enable spell checking of commit messages
  autocmd FileType gitcommit setlocal spell
  " Place cursor in the beginning of commit message window
  autocmd FileType gitcommit normal gg
augroup end

let mapleader=' '
" Toggle search highlighting
map <silent> <leader>h :set hlsearch!<CR>

" orgmode.nvim config
lua << EOF

-- Load custom tree-sitter grammar for org filetype
require('orgmode').setup_ts_grammar()

-- Tree-sitter configuration
require'nvim-treesitter.configs'.setup {
  -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
  highlight = {
    enable = true,
    disable = {'org'}, -- Remove this to use TS highlighter for some of the highlights (Experimental)
    additional_vim_regex_highlighting = {'org'}, -- Required since TS highlighter doesn't support all syntax features (conceal)
  },
  ensure_installed = {'org'}, -- Or run :TSUpdate org
}

require('orgmode').setup({
  org_agenda_files = {'~/org/*'},
  org_default_notes_file = '~/org/inbox.org',
})
EOF

" Load local configuration
if filereadable($HOME.'/.config/nvim/init.vim.local')
  source ~/.config/nvim/init.vim.local
endif
