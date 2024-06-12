return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
                end,
            },
        })
        require("mini.indentscope").setup({
            draw = {
                delay = 100,
            },
            mappings = {
                object_scope = 'ii',
                object_scope_with_border = 'ai',
                goto_top = '[i',
                goto_bottom = ']i',
            },
            options = {
                border = 'both',
                indent_at_cursor = true,
                try_as_border = false,
            },
            symbol = '│',
        })
        require("mini.move").setup({
            mappings = {
                left = '<M-h>',
                right = '<M-l>',
                down = '<M-j>',
                up = '<M-k>',

                line_left = '<M-h>',
                line_right = '<M-l>',
                line_down = '<M-j>',
                line_up = '<M-k>',
            },
            options = {
                reindent_linewise = true,
            },
        })
    end
}
