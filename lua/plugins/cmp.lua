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
		require("luasnip")
		local luasnip = require("luasnip")
		-- Load default VSCode-style snippets (optional)
		require("luasnip.loaders.from_vscode").lazy_load()
		luasnip.snippets = {
			all = {
				luasnip.parser.parse_snippet("trigger", "This is a snippet with a ${1:placeholder}."),
			},
		}

		 local cmp = require("cmp")
		 local function selectItem(number)
			 return cmp.mapping(function(fallback)
				 if luasnip.jumpable(number) then
					 luasnip.jump(number)
				 elseif cmp.visible() then
					 if number > 0 then
						 cmp.select_next_item()
					 else
						 cmp.select_prev_item()
					 end
				 else
					 fallback()
				 end
			 end, { "i", "s" })
		 end

		 local function selectNext()
			 return selectItem(1) 
		 end

		 local function selectPrev()
			 return selectItem(-1) 
		 end

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
					 if cmp.visible() then
						 cmp.confirm({ select = true })  -- Confirm completion with Tab
					 elseif luasnip.expand_or_jumpable() then
						 luasnip.expand_or_jump()  -- Expand snippet or jump
					 else
						 fallback()  -- If no completion, fallback to normal tab behavior (e.g., indent)
					 end
				 end, { "i", "s" }),
				 ["<S-Tab>"] = selectPrev(),
				 ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm with Enter				 
				 ["<C-n>"] = selectNext(),
				 ["<C-p>"] = selectPrev(),
				 ["<Up>"] = selectPrev(),
				 ["<Down>"] = selectNext(),
				 ['<Esc>'] = cmp.mapping.abort()
			 },
			 windows = {
				 completion = cmp.config.window.bordered(),
				 documentation = cmp.config.window.bordered(),
			 },

		 })
	 end
}
