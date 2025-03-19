return {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' },
	options = {
		theme = 'nord'
	},
	config = function ()
		require('lualine').setup({
			sections = {
				lualine_c = {function()
					local absolutePath = vim.api.nvim_buf_get_name(0)
					local path = vim.fn.fnamemodify(absolutePath, ":.")
					return path
				end},
				-- lualine_x = {
				-- 	'encoding',
				-- 	function ()
				-- 		local cwd = vim.fn.getcwd()
				-- 		local workingDirectory = cwd:match("([^/\\]+)$")
				-- 		return workingDirectory
				-- 	end,
				-- 	'filetype'
				-- }
			}
		})
	end
}
