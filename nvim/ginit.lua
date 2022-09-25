vim.opt.guifont = "Source Code Pro:h18"

vim.keymap.set({'', '!'}, '<F11>', function()
  local full_screen = vim.g.GuiWindowFullScreen
  vim.fn.GuiWindowFullScreen(full_screen ~= 1)
end)
