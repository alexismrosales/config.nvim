-- Set <space> as the leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- [[ Basic Keymaps]]
-- Set <ctrl>s to write file
vim.keymap.set("n", "<c-s>", ":w<CR>")

-- Set <leader>e to open explorer
vim.keymap.set("n", "<leader>e", function()
	vim.cmd("ToggleNetrw")
end, { noremap = true })

-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Keybinds to make split navigation easier.
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move."<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move."<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move."<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move."<CR>')
