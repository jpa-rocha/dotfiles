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
                    "goimports",
                    "golines",
                    "gomodifytags"
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
            -- format_on_save = {
            --     lsp_fallback = true,
            --     async = false,
            --     timeout_ms = 500,
            -- },
        })

        vim.keymap.set({ "n", "v" }, "<leader>F", function()
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end, { desc = "Format File/Range" })
    end,
}
