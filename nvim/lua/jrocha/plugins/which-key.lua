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
        wk.register({
            ["<leader>"] = {
                b = {
                    name = "Buffer Management",
                    h = { "<cmd>BufferPrevious<cr>", "Previous Buffer" },
                    l = { "<cmd>BufferNext<cr>", "Next Buffer" },
                    x = { "<cmd>BufferClose<cr>", "Close Buffer" },
                    o = { "<cmd>BufferCloseAllButCurrent<cr>", "Close Other Buffers" },
                },
                d = { search_and_replace, "Search & Replace" },
                f = {
                    name = "Telescope",
                    b = { "<cmd>Telescope file_browser<cr>", "File Browser" },
                    c = { "<cmd>Telescope grep_string<cr>", "Find String Under Cursor" },
                    C = { "<cmd>Telescope colorscheme<cr>", "Find Colorschemes" },
                    f = { "<cmd>Telescope find_files<cr>", "Find File" },
                    h = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Find in Current Buffer" },
                    k = { "<cmd>Telescope keymaps<cr>", "Show Keymaps" },
                    m = { "<cmd>Telescope commands<cr>", "Find Commands" },
                    r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
                    s = { "<cmd>Telescope live_grep<cr>", "Find String in CWD" },
                    t = { "<cmd>TodoTelescope<cr>", "Find TODO's" },
                    T = { "<cmd>Telescope<cr>", "Telescope Commands" }
                },
                F = {
                    name = "Formating",
                    d = { "<cmd>FormatDisable<cr>", "Disable Formating on Save" },
                    e = { "<cmd>FormatEnable<cr>", "Enable Formating on Save" },
                    f = { format_region, "Format Region", mode = { "n", "v" } },
                },
                G = {
                    name = "Go Commands",
                    a = { "<cmd>GoAddTag<cr>", "Add JSON Tags" },
                    d = { "<cmd>GoDebug<cr>", "Launch Debugger" },
                    D = { "<cmd>GoDbgStop<cr>", "Stop Debugger" },
                    k = { "<cmd>GoDbgKeys<cr>", "Show Debuger Keys" },
                    e = { "<cmd>GoIfErr<cr>", "Add Error check" },
                    f = { "<cmd>GoFillStruct<cr>", "Fill Struct" },
                    n = { "<cmd>GoRename<cr>", "Rename Object" },
                    r = { "<cmd>GoRmTag<cr>", "Remove JSON Tags" },
                    s = { "<cmd>GoAltV!<cr>", "Check Test File" },
                    t = { "<cmd>GoTest<cr>", "go test" },
                    v = { "<cmd>GoModVendor<cr>", "go mod vendor" },
                },
                J = { "<cmd>Journal<cr>", "Journal" },
                l = {
                    name = "LSP",
                    s = { "<cmd>Telescope lsp_document_symbols<cr>", "Show Document Symbols" },
                    d = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Show Definition' },
                    D = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Show Declaration' },
                    i = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Show Implementation' },
                    o = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Show Type' },
                    r = { '<cmd>lua vim.lsp.buf.references()<cr>', 'Show References' },
                    g = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Show Signature' },
                    L = { '<cmd>Telescope diagnostics<cr>', 'Show Page Diagnostics' },
                    l = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Show Diagnostics' },
                },
                L = { "<cmd>Lazy<cr>", "Lazy" },
                M = { "<cmd>Mason<cr>", "Mason" },
                s = {
                    name = "Specter",
                    s = { '<cmd>lua require("spectre").toggle()<cr>', "Toggle Specter" },
                    w = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', "Select Current Word" },
                    p = { '<cmd>lua require("spectre").open_file_search({select_word=true})<cr>', "Search Current File" }
                },
                t = { "<cmd>ToggleTerm<cr>", "Toggle Term" },
                v = {
                    name = "Git",
                    g = { "<cmd>Neogit<cr>", "NeoGit" },
                    p = { "<cmd>Gitsigns prev_hunk<cr>", "Previous Hunk" },
                    n = { "<cmd>Gitsigns next_hunk<cr>", "Next Hunk" },
                    s = { "<cmd>Gitsigns preview_hunk<cr>", "Preview Hunk " },
                    S = { "<cmd>Gitsigns stage_hunk<cr>", "Stage Hunk " },
                    r = { "<cmd>Gitsigns reset_hunk<cr>", "Revert Hunk " },
                    R = { "<cmd>Gitsigns reset_buffer<cr>", "Revert Buffer" },
                    b = { "<cmd>Gitsigns blame_line<cr>", "Blame Line" },
                },
            },
        })
    end,
}
