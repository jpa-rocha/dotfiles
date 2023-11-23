return {
    "NeogitOrg/neogit",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",         -- required
        "nvim-telescope/telescope.nvim", -- optional
        "sindrets/diffview.nvim",        -- optional
        "ibhagwan/fzf-lua",              -- optional
    },
    cmd = "Neogit",
    config = function()
        require("neogit").setup({
            disable_hint = true,
            kind = "replace",
            signs = {
                section = { "", "" },
                item = { "", "" },
                hunk = { "", "" },
            },
            integrations = {
                telescope = true,
                diffview = true,
            },
            sections = {
                sequencer = {
                    folded = false,
                    hidden = false,
                },
                untracked = {
                    folded = false,
                    hidden = false,
                },
                unstaged = {
                    folded = false,
                    hidden = false,
                },
                staged = {
                    folded = false,
                    hidden = false,
                },
                stashes = {
                    folded = true,
                    hidden = false,
                },
                unpulled_upstream = {
                    folded = true,
                    hidden = false,
                },
                unmerged_upstream = {
                    folded = false,
                    hidden = false,
                },
                unpulled_pushRemote = {
                    folded = true,
                    hidden = false,
                },
                unmerged_pushRemote = {
                    folded = false,
                    hidden = false,
                },
                recent = {
                    folded = true,
                    hidden = false,
                },
                rebase = {
                    folded = true,
                    hidden = false,
                },
            },
            mappings = {
                finder = {
                    ["<cr>"] = "Select",
                    ["<c-c>"] = "Close",
                    ["<esc>"] = "Close",
                    ["<c-n>"] = "Next",
                    ["<c-p>"] = "Previous",
                    ["<down>"] = "Next",
                    ["<up>"] = "Previous",
                    ["<tab>"] = "MultiselectToggleNext",
                    ["<s-tab>"] = "MultiselectTogglePrevious",
                    ["<c-j>"] = "NOP",
                },
                -- Setting any of these to `false` will disable the mapping.
                popup = {
                    ["?"] = "HelpPopup",
                    ["A"] = "CherryPickPopup",
                    ["D"] = "DiffPopup",
                    ["M"] = "RemotePopup",
                    ["P"] = "PushPopup",
                    ["X"] = "ResetPopup",
                    ["Z"] = "StashPopup",
                    ["b"] = "BranchPopup",
                    ["c"] = "CommitPopup",
                    ["f"] = "FetchPopup",
                    ["l"] = "LogPopup",
                    ["m"] = "MergePopup",
                    ["p"] = "PullPopup",
                    ["r"] = "RebasePopup",
                    ["v"] = "RevertPopup",
                },
                status = {
                    ["q"] = "Close",
                    ["I"] = "InitRepo",
                    ["1"] = "Depth1",
                    ["2"] = "Depth2",
                    ["3"] = "Depth3",
                    ["4"] = "Depth4",
                    ["<tab>"] = "Toggle",
                    ["x"] = "Discard",
                    ["s"] = "Stage",
                    ["S"] = "StageUnstaged",
                    ["<c-s>"] = "StageAll",
                    ["u"] = "Unstage",
                    ["U"] = "UnstageStaged",
                    ["d"] = "DiffAtFile",
                    ["$"] = "CommandHistory",
                    ["#"] = "Console",
                    ["<c-r>"] = "RefreshBuffer",
                    ["<enter>"] = "GoToFile",
                    ["<c-v>"] = "VSplitOpen",
                    ["<c-x>"] = "SplitOpen",
                    ["<c-t>"] = "TabOpen",
                    ["{"] = "GoToPreviousHunkHeader",
                    ["}"] = "GoToNextHunkHeader",
                },
            },
        })
    end,
}
