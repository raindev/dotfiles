local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
   -- stylua: ignore
   vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
      lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
   spec = {
      {
         "LazyVim/LazyVim",
         import = "lazyvim.plugins",
         opts = {
            colorscheme = "tokyonight"
         },
      },
      { import = "lazyvim.plugins.extras.lang.clangd" },
      { import = "lazyvim.plugins.extras.lang.go" },
      { import = "lazyvim.plugins.extras.lang.java" },
      { import = "lazyvim.plugins.extras.lang.rust" },
      { import = "lazyvim.plugins.extras.lang.typescript" },
      { import = "lazyvim.plugins.extras.lang.yaml" },
      { import = "plugins" },
   },
   -- the theme loaded by lazy.nvim when starting installation during start-up
   install = { colorscheme = { "tokyonight" } },
   performance = {
      rtp = {
         disabled_plugins = {
            "gzip",
            "matchit",
            "tarPlugin",
            "tohtml",
            "tutor",
            "zipPlugin",
         },
      },
   },
}, {
   dev = {
      path = "~/code",
      patterns = { "raindev" },
      fallback = true,
   },
})
