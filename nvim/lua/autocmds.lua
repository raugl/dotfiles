local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight when yanking (copying) text
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Don't continue comments when pressing o/O in normal mode
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove("o")
  end,
})
