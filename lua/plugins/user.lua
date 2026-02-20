-- ~/.config/nvim/lua/plugins/ufo.lua
return {
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   enabled = false,
  --   dependencies = {
  --     "kevinhwang91/promise-async", -- required for async folds
  --   },
  --   event = "BufReadPost", -- load after opening a buffer
  --   config = function()
  --     -- Recommended fold settings
  --     vim.o.foldcolumn = "1" -- show fold column
  --     vim.o.foldlevel = 99 -- ensure folds are open
  --     vim.o.foldlevelstart = 99
  --     vim.o.foldenable = true -- enable folding
  --
  --     -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  --     vim.keymap.set("n", "zR", require("ufo").openAllFolds)
  --     vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
  --
  --     require("ufo").setup {
  --       provider_selector = function(bufnr, filetype, buftype)
  --         -- Choose treesitter for code files and indent for others
  --         return { "treesitter", "indent" }
  --       end,
  --     }
  --   end,
  -- },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    -- or                              , branch = '0.1.x',
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  { "mfussenegger/nvim-dap-python", enabled = false },
  -- { "kevinhwang91/nvim-ufo", dependencies = { "kevinhwang91/promise-async" } },
}
