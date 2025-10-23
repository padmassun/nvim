require "user.options"
require "user.keybinds"
--if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = false }

vim.keymap.set("n", "<leader>r", function()
  local file = vim.fn.expand "%"
  vim.cmd("split | terminal python3 " .. file)
end, { noremap = true, silent = true, desc = "Run Python file in terminal" })

local Terminal = require("toggleterm.terminal").Terminal
local python_file_runner
local keymap = vim.keymap.set

-- fresh REPL
-- local python = Terminal:new {
--   cmd = "python3",
--   hidden = true,
-- }
-- local s_opts = { silent = true }
-- keymap("n", "<C-p>", function() return python:toggle() end, s_opts)

-- current file
keymap("n", "<C-b>", function()
  local expand = vim.fn.expand
  local errmsg

  vim.api.nvim_command "write"
  if vim.bo.buftype ~= "" then
    errmsg = "Can't run python file on terminal"
  elseif expand "%" == "" then
    errmsg = "Can't run python on unnamed file"
  end

  if errmsg ~= nil then
    vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
    return
  end

  -- python_file_runner = Terminal:new {
  --   dir = expand "%:p:h",
  --   cmd = "python3 " .. expand "%",
  --   hidden = true,
  --   close_on_exit = false,
  --   direction = "horizontal",
  --   on_exit = function() python_file_runner = nil end,
  -- }
  if vim.bo.filetype == "python" then
    local uname = vim.loop.os_uname()
    local python_cmd = "python"
    if uname.sysname == "Linux" then python_cmd = "python3" end
    vim.cmd(
      '2TermExec size=10 direction=horizontal name=python dir="'
        .. expand "%:p:h"
        .. '" cmd="'
        .. python_cmd
        .. " "
        .. expand "%:p"
        .. '"'
    )
  else
    -- The current buffer is not a Python file
    -- print "Not a Python buffer."
    vim.notify("Not a Python buffer.", vim.log.levels.WARN, { title = "toggleterm" })
  end

  -- python_file_runner:toggle()
end)

vim.api.nvim_create_user_command("Cppath", function()
  local expand = vim.fn.expand
  local errmsg

  vim.api.nvim_command "write"
  if vim.bo.buftype ~= "" then
    errmsg = "Can't run python file on terminal"
  elseif expand "%" == "" then
    errmsg = "Can't run python on unnamed file"
  end

  if errmsg ~= nil then
    vim.notify(errmsg, vim.log.levels.WARN, { title = "toggleterm" })
    return
  end

  local path = vim.fn.expand "%:p"
  local dirpath = vim.fn.expand "%:h"
  local cmd = 'cd "' .. dirpath .. '" && python "' .. path .. '"'
  -- vim.cmd('ToggleTerm size=10 direction=horizontal name=python dir="' .. path .. '"')
  vim.fn.setreg("+", cmd)
  vim.notify('Copied "' .. cmd .. '" to the clipboard!')
end, {})

-- Terminal
map("n", "<leader>tt", "<cmd>ToggleTerm<cr>", opts)

map("n", "<C-o>", "<cmd>Cppath<cr>", opts)

--
--
--
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
