return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",               -- Snippet support
    "saadparwaiz1/cmp_luasnip",       -- LuaSnip source for nvim-cmp  
  },
  config = function()
    local cmp = require("cmp")

    cmp.setup({
      sources = {
        -- { name = "nvim_lsp" }
        { name = "buffer" },
        { name = "path" },
        { name = "cmdline" },
        { name = "luasnip" },
      },

      -- Key mappings
      mapping = {
        ["<C-Space>"] = cmp.mapping.complete(),  -- Trigger completion manually
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true })  -- Confirm completion with Tab
          else
            fallback()  -- If no completion, fallback to normal tab behavior (e.g., indent)
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
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
