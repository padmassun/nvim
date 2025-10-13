vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

vim.keymap.set("n", "<leader>f", function()
	vim.lsp.buf.format()
end, { noremap = true, silent = true })

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Close buffer
map("n", "<C-w>", "<Cmd>BufferClose<CR>", opts)

-- Save buffer with Ctrl + s and stay in insert mode
map("i", "<C-s>", "<C-o>:w<CR>", opts)
