local augroup = vim.api.nvim_create_augroup("raindev", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup,
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup,
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
  end,
})
