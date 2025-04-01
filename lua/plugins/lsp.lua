return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
	},
	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = {"lua_ls", "angularls", "ts_ls", "tailwindcss", "html", "jsonls"},
			handlers = {
				function (server_name)
					local capabilities = require('cmp_nvim_lsp').default_capabilities()
					require("lspconfig")[server_name].setup {
						capabilities = capabilities
					}
				end
			}
		})

		-- Keybindings
		vim.api.nvim_create_autocmd('LspAttach', {
			desc = 'LSP actions',
			callback = function(event)
				-- local client = vim.lsp.get_client_by_id(event.data.client_id)
				-- if client:supports_method('textDocument/completion') then
				-- 	vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
				-- end

				local opts = {buffer = event.buf}

				vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
				vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
				vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
				vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
				vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
				vim.keymap.set('n', 'gr', '<cmd>FzfLua lsp_references<cr>', opts)
				vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
				vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
				vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
				vim.keymap.set('n', '<F4>', '<cmd>FzfLua lsp_code_actions<cr>', opts)
				vim.keymap.set('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>', opts)
				vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', opts)
				vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', opts)
			end
		})
		-- Diagnostic
		-- local sign = function(opts)
		-- 	vim.fn.sign_define(opts.name, {
		-- 		texthl = opts.name,
		-- 		text = opts.text,
		-- 		numhl = ''
		-- 	})
		-- end
		--
		-- sign({name = 'DiagnosticSignError', text = '✘'})
		-- sign({name = 'DiagnosticSignWarn', text = '▲'})
		-- sign({name = 'DiagnosticSignHint', text = '⚑'})
		-- sign({name = 'DiagnosticSignInfo', text = ''})
		--
		-- vim.diagnostic.config({
		-- 	virtual_text = false,
		-- 	severity_sort = true,
		-- 	float = {
		-- 		border = 'rounded',
		-- 		source = 'always',
		-- 	},
		-- })
		--
		-- vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
		-- vim.lsp.handlers.hover,
		-- {border = 'rounded'}
		-- )
		--
		-- vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
		-- vim.lsp.handlers.signature_help,
		-- {border = 'rounded'}
		-- )

	end

}
