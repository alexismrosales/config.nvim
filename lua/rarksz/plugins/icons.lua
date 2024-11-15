return {
	"nvim-tree/nvim-web-devicons",
	config = function()
		require("nvim-web-devicons")
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*",
			callback = function()
				if vim.bo.filetype == "netrw" then
					vim.cmd("silent! call g:NERDTreeRefreshRoot()")
				end
			end,
		})
	end,
}
