-- My configuration 
vim.o.number = true
vim.opt.scrolloff = 16
vim.o.relativenumber = true
vim.o.clipboard = "unnamedplus"
vim.o.shada = ""
vim.diagnostic.disable()
-- tab
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.expandtab = true

-- Line number relative colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "LightGray" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "Gray" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "LightGray" })

-- keymap
vim.keymap.set("n", "$", "g_")
vim.keymap.set("t", "<ESC>", "<C-\\><C-n>") 
vim.keymap.set("n", "<leader>n", function()
	vim.cmd([[Ex]])
end)


-- Move block code up and down
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv") -- down
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv") -- up

-- terminal
-- vim.opt.shell = "powershell.exe"

-- with open current current directory
vim.keymap.set("n", "<leader>e", function()
	vim.cmd([[!start %:p:h]])
end)

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


