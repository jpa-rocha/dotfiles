return {
    "williamboman/mason.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        -- import mason
        local mason = require("mason")

        -- import mason-lspconfig
        local mason_lspconfig = require("mason-lspconfig")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_lspconfig.setup({
            -- list of servers for mason to install
            ensure_installed = {
                "gopls",
                "lua_ls",
                "html",
                "cssls",
                "bashls",
                "rust_analyzer",
                "clangd",
                "tsserver",
                "templ",
                "dockerls",
                "docker_compose_language_service",
                "pyright",
                "taplo",
                "earthlyls"
            },
            -- auto-install configured servers (with lspconfig)
            automatic_installation = true, -- not the same as ensure_installed
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "stylua",
                "stylelint",
                "delve",
                "golangci-lint",
                "gci",
                "gofumpt",
                "goimports",
                "golines",
                "gomodifytags",
                "beautysh",
                "shellharden",
                "shfmt",
                "clang-format",
                "prettier",
                "eslint_d",
                "hadolint",
                "ruff",
                "black",
                "selene"
            },
        })
    end,
}
