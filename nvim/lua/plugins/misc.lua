return {
  -- UI
  {
    'stevearc/dressing.nvim',
    event = 'VimEnter',
  },
  {
    'lukas-reineke/virt-column.nvim',
    opts = {
      virtcolumn = '100',
      highlight = 'IblIndent',
    },
  },
  {
    'petertriho/nvim-scrollbar',
    event = { 'BufNewFile', 'BufReadPre' },
    opts = {
      handlers = { cursor = false },
      handle = { color = '#3b4261' },
    },
    config = function(_, opts)
      require 'scrollbar'.setup(opts)
    end
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    event = { 'BufNewFile', 'BufReadPre' },
    opts = {
      indent = { char = '┇' },
      scope = { enabled = false },
      exclude = { filetypes = { 'harpoon' } },
    },
  },
  {
    "catgoose/nvim-colorizer.lua",
    event = "BufReadPre",
    opts = {
      user_default_options = {
        names = false,
        RGB = false,
        RGBA = false,
        RRGGBB = true,
        RRGGBBAA = true,
      },
    },
  },
  {
    'nvim-tree/nvim-web-devicons',
    lazy = true,
    config = function()
      local go = { name = 'Go', icon = '󰟓', color = '#00add8' }
      local makefile = { name = 'makefile', icon = '', color = '#e37933' }

      require('nvim-web-devicons').setup {
        override_by_filename = {
          ['go'] = go,
          ['go.mod'] = go,
          ['go.sum'] = go,
          ['makefile'] = makefile,
          ['gnumakefile'] = makefile,
        },
      }
    end,
  },

  -- Coding
  {
    'tpope/vim-sleuth',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
  },
  {
    'echasnovski/mini.pairs',
    event = 'InsertEnter',
    version = '*',
    opts = {
      modes = {
        insert = true,
        command = true,
        terminal = false,
      },
      mappings = {
        -- TODO: Use a treesitter query to close the bracket after the node
        ['('] = { neigh_pattern = '[^\\][^%w%(%[%{]' },
        ['['] = { neigh_pattern = '[^\\][^%w%(%[%{]' },
        ['{'] = { neigh_pattern = '[^\\][^%w%(%[%{]' },
        [')'] = false,
        [']'] = false,
        ['}'] = false,
        -- TODO: make them as above
        ['"'] = { action = 'open', register = { cr = true } },
        ["'"] = { action = 'open', register = { cr = true } },
        ['`'] = { action = 'open', register = { cr = true } },
      },
    },
  },

  -- Navigation
  {
    'folke/flash.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      labels = 'arstgmneioqwfpbjluy;xcdvzkh', -- NOTE: colemak-dh
      jump = { autojump = true },
      modes = {
        char = { autohide = true, jump_labels = true },
      }
    },
    config = function(_, opts)
      require 'flash'.setup(opts)
      vim.keymap.set({ 'n', 'x', 'o' }, 's', function() require('flash').jump() end)
    end,
  },
  {
    'ThePrimeagen/harpoon',
    branch = 'harpoon2',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      local harpoon = require 'harpoon'
      harpoon:setup {
        settings = { save_on_toggle = true, sync_on_ui_close = true },
      }

      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<leader>h", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

      vim.keymap.set("n", "<leader>m", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>n", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>e", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>i", function() harpoon:list():select(4) end)
      vim.keymap.set("n", "<leader>o", function() harpoon:list():select(5) end)
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { '<leader>k', '<cmd>Oil<cr>', desc = "Open oil" }
    },
    opts = {
      keymaps = {
        ["-"] = { "actions.parent", mode = "n" },
        ["<cr>"] = "actions.select",
        ["<esc>"] = { "actions.close", mode = "n" },
        ["<leader>q"] = { "actions.close", mode = "n" },
        ["<leader>-"] = { "actions.select", opts = { horizontal = true } },
        ["<leader>\\"] = { "actions.select", opts = { vertical = true } },
        ["<M-l>"] = "actions.select",
        ["<M-h>"] = { "actions.parent", mode = "n" },
        ["g?"] = { "actions.show_help", mode = "n" },
        ["gs"] = { "actions.change_sort", mode = "n" },
        ["gx"] = "actions.open_external",
        ["g."] = { "actions.toggle_hidden", mode = "n" },
        -- ["<C-l>"] = "actions.refresh",
        -- ["_"] = { "actions.open_cwd", mode = "n" },
        -- ["`"] = { "actions.cd", mode = "n" },
        -- ["~"] = { "actions.cd", opts = { scope = "tab" }, mode = "n" },
        -- ["g\\"] = { "actions.toggle_trash", mode = "n" },
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = true,
      prompt_save_on_select_new_entry = false,
    },
  },
  {
    'rmagatti/auto-session',
    lazy = false,
    opts = {
      suppressed_dirs = { '/', '~/', '~/Downloads' },
    }
  }
}
