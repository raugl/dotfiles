local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local lsp_on_attach = function(client, bufnr)
  local keymap = function(mode, keys, func, desc)
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  local hover = function()
    vim.lsp.buf.hover({ border = 'single', anchor_bias = 'above' })
  end

  keymap('n', 'K', hover, 'Hover Documentation')
  keymap('n', 'gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  keymap('n', 'gl', vim.diagnostic.open_float, 'Show diagnostic error messages')
  keymap('n', '<leader>lr', vim.lsp.buf.rename, '[R]ename')
  keymap('n', '<leader>la', vim.lsp.buf.code_action, 'Code [A]ction')
  keymap('n', '<leader>lk', vim.diagnostic.goto_prev, 'Go to previous [D]iagnostic message')
  keymap('n', '<leader>lj', vim.diagnostic.goto_next, 'Go to next [D]iagnostic message')
  keymap('n', '<leader>lq', vim.diagnostic.setloclist, 'Open diagnostic [Q]uickfix list')

  local builtin = require 'telescope.builtin'
  keymap('n', 'gr', builtin.lsp_references, '[G]oto [R]eferences')
  keymap('n', 'gd', builtin.lsp_definitions, '[G]oto [D]efinition')
  keymap('n', 'gI', builtin.lsp_implementations, '[G]oto [I]mplementation')
  keymap('n', '<leader>ld', builtin.lsp_type_definitions, 'Type [D]efinition')
  keymap('n', '<leader>ls', builtin.lsp_document_symbols, 'Document [S]ymbols')
  keymap('n', '<leader>lS', builtin.lsp_dynamic_workspace_symbols, 'Workspace [S]ymbols')

  -- Enable lsp reference highlighting
  if client and client.server_capabilities.documentHighlightProvider then
    autocmd({ 'CursorHold', 'CursorHoldI' }, {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
    })
    autocmd({ 'CursorMoved', 'CursorMovedI' }, {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
    })
  end
end

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'j-hui/fidget.nvim',
      'folke/neoconf.nvim',
      'saghen/blink.cmp',
      {
        'folke/lazydev.nvim',
        ft = 'lua',
        opts = { library = { '~/.dotfiles/nvim' } },
      },
    },
    config = function()
      vim.diagnostic.config {
        virtual_text = {
          spacing = 8,
          prefix = '■',
          source = 'if_many',
        },
        signs = false,
        severity_sort = true,
        float = { border = 'single' },
      }
      local lspconfig = require 'lspconfig'

      lspconfig['lua_ls'].setup {
        on_attach = lsp_on_attach,
      }
      lspconfig['clangd'].setup {
        on_attach = lsp_on_attach,
      }
      lspconfig['zls'].setup {
        settings = {
          zls = {
            enable_snippets = false,
            enable_argument_placeholders = false,
            skip_std_references = true,
          },
        },
        on_attach = lsp_on_attach,
      }
      lspconfig['nixd'].setup {
        settings = {
          nixd = {
            nixpkgs = {
              expr = 'import <nixpkgs> {}'
            },
            formatting = {
              command = { 'alejandra' }
            },
            options = {
              home_manager = {
                expr = '(builtin.getFlake "/home/raul/.dotfiles").homeConfigurations.default.options'
              }
            }
          },
        },
        on_attach = lsp_on_attach,
      }
    end,
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },
    version = '1.*',
    opts = {
      keymap = {
        ['<C-space>'] = { 'show', 'hide' },
        ['<C-y>'] = { 'select_and_accept' },

        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-n>'] = { 'select_next', 'fallback' },

        ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
        ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },

        ['<C-l>'] = { 'snippet_forward', 'fallback' },
        ['<C-h>'] = { 'snippet_backward', 'fallback' },
      },
      appearance = { nerd_font_variant = 'normal' },
      completion = {
        documentation = {
          auto_show = true,
          auto_show_delay_ms = 100,
          window = { border = 'single' }
        },
        menu = { border = 'single' },
        keyword = { range = 'full' },
        list = {
          selection = { preselect = false, auto_insert = false }
        },
      },
      signature = {
        enabled = true,
        window = { border = 'single' }
      },
      cmdline = { enabled = false },
    },
  },
  { -- FIXME: format on save doesn't work
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    keys = '<leader>lf',
    opts = {
      format_on_save = {
        timeout_ms = 500,
        lsp_format = 'fallback',
      },
      formatters = {
        jq = { command = 'jq', args = { '.' } },
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        json = { 'jq' },
        c = { 'clang-format' },
        cpp = { 'clang-format' },
        nix = { 'alejandra' },
      },
    },
    config = function(opts)
      local conform = require 'conform'
      conform.setup(opts)
      vim.keymap.set('n', '<leader>lf', function() conform.format { async = true, lsp_format = 'fallback' } end,
        { desc = 'LSP: [F]ormat buffer' })
    end,
  },
}
