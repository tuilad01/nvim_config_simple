return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",               -- Snippet support
    "saauarwaiz1/cmp_luasnip",       -- LuaSnip source for nvim-cmp  
		"rafamadriz/friendly-snippets",
  },
  config = function()
		 local luasnip = require("luasnip")
		 -- Load default VSCode-style snippets (optional)
		 require("luasnip.loaders.from_vscode").lazy_load()
		 luasnip.snippets = {
			 all = {
				 luasnip.parser.parse_snippet("trigger", "This is a snippet with a ${1:placeholder}."),
			 },
		 }

		 local cmp = require("cmp")
	
		 cmp.setup({
			 sources = {
				 -- { name = "nvim_lsp" }
				 { name = "luasnip" },
				 { name = "buffer" },
				 { name = "path" },
				 { name = "cmdline" },
			 },

			 -- Snippet
			 snippet = {
				 expand = function(args)
					 luasnip.lsp_expand(args.body) -- Use luasnip for snippet expansion
				 end,
			 },	
			 -- Key mappings
			 mapping = {
				 ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion manually
				 ["<Tab>"] = cmp.mapping(function(fallback)
					 if luasnip.expand_or_jumpable() then
						 luasnip.expand_or_jump()  -- Expand snippet or jump
					 elseif cmp.visible() then
						 cmp.confirm({ select = true })  -- Confirm completion with Tab
					 else
						 fallback()  -- If no completion, fallback to normal tab behavior (e.g., indent)
					 end
				 end, { "i", "s" }),
				 ["<S-Tab>"] = cmp.mapping(function(fallback)
					 if luasnip.jumpable(-1) then
						 luasnip.jump(-1)  -- Jump to previous placeholder
					 elseif cmp.visible() then
						 cmp.select_prev_item()  -- Move up the completion list
					 else
						 fallback()  -- If no completion, fallback to normal Shift+Tab behavior (e.g., outdent)
					 end
				 end, { "i", "s" }),
				 ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm with Enter
			 },
			 windows = {
				 completion = cmp.config.window.bordered(),
				 documentation = cmp.config.window.bordered(),
			 },

		 })
	 end
}
