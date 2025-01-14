require("rarksz.set")
require("rarksz.remap")
require("rarksz.lazy_init")

vim.g.dispatch_tmux_new_window = 1

-- [[ Basic Autocommands ]]
--  See :help lua-guide-autocommands
vim.cmd([[highlight YankHighlight guibg=#5e6b80 guifg=#000000]])
-- Highlight when yanking (copying) text
--  Try it with yap in normal mode
--  See :help vim.highlight.on_yank()
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ higroup = "YankHighlight" })
	end,
})

vim.g.netrw_browse_split = 0
vim.g.netrw_winsize = 40
