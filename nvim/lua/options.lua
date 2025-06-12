-- TODO:
-- lsp completions
-- better hover window
-- mini.pairs
-- telescope
-- oil.nvim
-- toggleterm
-- emulate tmux splits/zoom within kitty+nvim
-- git signs?
-- maybe add task runner and parse output into quickfix
-- formatting/linting
-- tweak colorscheme
-- folding: ufo.nvim
-- debugging

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Allow cursor wrap
vim.cmd 'set whichwrap+=<,>,[,],h,l'

-- Better completion window
-- vim.opt.completeopt = 'menu,menuone,noinsert,preview'
-- vim.opt.pumblend = 0 -- Transparent popups
-- vim.opt.pumheight = 13 -- Maximum number of entries in a popup

-- Folding
-- vim.opt.foldcolumn = '0' -- Disable the fold column
-- vim.opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
-- -- vim.opt.foldlevelstart = 99
-- vim.opt.fillchars = {
--   foldopen = '',
--   foldclose = '',
--   fold = ' ',
--   foldsep = ' ',
-- }

-- Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.breakindent = true
vim.opt.cmdheight = 0
vim.opt.confirm = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.ignorecase = true
vim.opt.laststatus = 3
vim.opt.linebreak = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.mouse = 'a'
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showtabline = 0
vim.opt.sidescrolloff = 12
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smoothscroll = true
vim.opt.spelllang = { 'en', 'ro' }
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.tabstop = 4
vim.opt.termguicolors = true
vim.opt.timeoutlen = 250
vim.opt.undofile = true
vim.opt.updatetime = 200
vim.opt.virtualedit = 'block'
