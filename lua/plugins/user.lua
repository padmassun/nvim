-- ~/.config/nvim/lua/plugins/ufo.lua
return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = {
      "kevinhwang91/promise-async", -- required for async folds
    },
    event = "BufReadPost", -- load after opening a buffer
    config = function()
      -- Recommended fold settings
      vim.o.foldcolumn = "1" -- show fold column
      vim.o.foldlevel = 99 -- ensure folds are open
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true -- enable folding

      require("ufo").setup {
        provider_selector = function(bufnr, filetype, buftype)
          -- Choose treesitter for code files and indent for others
          return { "treesitter", "indent" }
        end,
      }
    end,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
}
