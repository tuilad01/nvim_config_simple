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
		 local function selectItem(number)
			 cmp.mapping(function(fallback)
				 print("dat number" ..number)
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
		 local function selectNext(fallback)
			 if luasnip.jumpable(1) then
				 luasnip.jump(1)
			 elseif cmp.visible() then
				 cmp.select_next_item()
			 else
				 fallback()
			 end
		 end
		 local function selectPrev(fallback)
			 if luasnip.jumpable(-1) then
				 luasnip.jump(-1)  -- Jump to previous placeholder
			 elseif cmp.visible() then
				 cmp.select_prev_item()  -- Move up the completion list
			 else
				 fallback()  -- If no completion, fallback to normal Shift+Tab behavior (e.g., outdent)
			 end
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
					 if luasnip.expand_or_jumpable() then
						 luasnip.expand_or_jump()  -- Expand snippet or jump
					 elseif cmp.visible() then
						 cmp.confirm({ select = true })  -- Confirm completion with Tab
					 else
						 fallback()  -- If no completion, fallback to normal tab behavior (e.g., indent)
					 end
				 end, { "i", "s" }),
				 ["<S-Tab>"] = cmp.mapping(selectPrev, {"i", "s"}),
				 ["<CR>"] = cmp.mapping.confirm({ select = true }),  -- Confirm with Enter				 
				 ["<C-n>"] = cmp.mapping(selectNext, {"i", "s"}),
				 ["<C-p>"] = cmp.mapping(selectPrev, {"i", "s"}),
				 ["<Up>"] = cmp.mapping(selectPrev, {"i", "s"}),
				 ["<Down>"] = cmp.mapping(selectNext, {"i", "s"}),
			 },
			 windows = {
				 completion = cmp.config.window.bordered(),
				 documentation = cmp.config.window.bordered(),
			 },

		 })
	 end
}
