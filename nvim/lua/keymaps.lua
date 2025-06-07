-- TODO: Try to clean this up
-- FIXME: Closes treesitter-context window
local function close_floating()
  local inactive_floating_wins = vim.fn.filter(vim.api.nvim_list_wins(), function(_, win)
    local file_type = vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(win), 'filetype')
    local EXLUDED_FLOATING_FILETYPES = {
      'hydra_hint',
      'which-key',
      'zenmode-bg',
      'TelescopePrompt',
      'TelescopeResults',

      -- FIXME: Stop <esc> from closing treesitter_context's windows, filetypes don't work
      'treesitter_context',
      'treesitter_context_line_number',
    }

    return vim.api.nvim_win_get_config(win).relative ~= ''
        and win ~= vim.api.nvim_get_current_win()
        and not vim.tbl_contains(EXLUDED_FLOATING_FILETYPES, file_type)
  end)

  for _, win in ipairs(inactive_floating_wins) do
    pcall(vim.api.nvim_win_close, win, false)
  end

  vim.cmd 'nohlsearch'
end

-- Escape from terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader><leader>x', '<cmd>source %<cr>', { desc = 'Source the current lua file' })
vim.keymap.set('n', '<leader>x', '<cmd>.lua<cr>', { desc = 'Source the current lua line' })
vim.keymap.set('v', '<leader>x', '<cmd>lua<cr>', { desc = 'Source the current lua line' })

-- Move splits
vim.keymap.set({ 't', 'n', 'v' }, '<C-h>', '<cmd>wincmd h<cr>', { desc = 'Move focus to the left window' })
vim.keymap.set({ 't', 'n', 'v' }, '<C-j>', '<cmd>wincmd j<cr>', { desc = 'Move focus to the right window' })
vim.keymap.set({ 't', 'n', 'v' }, '<C-k>', '<cmd>wincmd k<cr>', { desc = 'Move focus to the lower window' })
vim.keymap.set({ 't', 'n', 'v' }, '<C-l>', '<cmd>wincmd l<cr>', { desc = 'Move focus to the upper window' })

-- better up/down
vim.keymap.set({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Resize splits
vim.keymap.set('n', '<C-Up>', '<cmd>resize +2<cr>', { desc = 'Increase window height' })
vim.keymap.set('n', '<C-Down>', '<cmd>resize -2<cr>', { desc = 'Decrease window height' })
vim.keymap.set('n', '<C-Left>', '<cmd>vertical resize -2<cr>', { desc = 'Decrease window width' })
vim.keymap.set('n', '<C-Right>', '<cmd>vertical resize +2<cr>', { desc = 'Increase window width' })

-- Move Lines
vim.keymap.set('n', '<M-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
vim.keymap.set('n', '<M-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
vim.keymap.set('i', '<M-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
vim.keymap.set('i', '<M-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
vim.keymap.set('v', '<M-j>', "<cmd>m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<M-k>', "<cmd>m '<-2<cr>gv=gv", { desc = 'Move selesction up' })

-- Split windows
vim.keymap.set('n', '<leader>-', '<cmd>split<cr>', { desc = '[-] Split horizontally' })
vim.keymap.set('n', '<leader>\\', '<cmd>vsplit<cr>', { desc = '[\\] Split vertically' })

-- Add undo break-points
vim.keymap.set('i', ',', ',<c-g>u')
vim.keymap.set('i', '.', '.<c-g>u')
vim.keymap.set('i', ';', ';<c-g>u')
vim.keymap.set('i', '<', '<<c-g>u')
vim.keymap.set('i', '(', '(<c-g>u')
vim.keymap.set('i', '[', '[<c-g>u')
vim.keymap.set('i', '{', '{<c-g>u')
vim.keymap.set('i', '"', '"<c-g>u')
vim.keymap.set('i', "'", "'<c-g>u")

-- Better indenting
vim.keymap.set('v', '<', '<gv', { desc = 'Indent selection left' })
vim.keymap.set('v', '>', '>gv', { desc = 'Indent selection right' })

-- Don't trash your clipboard when editing
vim.keymap.set('v', 'p', '"_dP', { silent = true })
vim.keymap.set({ 'n', 'v' }, 'c', '"_c', { silent = true })
vim.keymap.set({ 'i', 'c' }, '<c-v>', '<C-r>+', { silent = true })

-- More intuitive keybinds
vim.keymap.set('n', 'U', '<C-r>', { desc = 'Redo' })
vim.keymap.set('i', '<c-bs>', '<C-W>', { silent = true })
vim.keymap.set('i', '<c-del>', '<C-o>de', { silent = true })

vim.keymap.set('n', '<esc>', close_floating, { desc = 'Close floating windows' })
vim.keymap.set('n', '<leader>w', '<cmd>wa<cr>', { desc = '[W]rite all files' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Close window' })
vim.keymap.set('n', '<leader>va', 'ggVG', { desc = '[V]isual select [A]ll' })

vim.keymap.set({ 'n', 'v' }, 'gg', 'gg0', { desc = 'Move cursor to first character in buffer', silent = true })
vim.keymap.set({ 'n', 'v' }, 'G', 'G$', { desc = 'Move cursor to last character in buffer', silent = true })

-- Reset wierd keybinds
vim.keymap.set('n', '~', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<cr>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<space>', '<Nop>', { silent = true })
