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

-- Source: https://github.com/nvim-treesitter/nvim-treesitter/issues/1564
-- vim.treesitter.query.set(
--   "python",
--   "folds",
--   [[
--   (function_definition (block) @fold)
--   (class_definition (block) @fold)
-- ]]
-- )

--
--
--  Source : https://www.reddit.com/r/neovim/comments/1emhivb/how_to_fold_only_2nd_or_nth_level_folds_in_a/
--
--
--
-- -- window size stuff for telescope picker
-- local picker_options = {
--   layout_config = {
--     cursor = {
--       height = 16,
--       width = 25,
--     },
--   },
-- }
--
-- -- options for the keymap
-- local keymap_opts = { silent = true }
--
-- -- invoked by the keymap
-- local set_fold_levels_menu = function()
--   -- all the stuff! \o/
--   local menu_items_and_actions = {
--     { "Open all folds", "open_all" },
--     { "Close all folds", "close_all" },
--     { "1 Fold level open", 1 },
--     { "2 Fold levels open", 2 },
--     { "3 Fold levels open", 3 },
--     { "4 Fold levels open", 4 },
--     { "5 Fold levels open", 5 },
--     { "6 Fold levels open", 6 },
--     { "7 Fold levels open", 7 },
--     { "8 Fold levels open", 8 },
--     { "9 Fold levels open", 9 },
--     { "10 Fold levels open", 10 },
--   }
--
--   -- soon to be items to show inside telescope picker _o/
--   local menu_items = {}
--
--   -- soon to be menu items mapped to an action \o_
--   local menu_items_to_actions = {}
--
--   -- it's happening! :D)-<
--   for _, v in ipairs(menu_items_and_actions) do
--     menu_items_to_actions[v[1]] = v[2]
--     table.insert(menu_items, v[1])
--   end
--
--   -- opening the telescope picker
--   vim.ui.select(menu_items, {
--     prompt = "Fold levels open",
--     telescope = require("telescope.themes").get_cursor(picker_options),
--   }, function(selected_menu_item)
--     if selected_menu_item == nil then return end
--
--     -- pick out the action from the menu_items_and_actions using the selected_menu_item
--     local menu_action = menu_items_to_actions[selected_menu_item]
--
--     -- check check check..
--     if menu_action and type(menu_action) == "string" then
--       if menu_action == "close_all" then
--         require("ufo").closeAllFolds()
--       elseif menu_action == "open_all" then
--         require("ufo").openAllFolds()
--       end
--     end
--
--     -- .. and check!
--     if menu_action and type(menu_action) == "number" and menu_action >= 1 and menu_action <= vim.o.foldnestmax then
--       require("ufo").closeFoldsWith(menu_action)
--     end
--   end)
-- end
--
-- -- keymap!
-- vim.keymap.set("n", "zZ", set_fold_levels_menu, keymap_opts)
-- vim.keymap.set("n", "<C-1>", function() require("ufo").closeFoldsWith(1) end, keymap_opts)
