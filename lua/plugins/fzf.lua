return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function () 
		local fzfLua = require("fzf-lua") 
	  fzfLua.setup { "hide" }

		local cwd = vim.fn.getcwd()
	  -- map key
    vim.keymap.set("n", "<leader>b", function()
      fzfLua.buffers({ cwd = cwd, resume = true })
		end)
		vim.keymap.set("n", "<C-p>", function()
		  fzfLua.files({ cwd = cwd, resume = true })
	  end)
	  vim.keymap.set("n", "<leader>p", function()
		  fzfLua.files({ cwd = vim.fn.expand("%:p:h"), resume = true })
	  end)
	  vim.keymap.set("n", "<C-f>", function()
		  fzfLua.grep({ cwd = cwd })
	  end)
		-- vim.keymap.set("n", "gr", function()
		-- 	fzfLua.lsp_references()
		-- end)
  end
}
