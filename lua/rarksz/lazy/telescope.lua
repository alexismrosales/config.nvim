return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		require("telescope").setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind a new [f]ile" })
		vim.keymap.set("n", "<leader>fw", function()
			local word = vim.fn.expand("<cword>")
			builtin.grep_string({ search = word })
		end, { desc = "[f]ind a new [w]word" })
		vim.api.nvim_set_keymap("n", "<leader>fb", ":Telescope buffers<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>lh", builtin.help_tags, { desc = "Show [l]azy [h]elp" })
	end,
}
