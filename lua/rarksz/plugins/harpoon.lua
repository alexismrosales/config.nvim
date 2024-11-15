return {

	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local harpoon = require("harpoon")
		-- REQUIRED
		harpoon:setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				enter_on_sendcmd = true,
			},
		})
		-- REQUIRED

		vim.keymap.set("n", "<leader>a", function()
			harpoon:list():add()
		end)
		vim.keymap.set("n", "<S-h>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		vim.keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end)
		vim.keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end)
		vim.keymap.set("n", "<leader>6", function()
			harpoon:list():select(6)
		end)

		vim.keymap.set("n", "<leader>!", function()
			harpoon:list():replace_at(1)
		end)
		vim.keymap.set("n", "<leader>@", function()
			harpoon:list():replace_at(2)
		end)
		vim.keymap.set("n", "<leader>#", function()
			harpoon:list():replace_at(3)
		end)
		vim.keymap.set("n", "<leader>$", function()
			harpoon:list():replace_at(4)
		end)
		vim.keymap.set("n", "<leader>%", function()
			harpoon:list():replace_at(5)
		end)
		vim.keymap.set("n", "<leader>6", function()
			harpoon:list():replace_at(6)
		end)

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<leader>,", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<leader>.", function()
			harpoon:list():next()
		end)
	end,
}
