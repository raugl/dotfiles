local space = { function() return ' ' end, padding = 0 }

local colors = {
  fg       = '#c8d3f5',
  bg       = '#222436',
  gray     = '#828bb8',
  darkgray = '#2f334d',
}

local ft_icon = {
  'filetype',
  icon_only = true,
  padding = { left = 1, right = 0 },
  color = { bg = colors.bg },

}

local filename = function(fg, bg)
  return {
    {
      'filename',
      path = 1,
      padding = 0,
      color = { bg = bg },
      fmt = function(path)
        return path:match("^(.*[/\\])(.*)$")
      end,
    },
    {
      'filename',
      padding = { left = 0, right = 1 },
      color = { fg = fg, bg = bg },
    },
  }
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = 'tokyonight',
      section_separators = '',
      component_separators = '',
    },
    -- TODO: remove [No Name]
    winbar = {
      lualine_c = vim.list_extend({ ft_icon }, filename(colors.fg, colors.bg)),
    },
    inactive_winbar = {
      lualine_c = vim.list_extend({ ft_icon }, filename(colors.gray, colors.bg)),
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        { 'branch', icon = '󰘬' },
        { 'diff', padding = { left = 0, right = 1 } },
        { 'diagnostics', padding = 1 },
      },
      lualine_c = vim.list_extend({ space }, filename(colors.fg, colors.darkgray)),
      lualine_x = {
        { 'filetype', icon_only = false },
        { 'encoding', padding = 0 },
        {
          'fileformat',
          padding = { left = 0, right = 1 },
          symbols = { dos = '[dos]', mac = '[unix]', unix = '[unix]' },
        },
        { 'filesize', padding = { left = 0, right = 1 }
        },
      },
      lualine_y = { 'searchcount', 'selectioncount' },
      lualine_z = { 'location' },
    },
  },
}
