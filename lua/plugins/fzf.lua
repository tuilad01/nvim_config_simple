return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},
  config = function () 
	  require("fzf-lua").setup {}


	  -- map key
    vim.keymap.set("n", "<leader>p", function()
      local queryString = vim.fn.input("Enter your query string: ")
      require("fzf-lua").files({ query = queryString })
    end)
	  vim.keymap.set("n", "<C-p>", function()
		  require("fzf-lua").files({ cwd = vim.fn.getcwd(), resume = true })
	  end)
	  vim.keymap.set("n", "<C-f>", function()
		  require("fzf-lua").live_grep()
	  end)
  end
}
