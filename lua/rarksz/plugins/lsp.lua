local lsp_servers = {
    'lua_ls',
    'ts_ls',
    'tailwindcss',
    'pyright',
    'gopls',
    'nil_ls',
    'bashls',
    'intelephense',
    'ccls'
}

local function on_attach_global(_, bufnr)
    local opts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
end

local lua_ls_config = {
    settings = {
        Lua = {
            diagnostics = { globals = { 'vim' } },
            runtime = { version = 'LuaJIT' },
            telemetry = { enable = false },
        },
    },
}



local function ts_ls_config(capabilities)
    return {
        capabilites = capabilities,
        init_options = {
            preferences = {
                disableSuggestions = true,
            }
        }
    }
end

local function tailwindcss_config(lspconfig, capabilities)
    return {
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
        on_attach = function(client, bufnr)
            -- Disable autoformatting
            client.server_capabilities.documentFormattingProvider = false
            on_attach_global(client, bufnr)
        end,

    }
end

local function pyright_config(capabilities)
    return {
        capabilities = capabilities
    }
end

local function gopls_config(capabilities)
    return {
        capabilities = capabilities
    }
end

local function nil_config(capabilities)
    return {
        capabilities = capabilities,
        filetypes = {
            "nix",
        }
    }
end

local function bashls_config(capabilities)
    return {
        capabilities = capabilities,
        filetypes = {
            "sh"
        }
    }
end

local function php_config(lspconfig, capabilities)
    return {
        root_dir = lspconfig.util.root_pattern("composer.json", ".git", "index.php", "init.php", "vendor"),
        capabilities = capabilities,
    }
end

local function ccls_config(capabilities)
    -- Detect a dynamic detection of .h files including .hpp
    local function detect_include_dirs()
        local handle = io.popen("find . -type d -name include")
        local result = handle:read("*a")
        handle:close()

        local include_dirs = {}
        for line in result:gmatch("[^\r\n]+") do
            table.insert(include_dirs, "-I" .. vim.fn.expand(line))
        end
        return include_dirs
    end
    local include_dirs = detect_include_dirs()
    return {
        capabilities = capabilities,
        init_options = {
            cache = {
                directory = ".ccls-cache",
            },
            clang = {
                extraArgs = include_dirs,
                resourceDir = "",
            },
        },
        filetypes = {
            "c",
            "cpp",
            "objc",
            "objcpp",
        }
    }
end
local diagnostics_config = {
    -- omitted for brevity
}

return {
    'VonHeikemen/lsp-zero.nvim',
    config = function()
        local lsp = require('lsp-zero')
        local cmp = require("cmp")
        local cmp_lsp = require("cmp_nvim_lsp")
        local lspconfig = require("lspconfig")
        local npairs = require("nvim-autopairs")
        local capabilities = vim.tbl_deep_extend(
            "force",

            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities()
        )
        -- cmp config
        cmp.setup({
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


        -- Colors for CMP and DIAGNOSTICS
        vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none", fg = "#7b8496" })

        vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#7b8496" })
        vim.api.nvim_set_hl(0, "DiagnosticError", { bg = "none", fg = "#ff6e5e" })
        vim.api.nvim_set_hl(0, "DiagnosticWarn", { bg = "none", fg = "#f1ff5e" })
        vim.api.nvim_set_hl(0, "DiagnosticInfo", { bg = "none", fg = "#ff5ef1" })
        vim.api.nvim_set_hl(0, "DiagnosticHint", { bg = "none", fg = "#5ef1ff" })


        vim.api.nvim_set_hl(0, "Pmenu", { bg = "none", fg = "#7b8496" })
        vim.api.nvim_set_hl(0, "PmenuBorder", { fg = "#7b8496" })
        vim.api.nvim_set_hl(0, "CmpScrollbar", { bg = "none", fg = "none" })
        vim.api.nvim_set_hl(0, "CmpItemKindWarning", { bg = "none", fg = "#f1ff5e" })
        vim.api.nvim_set_hl(0, "CmpItemKindError", { bg = "none", fg = "#ff6e5e" })
        vim.api.nvim_set_hl(0, "PmenuSel", { bg = "none", fg = "none" })


        -- Bracket completion
        npairs.setup({
            disable_filetype = { "TelescopePrompt", "vim" },
            check_ts = true,
        })
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())


        lsp.configure('lua_ls', lua_ls_config)
        lsp.configure('ts_ls', ts_ls_config(capabilities))
        lsp.configure('tailwindcss', tailwindcss_config(lspconfig, capabilities))
        lsp.configure('pyright', pyright_config(capabilities))
        lsp.configure('gopls', gopls_config(capabilities))
        lsp.configure('nil_ls', nil_config(capabilities))
        lsp.configure('bashls', bashls_config(capabilities))
        lsp.configure('intelephense', php_config(lspconfig, capabilities))
        lsp.configure('ccls', ccls_config(capabilities))
        lsp.setup_servers(lsp_servers)
        lsp.on_attach(on_attach_global)
        lsp.setup()

        vim.diagnostic.config(diagnostics_config)
    end,
    dependencies = {
        {
            'neovim/nvim-lspconfig',
            'hrsh7th/nvim-cmp',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-nvim-lua',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            "windwp/nvim-autopairs",
        },
    },
}
