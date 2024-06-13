return {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
        require("mini.comment").setup({
            options = {
                custom_commentstring = function()
                    return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
                end,
                ignore_blank_line = false,
                start_of_line = false,
                pad_comment_parts = true,
            },
            mappings = {
                comment = 'gc',
                comment_line = 'gcc',
                comment_visual = 'gc',
                textobject = 'gc',
            },

            hooks = {
                pre = function() end,
                post = function() end,
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
        require("mini.pairs").setup({
            modes = { insert = true, command = false, terminal = false },
            mappings = {
                ['('] = { action = 'open', pair = '()', neigh_pattern = '[^\\].' },
                ['['] = { action = 'open', pair = '[]', neigh_pattern = '[^\\].' },
                ['{'] = { action = 'open', pair = '{}', neigh_pattern = '[^\\].' },

                [')'] = { action = 'close', pair = '()', neigh_pattern = '[^\\].' },
                [']'] = { action = 'close', pair = '[]', neigh_pattern = '[^\\].' },
                ['}'] = { action = 'close', pair = '{}', neigh_pattern = '[^\\].' },

                ['"'] = { action = 'closeopen', pair = '""', neigh_pattern = '[^\\].', register = { cr = false } },
                ["'"] = { action = 'closeopen', pair = "''", neigh_pattern = '[^%a\\].', register = { cr = false } },
                ['`'] = { action = 'closeopen', pair = '``', neigh_pattern = '[^\\].', register = { cr = false } },
            },
        })
    end
}
