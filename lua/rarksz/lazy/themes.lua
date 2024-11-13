local selectedTheme = "catppuccin-mocha"

function ThemeColor()
	vim.cmd.colorscheme(selectedTheme)
end

return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha",
				transparent_background = false,
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
}
