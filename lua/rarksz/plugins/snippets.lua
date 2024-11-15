return {
	"L3MON4D3/LuaSnip",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node

		-- Personal snippets
		ls.add_snippets("html", {
			s("lorem", {
				t(
					"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
				),
			}),
		})
		-- Adding html snippets to other type files
		ls.filetype_extend("javascript", { "html" }) -- Snippets HTMl avalaible on js
		ls.filetype_extend("typescript", { "html" }) -- Snippets HTML avalaible on TS
		ls.filetype_extend("javascriptreact", { "html" }) -- For JSX
		ls.filetype_extend("typescriptreact", { "html" }) -- For TSX

		-- Load snippets
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
}
