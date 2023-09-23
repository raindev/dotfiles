-- Enable true color support
vim.opt.termguicolors = true
require('onedark').load()
-- Enable syntax highlighting without touching color scheme
vim.cmd('syntax enable')

-- Render tabs as 8 spaces
vim.opt.tabstop = 8
-- Insert 4 spaces for a tab
vim.opt.softtabstop = 4
-- Insert 4 spaces for an indent
vim.opt.shiftwidth = 4
-- Replace each 8 spaces by a tab
vim.opt.expandtab = false

-- Use space as vertical split character
vim.opt.fillchars:append('vert: ')
-- Show trailing characters, tabs and non-breakable spaces
vim.opt.list = true
vim.opt.listchars:append('tab:▸ ')
vim.opt.listchars:append('trail:·')
vim.opt.listchars:append('nbsp:⍽')
-- Show when line continues outside of screen
vim.opt.listchars:append('extends:»')
vim.opt.listchars:append('precedes:«')
-- Conceal syntax (e.g. Markdown), but not completely (highlight code block marks)
vim.opt.conceallevel=1
-- Display line numbers
vim.opt.number = true
-- Highlight the line number for the current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'
-- Always display the line info column to avoid jumping
vim.opt.signcolumn = 'yes'
-- Open folds by default
vim.opt.foldlevelstart=99

-- Do not highlight search results
vim.opt.hlsearch = false
-- Autocomplete to the longest commons string and than cycle through the
-- alternatives
vim.opt.wildmode = 'longest:full,full'

local home_dir = vim.env.HOME

-- Keep backup if file is overwritten
vim.opt.backup = true
-- Create backupdir if doens't exist
local backup_dir = home_dir .. '/.cache/nvim/backup'
if vim.fn.isdirectory(backup_dir) ~= 1 then
  vim.fn.mkdir(backup_dir)
end
-- Save all backups in one place rather than in .
vim.opt.backupdir = backup_dir
-- Create swap directory if doens't exist
local swap_dir = home_dir .. '/.cache/nvim/swap'
if vim.fn.isdirectory(swap_dir) ~= 1 then
  vim.fn.mkdir(swap_dir)
end
-- Save netrw history and bookmarks outside of configs dir
vim.g.netrw_home = home_dir .. '/.cache/nvim/'
-- Persist undoo history
vim.opt.undofile = true

-- Load local configuration
local local_init = home_dir .. '/.config/nvim/init.local.lua'
if vim.fn.filereadable(local_init) ~= 0 then
  dofile(local_init)
end
