return {
	"ThePrimeagen/git-worktree.nvim",
	dependencies = { "nvim-telescope/telescope.nvim" },
	config = function()
		require("telescope").load_extension("git_worktree")
		require("git-worktree").setup({})

		vim.keymap.set("n", "<leader>gb", ":Telescope git_branches<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gs", ":Telescope git_status<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gc", ":Telescope git_commits<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "<leader>gw", ":Telescope git_worktree<CR>", { noremap = true, silent = true })
	end,
}
