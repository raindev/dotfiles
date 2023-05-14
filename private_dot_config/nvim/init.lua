-- Configuration order
-- 1. set the leader mapping
-- 2. set up lazy
-- 3. install plugins
-- 4. configure options
-- 5. set up basic keymap
-- 6. configure filetype detection

-- lazy.nvim requires the leader to be mapped before it is loaded
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('raindev.plugins')
require('raindev.opts')
require('raindev.keymap')
require('raindev.filetype')
