return  {
    "nvim-neorg/neorg",
    event ="VeryLazy",
    build = ":Neorg sync-parsers",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-treesitter/nvim-treesitter-textobjects",
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("neorg").setup {
            load = {
                ["core.defaults"] = {}, -- Loads default behaviour
                ["core.dirman"] = { -- Manages Neorg workspaces
                    config = {
                        workspaces = {
                            notes = '$HOME/.config/dotfiles' .. "/notes/",
                            journal = '$HOME/.config/dotfiles' .. "/journal/",
                        },
                    },
                },
                ["core.journal"] = {
                    config = {
                        journal_folder = '$HOME/.config/dotfiles/nvim' .. "/journal/",
                        strategy = "nested",
                        -- workspace = journal

                    }
                },
                ["core.completion"] = {
                    config = {
                        engine = "nvim-cmp",
                        name = "[Norg]"
                    }
                },
                ["core.integrations.nvim-cmp"] = {},
                ["core.concealer"] = { config = { icon_preset = "diamond" } },
                ["core.keybinds"] = {
                    config = {
                        default_keybinds = true,
                        neorg_leader = "<Leader><Leader>",
                    },
                },
            },
        }
    end,
}
