return {
	"stevearc/overseer.nvim",
	config = function()
		local overseer = require("overseer")
		overseer.setup({})
		-- Registrar tareas personalizadas
		overseer.register_template({
			name = "Run npm start",
			builder = function()
				return {
					cmd = "npm",
					args = { "run", "start" },
					components = { "default" },
				}
			end,
			condition = {
				callback = function()
					return vim.fn.filereadable("package.json") == 1
				end,
			},
		})

		overseer.register_template({
			name = "Run Go project",
			builder = function()
				return {
					cmd = "go",
					args = { "run", "." },
					components = { "default" },
				}
			end,
			condition = {
				callback = function()
					return vim.fn.glob("*.go") ~= ""
				end,
			},
		})

		vim.keymap.set(
			"n",
			"<leader>ot",
			":OverseerToggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle Overseer" }
		)
		vim.keymap.set("n", "<leader>or", ":OverseerRun<CR>", { noremap = true, silent = true, desc = "Run Task" })
	end,
}
