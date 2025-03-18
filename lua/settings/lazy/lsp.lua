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
        "html",
        "htmx",
        "cssls",
        "tailwindcss",
        "pylsp",
        "ruff",
        "jinja_lsp",
        "tsserver",
        "quick_lint_js",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              -- Add this to attach lsp_signature to each buffer
              require("lsp_signature").on_attach({
                bind = true,
                floating_window = false,
                hint_enable = true,
                hint_prefix = "▸ ",
                hint_scheme = "String",
                always_trigger = true,
              }, bufnr)
            end

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
                  flake8 = { enabled = false},
                  mccabe = { enabled = false },
                  pyflakes = { enabled = false },
                  pycodestyle = { enabled = false },
                },
              },
            }
          }
        end,
      }})

      cmp.setup({
        snippet = {
          expand = function(args)
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
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
            vim_item.abbr = string.sub(vim_item.abbr, 1, 25)
            return vim_item
          end
        },
        sources = cmp.config.sources(
        {
          { name = 'nvim_lsp' },
          -- { name = 'luasnip' }, -- For luasnip users.
          {
            name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            },
          },
        },
        {
          -- put here other source to displayed nex if not found in first
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
