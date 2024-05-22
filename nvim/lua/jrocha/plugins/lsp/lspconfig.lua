return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "antosha417/nvim-lsp-file-operations", config = true },
    },
    config = function()
        -- import lspconfig plugin

        require("neodev").setup({
          -- add any options here, or leave empty to use the default settings
        })
        local lspconfig = require("lspconfig")
        local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
        local util = require("lspconfig.util")
        ---
        -- Keybindings
        ---
        vim.api.nvim_create_autocmd('LspAttach', {
          desc = 'LSP actions',
          callback = function()
            local bufmap = function(mode, lhs, rhs, desc)
              local opts = {buffer = true, desc = desc}
              vim.keymap.set(mode, lhs, rhs, opts)
            end

            bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', 'Show Implemtation')
            bufmap('n', '<leader>sd', '<cmd>lua vim.lsp.buf.definition()<cr>', 'Show Definition')
            bufmap('n', '<leader>sD', '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Show Declaration')
            bufmap('n', '<leader>si', '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Show Implementation')
            bufmap('n', '<leader>so', '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Show Type')
            bufmap('n', '<leader>sr', '<cmd>lua vim.lsp.buf.references()<cr>', 'Show References')
            bufmap('n', '<leader>sg', '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Show Signature')
            bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename')
            bufmap('n', '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', 'Format')
            bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Show Code Actions')
            bufmap('n', '<leader>sL', '<cmd>Telescope diagnostics<cr>', 'Show Page Diagnostics')
            bufmap('n', '<leader>sl', '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show Diagnostics')
            bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous Diagnostic')
            bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next Diagnostic')
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

        -- For Templ`:w
        -- `
        vim.filetype.add({
         extension = {
          templ = "templ",
         },
        })
        vim.api.nvim_create_autocmd({
            "BufWritePre"
          },
          {
            pattern = {"*.templ"},
            callback = function()
              vim.lsp.buf.format()
            end,
          }
        )

        lspconfig.gopls.setup({
            capabilities = lsp_capabilities,
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                        unusedvariable = true
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
                golintci_lint = true,
            },
            filetypes = { "go", "templ"},
            root_dir = util.root_pattern("go.work", "go.mod", ".git")
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
            capabilities = lsp_capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = {'vim'}
                    },
                    workspace = {
                        checkThirdParty = true,
                    }
                }
            },
        })

        -- configure ts & js
        lspconfig.tsserver.setup({
            capabilities = lsp_capabilities,
        })

        -- configure rust
        lspconfig.rust_analyzer.setup({
            capabilities = lsp_capabilities,
            settings = {
                ["rust-analyzer"] = {
                    imports = {
                        granularity = {
                            group = "module",
                        },
                        prefix = "self",
                    },
                    cargo = {
                        buildScripts = {
                            enable = true,
                        },
                    },
                    procMacro = {
                        enable = true
                    },
                },
            },
        })

        -- configure c/c++
        lspconfig.clangd.setup({
            capabilities = lsp_capabilities,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            single_file_support = true,
        })

        lspconfig.templ.setup({
            capabilities = lsp_capabilities
        })

        lspconfig.dockerls.setup({
            capabilities = lsp_capabilities
        })

        lspconfig.docker_compose_language_service.setup({
            capabilities = lsp_capabilities
        })
        lspconfig.pyright.setup({
            capabilities = lsp_capabilities,
            cmd = { "pyright-langserver", "--stdio" },
            filetypes = {"python"},
            settings = {
                python = {
                    analysis = {
                        autoSearchPaths = true,
                        diagnosticMode = "openFilesOnly",
                        useLibraryCodeForTypes = true
                    }
                }
            },
            single_file_support = true
        })
    end
}
