return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		"hrsh7th/nvim-cmp",
		"L3MON4D3/LuaSnip",
		"saadparwaiz1/cmp_luasnip",
		"j-hui/fidget.nvim",
	},

	config = function()
		local cmp = require("cmp")
		local cmp_lsp = require("cmp_nvim_lsp")
		local capabilities = vim.tbl_deep_extend(
			"force",
			{},
			vim.lsp.protocol.make_client_capabilities(),
			cmp_lsp.default_capabilities()
		)

		require("fidget").setup({})
		require("mason").setup({
			opts = {
				ensure_installed = {
					"css-lsp",
					"stylua",
					"prettier",
					"html-lsp",
				},
			},
		})
		require("mason-lspconfig").setup({
			ensure_installed = {
				"lua_ls",
				"ts_ls",
				"gopls",
			},
			handlers = {
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["lua_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.lua_ls.setup({
						capabilities = capabilities,
						settings = {
							Lua = {
								runtime = { version = "Lua 5.1" },
								diagnostics = {
									globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
								},
							},
						},
					})
				end,
				["ts_ls"] = function()
					local lspconfig = require("lspconfig")
					lspconfig.ts_ls.setup({
						capabilities = capabilities,
						init_options = {
							preferences = {
								disableSuggestions = true,
							},
						},
					})
				end,
			},
		})

		local cmp_select = { behavior = cmp.SelectBehavior.Select }

		cmp.setup({
			window = {
				completion = {
					border = "rounded",
					col_offset = 1,
					side_padding = 1,
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				},
				documentation = {
					border = "rounded",
					winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
				},
			},
			formatting = {
				format = function(entry, vim_item)
					-- Iconos personalizados para diferentes fuentes
					local icons = {
						nvim_lsp = "",
						buffer = "",
						path = "",
						luasnip = "",
					}
					vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1e1e2e", fg = "#c0caf5" })
					vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#c0caf5" })
					vim.api.nvim_set_hl(0, "CmpScrollbar", { bg = "none", fg = "none" })
					vim_item.kind = string.format("%s %s", icons[entry.source.name] or "", vim_item.kind)
					return vim_item
				end,
			},
			snippet = {
				expand = function(args)
					require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<Tab>"] = cmp.mapping.select_next_item(cmp_select),
				["<CR>"] = cmp.mapping.confirm({ select = true }),
				["<C-Tab>"] = cmp.mapping.complete(),
			}),
			sources = cmp.config.sources({
				{ name = "nvim_lsp" },
				{ name = "luasnip" }, -- For luasnip users.
			}, {
				{ name = "buffer" },
				{ name = "path" },
			}),
		})

		vim.api.nvim_create_autocmd("CursorHold", {
			callback = function()
				vim.diagnostic.open_float(nil, {
					focusable = false,
					style = "minimal",
					border = "rounded",
					source = "always",
					header = "",
					prefix = "● ",
				})
			end,
		})
	end,
}
