return {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                go = {
                    "gci",
                    "gofumpt",
                    "golines",
                },
                bash = {
                    "beautysh",
                    "shfmt"
                },
                c = {
                    "clang-format"
                },
                cpp = {
                    "clang-format"
                },
                rust = {
                    "rustfmt"
                },
                javascript = {
                    "prettier"
                },
                python = {
                    "black"
                }
            },
            format_on_save = function(bufnr)
                -- Disable with a global or buffer-local variable
                if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
                    return
                end
                return { timeout_ms = 500, lsp_format = "fallback" }
            end,
        })

        vim.api.nvim_create_user_command("FormatDisable", function(args)
            if args.bang then
                -- FormatDisable! will disable formatting just for this buffer
                vim.b.disable_autoformat = true
            else
                vim.g.disable_autoformat = true
            end
            print("Auto Format Disabled")
        end, {
            desc = "Disable autoformat-on-save",
            bang = true,
        })

        vim.api.nvim_create_user_command("FormatEnable", function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
            print("Auto Format Enabled")
        end, {
            desc = "Re-enable autoformat-on-save",
        })
    end
}
