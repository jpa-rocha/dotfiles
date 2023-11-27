return {
    'JoosepAlviste/nvim-ts-context-commentstring',
    context_config = function()
        require('ts_context_commentstring').setup {
            enable_autocmd = false,
        }
    end
}
