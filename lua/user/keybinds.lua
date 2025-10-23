local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format() end, { noremap = true, silent = true })

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", opts)
map("n", "<A-.>", "<Cmd>BufferNext<CR>", opts)

-- Close buffer
map("n", "<C-w>", "<Cmd>BufferClose<CR>", opts)

-- Save buffer with Ctrl + s and stay in insert mode
map("i", "<C-s>", "<C-o>:w<CR>", opts)
map("n", "<C-s>", ":w<CR>", opts)

vim.api.nvim_create_user_command("Cppath", function()
  local path = vim.fn.expand "%:p"
  local dirpath = vim.fn.expand "%:p:h"
  local cmd = 'cd "' .. dirpath .. '" && python "' .. path .. '"'
  vim.fn.setreg("+", cmd)
  vim.notify('Copied "' .. cmd .. '" to the clipboard!')
end, {})
-- Terminal
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)

map("n", "<leader>tc", "<cmd>Cppath<cr>", opts)
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "jk", [[<C-\><C-n>]], opts)
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
  vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"
