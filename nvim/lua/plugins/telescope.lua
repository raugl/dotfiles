return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
    },
  },
  config = function()
    local ivy_theme = {
      theme = 'ivy',
      results_title = false,
      preview_title = false,
    }
    require('telescope').setup {
      -- other configuration values here
      defaults = {
        prompt_prefix = ' ',
        file_ignore_patterns = { '.git' },
        selection_caret = ' ',
        path_display = { 'truncate' },
        cache_picker = { num_pickers = 3 },
        -- stylua: ignore
        -- Always sort equivalent results based on line number
        tiebreak = function(_, _, _) return false end,
        -- results_title = false,
        -- sorting_strategy = 'descending',
      },
      pickers = {
        buffers = ivy_theme,
        builtin = ivy_theme,
        diagnostics = ivy_theme,
        grep_string = ivy_theme,
        help_tags = ivy_theme,
        keymaps = ivy_theme,
        live_grep = ivy_theme,
        oldfiles = ivy_theme,
        current_buffer_fuzzy_find = ivy_theme,
        highlights = ivy_theme,
        resume = ivy_theme,
        find_files = ivy_theme,
        -- find_files = {
        --   theme = 'dropdown',
        --   previewer = false,
        --   hidden = true,
        --   follow = true,
        -- },

        lsp_definitions = ivy_theme,
        lsp_document_symbols = ivy_theme,
        lsp_dynamic_workspace_symbols = ivy_theme,
        lsp_implementations = ivy_theme,
        lsp_type_definitions = ivy_theme,
        lsp_references = {
          -- TODO: make it so references are opened in the quickfix list and
          -- setup C-n/p in normal mode to navigate them
          theme = 'ivy',
          include_declaration = false,
          show_line = false,
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')

    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    vim.keymap.set('n', '<leader>so', builtin.oldfiles, { desc = '[S]earch [O]ld Files (recent)' })
    vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find,
      { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    -- vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })
  end,
}
