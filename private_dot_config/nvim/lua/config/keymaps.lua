vim.keymap.set({'n', 'v'}, '<leader>;', ':', { desc = 'Command line mode' })
vim.keymap.set('', '<leader>th', function() -- <leader>ur
   vim.opt.hlsearch = not vim.opt.hlsearch:get()
end, { desc = '[T]oggle [H]ighlighting' })
vim.keymap.set('', '<leader>ts', function() -- <leader>us
   vim.opt.spell = not vim.opt.spell:get()
end, { desc = '[T]oggle [S]pellcheck' })
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle, { desc = 'Toggle [U]ndootree' })

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>A', harpoon_mark.add_file, { desc = '[Add] to Harpoon' })
vim.keymap.set('n', '<leader>H', harpoon_ui.toggle_quick_menu, { desc = 'Show [H]arpoon' })
for i = 1, 5 do
   vim.keymap.set('n', '<leader>' .. i, function()
      harpoon_ui.nav_file(i)
   end, { desc = 'Harpoon buffer #' .. i })
end

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>f<space>', telescope.resume, { desc = 'Resume [F]ind' }) -- <leader>sR
vim.keymap.set('n', '<leader>fg', telescope.live_grep, { desc = '[F]ind with [G]rep' }) -- <leader>/
vim.keymap.set('n', '<leader>fs', telescope.grep_string, { desc = '[F]ind [S]tring' }) -- <leader>sw/W
vim.keymap.set('n', '<leader>fk', telescope.keymaps, { desc = '[F]ind [K]ey mapping' }) -- <leader>sk
vim.keymap.set('n', '<leader>fo', telescope.oldfiles, { desc = '[F]ind [O]ld files' }) -- <leader>fr
vim.keymap.set('n', '<leader>fh', telescope.help_tags, { desc = '[F]ind [H]elp' }) -- <leader>sh

-- restore default behaviour
vim.api.nvim_del_keymap('n', '<S-h>') -- top bprevious
vim.api.nvim_del_keymap('n', '<S-l>') -- bnext
