vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
-- Toggle search highlighting
vim.keymap.set('', '<leader>th', function()
  vim.opt.hlsearch = not vim.opt.hlsearch:get()
end)

local telescope = require('telescope.builtin')
vim.keymap.set('n', '<leader>F', ":Telescope<cr>")
vim.keymap.set('n', '<leader>ff', telescope.find_files)
vim.keymap.set('n', '<leader>fg', telescope.live_grep)
vim.keymap.set('n', '<leader>fs', telescope.grep_string)
vim.keymap.set('', '<C-p>', telescope.git_files)

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>A", harpoon_mark.add_file)
vim.keymap.set("n", "<leader>H", harpoon_ui.toggle_quick_menu)
vim.keymap.set("n", "<leader>h1", function() harpoon_ui.nav_file(1) end)
vim.keymap.set("n", "<leader>h2", function() harpoon_ui.nav_file(2) end)
vim.keymap.set("n", "<leader>h3", function() harpoon_ui.nav_file(3) end)
vim.keymap.set("n", "<leader>h3", function() harpoon_ui.nav_file(4) end)

vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)
