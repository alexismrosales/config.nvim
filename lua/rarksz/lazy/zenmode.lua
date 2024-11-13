return {
	"folke/zen-mode.nvim",
	config = function()
		vim.keymap.set("n", "<leader>zz", function()
			require("zen-mode").setup({
				window = {
					width = 90,
					options = {},
				},
				plugins = {
					tmux = { enabled = true },
					kitty = {
						enabled = true,
						font = "+4", -- font size increment
					},
				},
			})
			require("zen-mode").toggle()
			vim.wo.wrap = false
			vim.wo.number = true
			vim.wo.rnu = true
		end)
	end,
}
