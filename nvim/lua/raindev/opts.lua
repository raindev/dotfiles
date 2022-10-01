-- Enable true color support
vim.opt.termguicolors = true
vim.opt.background = 'light'
require('onedark').load()
-- Enable syntax highlighting without touching color scheme
vim.cmd('syntax enable')

-- Use spaces instead of tabs
vim.opt.expandtab = true

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
-- Display line numbers
vim.opt.number = true

-- Do not highlight search results
vim.opt.hlsearch = false
-- Autocomplete to the longest commons string and than cycle through the
-- alternatives
vim.opt.wildmode = "longest:full,full"

-- Keymap
vim.g.mapleader = ' '
vim.keymap.set('', '<C-p>', function()
  vim.cmd(':Telescope')
end, { silent = true })
-- Toggle search highlighting
vim.keymap.set('', '<leader>h', function()
  vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)

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

-- Load local configuration
local local_init = home_dir .. '/.config/nvim/init.local.lua'
if vim.fn.filereadable(local_init) ~= 0 then
  dofile(local_init)
end
