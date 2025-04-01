return {
    'nvim-telescope/telescope.nvim',
    event = "BufAdd",
    tag = '0.1.8',
    -- or                              , branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function ()
        -- Telescope config
        local telescope = require('telescope')
        local builtin = require('telescope.builtin')
        local actions = require('telescope.actions')

				local command = {"rg","--files"}
				local excludes = {"--glob", "!**/.git/*",  "--glob", "!**/node_modules/*", "--glob", "!**/build/*", "--glob", "!**/dist/*"} 

				for _, exclude in ipairs(excludes) do
					table.insert(command, exclude)
				end
				

        telescope.setup({
            defaults = {
                mappings = {
                    i = {
                        ["<esc>"] = actions.close,
                    }
                }
            },
        })
        vim.keymap.set('n', '<C-p>', function ()
            builtin.find_files({
                find_command = command
            })
        end, { desc = 'Telescope find files' })
        -- vim.keymap.set('n', '<C-f>', function()
        --     builtin.grep_string({
        --         search = vim.fn.input("Grep For > "),
        --         additional_args = exludes
        --     })
        -- end, { desc = "Telescope search string" })
        vim.keymap.set('n', '<C-f>', function()
					require('config.telesccope.multigrep').live_multigrep()
        end, { desc = "Telescope search string" })

        vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Telescope find in buffers' })
        -- vim.keymap.set('n', '<leader>km', function() builtin.keymaps() end, { desc = "Telescope shows keymaps" })

    end
}
