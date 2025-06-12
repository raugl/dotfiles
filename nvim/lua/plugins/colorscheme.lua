---@diagnostic disable: missing-fields
return {
  'folke/tokyonight.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require 'tokyonight'.setup {
      lualine_bold = true,
      on_colors = function(c)
        c.bg_statusline = c.bg_dark
        c.bg_statusline = '#2f334d'
        c.blue1 = '#2ac3de'
      end,
      on_highlights = function(hl, c)
        hl['@lsp.type.comment'] = { link = 'none' }
        hl['@lsp.type.string'] = { link = 'none' }
        hl['@string.escape'] = { fg = c.red }

        hl['@lsp.type.namespace'] = { link = 'Preproc' }
        hl['@constant.builtin'] = { link = '@keyword' }
        hl['@function.builtin'] = { link = 'Function' }
        hl['@type.builtin'] = { link = 'Type' }
        hl['@variable.parameter.builtin'] = { link = '@variable.parameter' }
        hl['@keyword.operator'] = { link = '@keyword' }
        hl['@keyword.function'] = { link = "Conditional" }
        hl['@keyword'] = { link = "Statement" }
        hl['Conditional'] = { fg = c.purple, italic = true }
        hl['@variable.builtin'] = { link = '@variable' }

        -- hl['@punctuation.special'] = { fg = c.blue5 }
        -- hl['@punctuation.bracket'] = { fg = c.blue5 }
        -- hl['@punctuation.delimiter'] = { fg = c.blue5 }

        -- hl['@punctuation.special'] = { fg = c.fg_dark }
        -- hl['@punctuation.bracket'] = { fg = c.fg_dark }
        -- hl['@punctuation.delimiter'] = { fg = c.fg_dark }
        -- hl['@operator'] = { fg = c.fg_dark }
      end
    }
    vim.cmd 'colorscheme tokyonight-moon'

    -- vim.cmd("vnew") -- Open a new empty buffer in a split
    -- local buf = vim.api.nvim_get_current_buf()
    --
    -- local lines = {}
    -- local colors = require 'tokyonight.colors.storm'.setup()
    --
    -- for key, color in pairs(colors) do
    --   local header = string.format("%s =", key)
    --   local inspected = vim.inspect(color)
    --
    --   -- Split inspected string by newline
    --   for i, line in ipairs(vim.split(inspected, "\n")) do
    --     if i == 1 then
    --       table.insert(lines, header .. " " .. line)
    --     else
    --       table.insert(lines, "  " .. line)
    --     end
    --   end
    -- end
    --
    -- vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  end
}
