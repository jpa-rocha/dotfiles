return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require "which-key"
        vim.o.timeout = true
        vim.o.timeoutlen = 100

        local search_and_replace = function()
            local search_pattern = vim.fn.input("Search: ")
            vim.cmd(string.format("execute '/%s'", search_pattern))
            vim.fn.feedkeys("cgn")
        end

        wk.register({
            ["<leader>"] = {
                b = {
                    name = "Buffer Management",
                    h = { "<cmd>BufferPrevious<cr>", "Previous Buffer"},
                    l = { "<cmd>BufferNext<cr>", "Next Buffer"},
                    x = { "<cmd>BufferClose<cr>", "Close Buffer"},
                    o = { "<cmd>BufferCloseAllButCurrent<cr>", "Close Other Buffers"},
                },
                d = { search_and_replace, "Search & Replace" },
                f = {
                    name = "Telescope",
                    b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
                    c = { "<cmd>Telescope grep_string<cr>", "Find String Under Cursor" },
                    f = { "<cmd>Telescope find_files<cr>", "Find File" },
                    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                    s = { "<cmd>Telescope live_grep<cr>", "Find String in CWD" },
                    t = { "<cmd>TodoTelescope<cr>", "Find TODO's" },
                    m = { "<cmd>Telescope commands<cr>", "Find Commands" },
                    C = { "<cmd>Telescope colorscheme<cr>", "Find Colorschemes" }
                },
                G = {
                    name ="Git",
                    g = { "<cmd>Neogit<cr>", "NeoGit" },
                    p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
                    n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
                    s = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk " },
                    S = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk " },
                    r = { "<cmd>Gitsigns reset_hunk<cr>", "Revert Hunk " },
                    R = { "<cmd>Gitsigns reset_buffer<cr>", "Revert Buffer" },
                    b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
                },
                g = {
                    name = "Go Commands",
                    a = { "<cmd>GoAddTag<cr>", "Add JSON Tags"},
                    r = { "<cmd>GoRmTag<cr>", "Remove JSON Tags"},
                    e = { "<cmd>GoIfErr<cr>", "Add Error check"},
                    f = { "<cmd>GoFillStruct<cr>", "Fill Struct"},
                    t = { "<cmd>GoTest<cr>", "go test"},
                    v = { "<cmd>GoModVendor<cr>", "go mod vendor"},
                    s = { "<cmd>GoAltV!<cr>", "Check Test File"},
                    n = { "<cmd>GoRename<cr>", "Rename Object"}
                },
                L = { "<cmd>Lazy<cr>" , "Lazy"},
                M = { "<cmd>Mason<cr>", "Mason" },
                N = { "<cmd>Neorg<cr>", "Neorg" },
                s = {
                    name = "LSP",
                    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Show Document Symbols" }
                },
            },
        })
    end,
}
