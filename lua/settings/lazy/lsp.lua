-- https://github.com/VonHeikemen/lsp-zero.nvim
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
        local cmp = require('cmp')
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities())
        require("fidget").setup({})
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "rust_analyzer",
                "html",
                "cssls",
                "pylsp"
            },
            handlers = {
                function(server_name) -- default handler (optional)

                    require("lspconfig")[server_name].setup {
                        capabilities = capabilities
                    }
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup {
                        cpabilities = capabilities,
                        settings = {
                            Lua = {
                                runtime = { version = "Lua 5.1" },
                                diagnostics = {
                                    globals = { "vim", "it", "describe", "before_each", "after_each" },
                                }
                            }
                        }
                    }
                end,
                ["pylsp"] = function()
                    require("lspconfig").pylsp.setup {
                        settings = {
                            pylsp = {
                                plugins = {
                                    flake8 = { enabled = true },
                                    mccabe = { enabled = false },
                                    pyflakes = { enabled = false },
                                    pycodestyle = { enabled = false },
                                },
                            },
                        }
                }
                end
            }
        })

        -- local cmp_select = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            snippet = {
                expand = function(args)
                    -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
                end,
            },
            matching = {
                -- disallow_fuzzy_matching = true,
                -- disallow_fullfuzzy_matching = true,
                -- disallow_partial_fuzzy_matching = true,
                -- disallow_partial_matching = true,
                -- disallow_prefix_unmatching = true,
            },
            mapping = cmp.mapping.preset.insert({
                ['<Tab>'] = cmp.mapping.confirm({ select = true }),
                ['<C-k>'] = cmp.mapping.scroll_docs(-4),
                ['<C-j>'] = cmp.mapping.scroll_docs(4),
            }),
            window = {
                -- completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            },
            formatting = {
                format = function(_, vim_item)
                    vim_item.abbr = string.sub(vim_item.abbr, 1, 20)
                    return vim_item
                end
            },
            sources = cmp.config.sources(
                {
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                },
                {
                    -- put here other source displayed if not found in first
                    -- { name = 'buffer' },
                }
            )
        })
        vim.diagnostic.enable(false)
        function Toggle_diagnostics()
            if vim.g.diagnostics_active then
                vim.g.diagnostics_active = false
                vim.diagnostic.enable(false)
            else
                vim.g.diagnostics_active = true
                vim.diagnostic.enable(true)
            end
        end
        vim.keymap.set(
            'n', '<leader>f', Toggle_diagnostics,
            { noremap = true, silent = true, desc = "Toggle vim diagnostics" }
        )
        vim.diagnostic.config({
            -- virtual_text = false,
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
            },
        })

    end
}
