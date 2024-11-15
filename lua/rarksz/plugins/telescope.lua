return {
	"nvim-telescope/telescope.nvim",

	tag = "0.1.8",

	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local telescope = require("telescope")
		telescope.setup({})
		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[f]ind a new [f]ile" })
		vim.keymap.set("n", "<leader>fw", function()
			require("telescope.builtin").live_grep({
				prompt_title = "Find Word",
				default_text = "",
			})
		end, { desc = "[f]ind a new [w]word" })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>fb",
			":Telescope buffers<CR>",
			{ noremap = true, silent = true, desc = "[f]ind [buffer]" }
		)
		vim.keymap.set("n", "<leader>fc", function()
			local word = vim.fn.expand("<cword>")
			require("telescope.builtin").live_grep({
				prompt_title = "Find Word Under Cursor",
				default_text = word,
			})
		end, { desc = "[f]ind [c]urrent word" })
		vim.keymap.set("n", "<leader>lh", builtin.help_tags, { desc = "Show [l]azy [h]elp" })
	end,
}
