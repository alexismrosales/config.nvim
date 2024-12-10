local selectedTheme = "cyberdream"

function ThemeColor()
	vim.cmd.colorscheme(selectedTheme)
end

return {
	{
		"catppuccin/nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
		},
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = true,
				integrations = {
					mason = true,
					treesitter = true,
					dashboard = true,
					beacon = true,
					harpoon = true,
					cmp = true,
					telescope = {
						enabled = true,
						style = "nvchad",
					},
					lsp_trouble = true,
					native_lsp = {
						enabled = true,
					},
				},
				dim_inactive = {
					enabled = false, -- dims the background color of inactive window
					shade = "dark",
					percentage = 0.15, -- percentage of the shade to apply to the inactive window
				},
				no_italic = true, -- Force no italic
			})
			ThemeColor() -- Should call the function on the theme you wnat
			vim.api.nvim_set_hl(0, "StatusLine", { bg = "#1e1e2f", fg = "#cdd6f5" })
			vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#1e1e2f", fg = "#626880" })
			vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e1e2f", fg = "#cdd6f5" })
		end,
	},
	{
		"scottmckendry/cyberdream.nvim",
		lazy = false,
		priority = 1000,
		terminal_colors = true,
		config = function()
			require("cyberdream").setup({
				-- Enable transparent background
				transparent = true,
				borderless_telescope = false,
				extensions = {
					telescope = false,
					trouble = true,
					markdown = false,
					lazy = false,
					treesitter = false,
					treesittercontext = false,
				},
			})
		end,
	},
}
