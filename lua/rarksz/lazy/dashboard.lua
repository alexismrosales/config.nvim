return {
	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "doom",
			config = {

				header = {
					[[]],
					[[]],
					[[]],
					[[]],
					[[ ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗]],
					[[ ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║]],
					[[ ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║]],
					[[ ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║]],
					[[ ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║]],
					[[ ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝]],
					[[]],
					[[]],
					[[]],
					[[]],
				},
				center = {
					{
						icon = "󰱼 ",
						icon_hl = "Title",
						desc = "File explorer           ",
						desc_hl = "String",
						key = "_ e",
						key_hl = "Number",
						key_format = " %s", -- remove default surrounding `[]`
						action = "Ex", --
					},
					{
						icon = " ",
						icon_hl = "Title",
						desc = "Find File           ",
						desc_hl = "String",
						key = "_ ff",
						key_hl = "Number",
						key_format = " %s", -- remove default surrounding `[]`
						action = "lua print(2)",
					},
				},
				footer = {},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
