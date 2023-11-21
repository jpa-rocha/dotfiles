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

        -- import cmp-nvim-lsp plugin
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local keymap = vim.keymap -- for conciseness

        local opts = { noremap = true, silent = true }
        local on_attach = function(client, bufnr)
            opts.buffer = bufnr

            -- set keybinds
            opts.desc = "Show LSP references"
            keymap.set("n", "<leader>sr", "<cmd>Telescope lsp_references<CR>", opts) -- show definition, references

            opts.desc = "Go to declaration"
            keymap.set("n", "<leader>sD", vim.lsp.buf.declaration, opts) -- go to declaration

            opts.desc = "Show LSP definitions"
            keymap.set("n", "<leader>sd", "<cmd>Telescope lsp_definitions<CR>", opts) -- show lsp definitions

            opts.desc = "Show LSP implementations"
            keymap.set("n", "<leader>si", "<cmd>Telescope lsp_implementations<CR>", opts) -- show lsp implementations

            opts.desc = "Show LSP type definitions"
            keymap.set("n", "<leader>st", "<cmd>Telescope lsp_type_definitions<CR>", opts) -- show lsp type definitions

            opts.desc = "See available code actions"
            keymap.set({ "n", "v" }, "<leader>sa", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

            opts.desc = "Smart rename"
            keymap.set("n", "<leader>sn", vim.lsp.buf.rename, opts) -- smart rename

            opts.desc = "Show buffer diagnostics"
            keymap.set("n", "<leader>sb", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

            opts.desc = "Show line diagnostics"
            keymap.set("n", "<leader>sl", vim.diagnostic.open_float, opts) -- show diagnostics for line

            opts.desc = "Go to previous diagnostic"
            keymap.set("n", "[d", vim.diagnostic.goto_prev, opts) -- jump to previous diagnostic in buffer

            opts.desc = "Go to next diagnostic"
            keymap.set("n", "]d", vim.diagnostic.goto_next, opts) -- jump to next diagnostic in buffer

            opts.desc = "Show documentation for what is under cursor"
            keymap.set("n", "K", vim.lsp.buf.hover, opts) -- show documentation for what is under cursor

            opts.desc = "Restart LSP"
            keymap.set("n", "<leader>sa", ":LspRestart<CR>", opts) -- mapping to restart lsp if necessary
        end

        -- used to enable autocompletion (assign to every lsp server config)
        local capabilities = cmp_nvim_lsp.default_capabilities()
        -- Change the Diagnostic symbols in the sign column (gutter)
        -- (not in youtube nvim video)
        local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        lspconfig["gopls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
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
        lspconfig["html"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure css
        lspconfig["cssls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure bash
        lspconfig["bashls"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = {
                bashIde = {
                    globPattern = "*@(.sh|.inc|.bash|.command)"
                }
            }
        })
        -- configure lua
        lspconfig["lua_ls"].setup({
            on_init = function(client)
                local path = client.workspace_folders[1].name
                if not vim.loop.fs_stat(path..'/.luarc.json') and not vim.loop.fs_stat(path..'/.luarc.jsonc') then
                client.config.settings = vim.tbl_deep_extend('force', client.config.settings, {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
                        runtime = {
                            version = 'LuaJIT'
                        },
                        workspace = {
                        checkThirdParty = false,
                            library = {
                                  vim.env.VIMRUNTIME
                            }
                        }
                    }
                })
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
            return true
            end
        })

        -- configure rust
        lspconfig["rust_analyzer"].setup({
            diagnostics = {
                enable = false
            },
            capabilities = capabilities,
            on_attach = on_attach,
        })

        -- configure c/c++
        lspconfig["clangd"].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
            single_file_support = true,
        })
    end
}
