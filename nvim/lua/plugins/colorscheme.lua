return {
	'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
	config = function(opts)
        require 'tokyonight'.setup{
            lualine_bold = true,
            on_colors = function(c)
                c.bg_statusline = c.bg_dark
                c.bg_statusline =  '#2f334d'
            end,
        }
		vim.cmd 'colorscheme tokyonight'
	end
}
