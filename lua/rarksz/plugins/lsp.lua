return {
	{
		"mrcjkb/rustaceanvim",
		version = "^5", -- Recommended
		lazy = false, -- This plugin is already lazy
	},
	{
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
			"windwp/nvim-autopairs",
			"saadparwaiz1/cmp_luasnip",
			"j-hui/fidget.nvim",
		},

		config = function()
			local cmp = require("cmp")
			local cmp_lsp = require("cmp_nvim_lsp")
			local mason_lspconfig = require("mason-lspconfig")
			local lspconfig = require("lspconfig")
			local npairs = require("nvim-autopairs")
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_lsp.default_capabilities()
			)

			require("fidget").setup({})
			-- Mason installations
			require("mason").setup({
				opts = {
					ensure_installed = {
						"css-lsp",
						"stylua",
						"prettier",
						"html-lsp",
						"black",
					},
				},
			})
			-- Lsp config just add your new lsp
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
					"gopls",
					"tailwindcss",
					"cssls",
					"pyright",
					"rust_analyzer",
				},
				handlers = {
					function(server_name) -- default handler (optional)
						require("lspconfig")[server_name].setup({
							capabilities = capabilities,
						})
					end,
					["lua_ls"] = function()
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
						lspconfig.ts_ls.setup({
							capabilities = capabilities,
							init_options = {
								preferences = {
									disableSuggestions = true,
								},
							},
						})
					end,
					["cssls"] = function()
						lspconfig.cssls.setup({
							capabilities = capabilities,
							settings = {
								css = {
									validate = true,
									lint = {
										unknownAtRules = "ignore", -- Ignore warnings
									},
								},
								scss = { validate = true },
								less = { validate = true },
							},
							on_attach = function(client, _)
								-- Disable autoformatting
								client.server_capabilities.documentFormattingProvider = false
							end,
						})
					end,
					["tailwindcss"] = function()
						lspconfig.tailwindcss.setup({
							capabilities = capabilities,
							filetypes = {
								"html",
								"css",
								"javascript",
								"javascriptreact",
								"typescript",
								"typescriptreact",
							},
							root_dir = lspconfig.util.root_pattern(
								"tailwind.config.js",
								"tailwind.config.ts",
								"postcss.config.js",
								"package.json"
							),
							on_attach = function(client, _)
								-- Disable autoformatting
								client.server_capabilities.documentFormattingProvider = false
							end,
						})
					end,
					["pyright"] = function()
						lspconfig.pyright.setup({
							capabilities = capabilities,
						})
					end,
				},
			})

			-- Functions with commands to go to code
			local on_attach = function(_, buffr)
				local opts = { noremap = true, silent = true, buffer = buffr }
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			end

			mason_lspconfig.setup_handlers({
				function(server)
					lspconfig[server].setup({
						on_attach = on_attach,
					})
				end,
			})

			local cmp_select = { behavior = cmp.SelectBehavior.Select }
			-- cmp config
			cmp.setup({
				--

				-- Completion popup
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

			-- Message with info when a diagnostic pop up
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
			-- Bracket completion
			npairs.setup({
				disable_filetype = { "TelescopePrompt", "vim" },
				check_ts = true,
			})
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
}
