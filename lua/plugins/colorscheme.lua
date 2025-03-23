return {
	--"askfiy/visual_studio_code",
	-- "catppuccin/nvim",
	-- name = "catppuccin-mocha",
	"folke/tokyonight.nvim",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	--transparent = true,
	opts = {},
	config = function()
		-- require('catppuccin').setup({})
		-- vim.cmd([[colorscheme catppuccin-mocha]])
		vim.cmd([[colorscheme tokyonight-storm]])
	end

}

