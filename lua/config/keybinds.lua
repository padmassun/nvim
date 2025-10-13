vim.g.mapleader = " "
vim.keymap.set("n", "<leader>cd", vim.cmd.Ex)

vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { noremap = true, silent = true })
