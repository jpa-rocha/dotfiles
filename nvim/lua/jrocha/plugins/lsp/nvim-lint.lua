return {
    "mfussenegger/nvim-lint",
    event = {
        "bufreadpre",
        "bufnewfile",
        "insertleave"
    },
    config = function()
        local lint = require("lint")
        lint.linters_by_ft = {
            go = { "golangcilint" },
            css = { "stylelint" },
            scss = { "stylelint" },
            sass = { "stylelint" },
            bash = { "shellharden" },
            dockerfile = { "hadolint" },
            python = { "ruff" }
            -- javascript = { "eslint_d" }
        }
        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
        vim.api.nvim_create_autocmd({ "bufenter", "bufwritepost", "insertleave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })

    end,
}
