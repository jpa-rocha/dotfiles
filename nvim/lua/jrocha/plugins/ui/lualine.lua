return {
    'nvim-lualine/lualine.nvim', -- plugin to install
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function () -- the configuration code
        local lualine = require('lualine')
		local lazy_status = require("lazy.status")
        lualine.setup({
            options = {
                icons_enabled = true,
                theme = 'auto',
            },
          sections = {
                lualine_x = {
                    {
                        lazy_status.updates,
                        cond = lazy_status.has_updates,
                    },
                    {"encoding"},
                    {"fileformat"},
                    {"filename"},
                }, -- Corrected placement of the closing parenthesis
            },
        })
    end
}
