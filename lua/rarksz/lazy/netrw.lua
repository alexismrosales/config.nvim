return {
	"prichrd/netrw.nvim",
	opts = {},
	config = function()
		-- toogle function to open netrw
		local toggle_netrw = function()
			if vim.bo.filetype == "netrw" then
				vim.cmd("bd")
			else
				vim.cmd("Ex")
			end
		end

		vim.api.nvim_create_user_command("ToggleNetrw", toggle_netrw, {})

		require("netrw").setup({})
	end,
}
