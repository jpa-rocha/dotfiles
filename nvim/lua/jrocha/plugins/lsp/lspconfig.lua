return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import lspconfig plugin
        local lspconfig = require("lspconfig")
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        ---
        -- Keybindings
        ---
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function()
            local bufmap = function(mode, lhs, rhs)
              local opts = {buffer = true}
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
            bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
            bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
            bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
            bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
            bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
            bufmap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
            bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
            bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
            bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
            bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
            bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
            bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
          end
        })
        ---
        -- Diagnostics
        ---

        local sign = function(opts)
          vim.fn.sign_define(opts.name, {
            texthl = opts.name,
            text = opts.text,
            numhl = ''
          })
        end

        sign({name = 'DiagnosticSignError', text = ' '})
        sign({name = 'DiagnosticSignWarn', text = ' '})
        sign({name = 'DiagnosticSignHint', text = '⚑'})
        sign({name = 'DiagnosticSignInfo', text = ''})

        vim.diagnostic.config({
          virtual_text = false,
          severity_sort = true,
          float = {
            border = 'rounded',
            source = 'always',
          },
        })

        vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
          vim.lsp.handlers.hover,
          {border = 'rounded'}
        )

        vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
          vim.lsp.handlers.signature_help,
          {border = 'rounded'}
        )

        lspconfig.gopls.setup({
            capabilities = lsp_capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
                golintci_lint = true,
            },
        })
        -- configure http
        lspconfig.html.setup({
            capabilities = lsp_capabilities,
        })

        -- configure css
        lspconfig.cssls.setup({
            capabilities = lsp_capabilities,
        })

        -- configure bash
        lspconfig.bashls.setup({
            capabilities = lsp_capabilities,
            settings = {
                bashIde = {
                    globPattern = "*@(.sh|.inc|.bash|.command)"
                }
            }
        })

        -- configure lua
        lspconfig.lua_ls.setup({
            capabilities = lsp_capabilities
            -- settings = {
            --     Lua = {
            --         diagnostics = {
            --             globals = { "vim" },
            --         },
            --         completion = {
            --             callSnippet = "Replace"
            --         },
            --         workspace = {
            --             checkThirdParty = false,
            --         }
                -- },
            -- },
        })
       
        -- configure rust
        lspconfig.rust_analyzer.setup({
            diagnostics = {
                enable = false
            },
            capabilities = lsp_capabilities,
        })

        -- configure c/c++
        lspconfig.clangd.setup({
            capabilities = lsp_capabilities,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            single_file_support = true,
        })
    end
}
