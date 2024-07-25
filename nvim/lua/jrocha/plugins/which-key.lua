return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
        local wk = require("which-key")
        vim.o.timeout = true
        vim.o.timeoutlen = 100

        local search_and_replace = function()
            local search_pattern = vim.fn.input("Search: ")
            vim.cmd(string.format("execute '/%s'", search_pattern))
            vim.fn.feedkeys("cgn")
        end

        local format_region = function()
            local conform = require("conform")
            conform.format({
                lsp_fallback = true,
                async = false,
                timeout_ms = 500,
            })
        end

        wk.add({
            { "<leader>F",  group = "Formating" },
            { "<leader>Fd", "<cmd>FormatDisable<cr>",                                               desc = "Disable Formating on Save" },
            { "<leader>Fe", "<cmd>FormatEnable<cr>",                                                desc = "Enable Formating on Save" },
            { "<leader>G",  group = "Go Commands" },
            { "<leader>GD", "<cmd>GoDbgStop<cr>",                                                   desc = "Stop Debugger" },
            { "<leader>Ga", "<cmd>GoAddTag<cr>",                                                    desc = "Add JSON Tags" },
            { "<leader>Gd", "<cmd>GoDebug<cr>",                                                     desc = "Launch Debugger" },
            { "<leader>Ge", "<cmd>GoIfErr<cr>",                                                     desc = "Add Error check" },
            { "<leader>Gf", "<cmd>GoFillStruct<cr>",                                                desc = "Fill Struct" },
            { "<leader>Gk", "<cmd>GoDbgKeys<cr>",                                                   desc = "Show Debuger Keys" },
            { "<leader>Gn", "<cmd>GoRename<cr>",                                                    desc = "Rename Object" },
            { "<leader>Gr", "<cmd>GoRmTag<cr>",                                                     desc = "Remove JSON Tags" },
            { "<leader>Gs", "<cmd>GoAltV!<cr>",                                                     desc = "Check Test File" },
            { "<leader>Gt", "<cmd>GoTest<cr>",                                                      desc = "go test" },
            { "<leader>Gv", "<cmd>GoModVendor<cr>",                                                 desc = "go mod vendor" },
            { "<leader>J",  "<cmd>Journal<cr>",                                                     desc = "Journal" },
            { "<leader>L",  "<cmd>Lazy<cr>",                                                        desc = "Lazy" },
            { "<leader>M",  "<cmd>Mason<cr>",                                                       desc = "Mason" },
            { "<leader>b",  group = "Buffer Management" },
            { "<leader>bh", "<cmd>BufferPrevious<cr>",                                              desc = "Previous Buffer" },
            { "<leader>bl", "<cmd>BufferNext<cr>",                                                  desc = "Next Buffer" },
            { "<leader>bo", "<cmd>BufferCloseAllButCurrent<cr>",                                    desc = "Close Other Buffers" },
            { "<leader>bx", "<cmd>BufferClose<cr>",                                                 desc = "Close Buffer" },
            { "<leader>d",  search_and_replace,                                                     desc = "Search & Replace" },
            { "<leader>f",  group = "Telescope" },
            { "<leader>fC", "<cmd>Telescope colorscheme<cr>",                                       desc = "Find Colorschemes" },
            { "<leader>fT", "<cmd>Telescope<cr>",                                                   desc = "Telescope Commands" },
            { "<leader>fb", "<cmd>Telescope file_browser<cr>",                                      desc = "File Browser" },
            { "<leader>fc", "<cmd>Telescope grep_string<cr>",                                       desc = "Find String Under Cursor" },
            { "<leader>ff", "<cmd>Telescope find_files<cr>",                                        desc = "Find File" },
            { "<leader>fh", "<cmd>Telescope current_buffer_fuzzy_find<cr>",                         desc = "Find in Current Buffer" },
            { "<leader>fk", "<cmd>Telescope keymaps<cr>",                                           desc = "Show Keymaps" },
            { "<leader>fm", "<cmd>Telescope commands<cr>",                                          desc = "Find Commands" },
            { "<leader>fr", "<cmd>Telescope oldfiles<cr>",                                          desc = "Open Recent File" },
            { "<leader>fs", "<cmd>Telescope live_grep<cr>",                                         desc = "Find String in CWD" },
            { "<leader>ft", "<cmd>TodoTelescope<cr>",                                               desc = "Find TODO's" },
            { "<leader>l",  group = "LSP" },
            { "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>",                               desc = "Show Declaration" },
            { "<leader>lL", "<cmd>Telescope diagnostics<cr>",                                       desc = "Show Page Diagnostics" },
            { "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>",                                desc = "Show Definition" },
            { "<leader>lg", "<cmd>lua vim.lsp.buf.signature_help()<cr>",                            desc = "Show Signature" },
            { "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>",                            desc = "Show Implementation" },
            { "<leader>ll", "<cmd>lua vim.diagnostic.open_float()<cr>",                             desc = "Show Diagnostics" },
            { "<leader>lo", "<cmd>lua vim.lsp.buf.type_definition()<cr>",                           desc = "Show Type" },
            { "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>",                                desc = "Show References" },
            { "<leader>ls", "<cmd>Telescope lsp_document_symbols<cr>",                              desc = "Show Document Symbols" },
            { "<leader>s",  group = "Specter" },
            { "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', desc = "Search Current File" },
            { "<leader>ss", '<cmd>lua require("spectre").toggle()<cr>',                             desc = "Toggle Specter" },
            { "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<cr>',      desc = "Select Current Word" },
            { "<leader>t",  "<cmd>ToggleTerm<cr>",                                                  desc = "Toggle Term" },
            { "<leader>v",  group = "Git" },
            { "<leader>vR", "<cmd>Gitsigns reset_buffer<cr>",                                       desc = "Revert Buffer" },
            { "<leader>vS", "<cmd>Gitsigns stage_hunk<cr>",                                         desc = "Stage Hunk " },
            { "<leader>vb", "<cmd>Gitsigns blame_line<cr>",                                         desc = "Blame Line" },
            { "<leader>vg", "<cmd>Neogit<cr>",                                                      desc = "NeoGit" },
            { "<leader>vn", "<cmd>Gitsigns next_hunk<cr>",                                          desc = "Next Hunk" },
            { "<leader>vp", "<cmd>Gitsigns prev_hunk<cr>",                                          desc = "Previous Hunk" },
            { "<leader>vr", "<cmd>Gitsigns reset_hunk<cr>",                                         desc = "Revert Hunk " },
            { "<leader>vs", "<cmd>Gitsigns preview_hunk<cr>",                                       desc = "Preview Hunk " },
            { "<leader>Ff", format_region,                                                          desc = "Format Region",            mode = { "n", "v" } },
        })
    end,
}
