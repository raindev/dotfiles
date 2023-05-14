vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)
-- Toggle search highlighting
vim.keymap.set('', '<leader>th', function()
  vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)
vim.keymap.set('', '<leader>ts', function ()
  vim.opt.spell = not vim.opt.spell:get()
end)

-- Save the pinky
vim.keymap.set('i', 'jk', '<Esc>')
vim.keymap.set('i', 'kj', '<Esc>')
vim.keymap.set('n', '<leader>;', ':')

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>F', vim.cmd.Telescope, { desc = '[F]ind stuff' })
vim.keymap.set('n', '<leader>f<space>', telescope.resume, { desc = 'Resume [F]ind' })
vim.keymap.set('n', '<leader>ff', telescope.find_files, { desc = '[F]ind [F]iles' })
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = '[F]ind with [G]rep' })
vim.keymap.set('n', '<leader>fs', telescope.grep_string, { desc = '[F]ind [S]tring' })
vim.keymap.set('n', '<leader>fk', telescope.keymaps, { desc = '[F]ind [K]ey mapping' })
vim.keymap.set('n', '<leader>fo', telescope.oldfiles, { desc = '[F]ind [O]ld files' })
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = '[F]ind [H]elp' })
vim.keymap.set('', '<C-p>', telescope.git_files)

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>A', harpoon_mark.add_file)
vim.keymap.set('n', '<leader>H', harpoon_ui.toggle_quick_menu)
for i = 1, 5 do
  vim.keymap.set('n', '<leader>'..i, function() harpoon_ui.nav_file(i) end)
end

vim.keymap.set('n', ']q', vim.cmd.cnext)
vim.keymap.set('n', '[q', vim.cmd.cprev)

vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)
