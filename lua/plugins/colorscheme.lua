return {
	--"askfiy/visual_studio_code",
	"catppuccin/nvim",
	name = "catppuccin-mocha",
	lazy = false, -- make sure we load this during startup if it is your main colorscheme
	priority = 1000, -- make sure to load this before all the other start plugins
	--transparent = true,

	config = function()
		require('catppuccin').setup({})
		vim.cmd([[colorscheme catppuccin-mocha]])
	end

}

