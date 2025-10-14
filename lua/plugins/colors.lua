local function enable_transparency()
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
end
return {
	{
		"tiagovla/tokyodark.nvim",
		opts = {
			-- custom options here
			transparent_background = false, -- set background to transparent
		},
		priority = 1000,
		lazy = false,
		config = function(_, opts)
			require("tokyodark").setup(opts) -- calling setup is optional
			vim.cmd([[colorscheme tokyodark]])
			enable_transparency()
		end,
	},

	-- {
	-- 	-- "marciomazza/vim-brogrammer-theme",
	-- 	-- name = "brogrammer",
	-- 	-- priority = 1000,
	-- 	-- config = function()
	-- 	-- 	vim.cmd.colorscheme("brogrammer")
	-- 	-- 	enable_transparency()
	-- 	-- end,
	-- },

	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {
			theme = "brogrammer",
		},
	},
}
