return {
    'echasnovski/mini.comment',
    version = false,
    config = function ()
        comment = require("mini.comment")
        comment.setup({
            options = {
                custom_commentstring = function()
                  return require('ts_context_commentstring').calculate_commentstring() or vim.bo.commentstring
                end,
              },
        })
    end
}
