return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        require("nvim-treesitter.configs").setup {
            highlight = { enable = true },
            indent = { enable = true },
            ensure_installed = {
                "c",
                "lua",
                "rust",
                "go",
                "javascript",
                "typescript",
                "bash",
                "html",
                "markdown",
                "dockerfile",
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },
        }
    end
}
