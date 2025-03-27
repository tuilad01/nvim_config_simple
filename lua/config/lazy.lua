-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"

  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sur to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.o.number = true
vim.opt.scrolloff = 16
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.shada = ""
vim.diagnostic.disable()
-- tab
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true
vim.opt.autoindent = true
-- keymap
vim.keymap.set("n", "$", "g_")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>") 
vim.keymap.set("n", "<leader>n", function()
	vim.cmd([[Ex]])
end)
-- terminal
vim.opt.shell = "powershell.exe"

local function swapComponentAndTemplateAngular() 
	local currentFileExtension = vim.fn.expand("%:e")
	local swappingFileExtension = ""
	if currentFileExtension == "html" then
		swappingFileExtension = ".ts"
	elseif currentFileExtension == "ts" then
		swappingFileExtension = ".html"
	else
		print("Unsupported ." .. currentFileExtension)
		return
	end

	local swappingFilePath = vim.api.nvim_buf_get_name(0):gsub("%."..currentFileExtension.."$", "%"..swappingFileExtension)
	if swappingFilePath == "" then
		print("Not found " .. swappingFileExtension)
		return
	end

	vim.cmd("e " .. swappingFilePath)
	print("Swapped " .. swappingFileExtension)
end
vim.keymap.set("n", "<leader>1", function()
	swapComponentAndTemplateAngular()
end)
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  -- install = { colorscheme = { "catppuccin/nvim" } },
  -- automatically check for plugin updates
  -- checker = { enabled = true },
})

