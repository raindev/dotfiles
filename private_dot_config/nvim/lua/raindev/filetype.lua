-- Enable file type detection,
-- filetype plugins and indent files
vim.cmd('filetype plugin indent on')
local augroup = vim.api.nvim_create_augroup('raindev.ftype', {})

vim.api.nvim_create_autocmd({ 'FileType' }, {
  group = augroup,
  pattern = { 'gitcommit' },
  callback = function()
    vim.opt_local.spell = true
  end
})
