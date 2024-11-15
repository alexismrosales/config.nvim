return {
	"stevearc/conform.nvim",
	event = { "BufWritePre", "BufNewFile" },
	cmd = { "ConformInfo" },
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			python = { "isort", "black" },
			javascript = { "deno_fmt" },
			typescript = { "deno_fmt" },
			javascriptreact = { "deno_fmt " },
			typescriptreact = { "deno_fmt " },
			go = { "go_imports", "go_lines" },
		},
		-- Set up format-on-save
		format_on_save = { timeout_ms = 500, async = false, lsp_fallback = true },
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "4" },
			},
		},
	},
}
