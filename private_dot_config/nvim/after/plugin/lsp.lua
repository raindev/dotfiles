local lsp = require('lsp-zero').preset({})
lsp.on_attach(function(_, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)
lsp.ensure_installed({
  'bashls',
  'jdtls',
  'lua_ls',
  'rust_analyzer',
  'zls',
})
require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
