return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-context',
    'nvim-treesitter/nvim-treesitter-textobjects',
  },
  build = 'TSUpdate',
  config = function()
    require 'nvim-treesitter.configs'.setup{
      ensure_installed = { 
        'comment', 'markdown', 'markdown_inline', 'vim', 'vimdoc',
        'lua', 'c', 'cpp', 'zig', 'make', 'cmake',
      },
      auto_install = true,
      indent = { enable = true, disable = { 'ruby' } },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },

        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fstat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = '<M-i>',
          node_incremental = '<M-i>',
          node_decremental = '<M-o>',
        },
      },

      textobjects = {
        enable = true,

        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
          },
        },
        swap = {
          enable = true,
          swap_next = { ['<M-l>'] = '@parameter.inner' },
          swap_previous = { ['<M-h>'] = '@parameter.inner' },
        },
      },
    }
    require 'treesitter-context'.setup{
      mode = 'topline',
      max_lines = 2,
      multiwindow = true,
      min_window_height = 20,
    }
    vim.cmd 'hi! link TreesitterContext CursorLine'
  end
}
