return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp-document-symbol",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
        "rafamadriz/friendly-snippets",
        "onsails/lspkind-nvim"
    },
    config = function()
        local cmp = require("cmp")
        local select_opts = { behavior = cmp.SelectBehavior.Select }
        local luasnip = require("luasnip")
        local lspkind = require('lspkind')
        require("luasnip.loaders.from_vscode").lazy_load()
        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            completion = {
                completeopt = "menu, menuone, preview, noselect",
            },

            mapping = cmp.mapping.preset.insert({
                ["<C-k>"] = cmp.mapping.select_prev_item(),
                ["<C-j>"] = cmp.mapping.select_next_item(),
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),

                ['<Tab>'] = cmp.mapping(function(fallback)
                    local col = vim.fn.col('.') - 1

                    if cmp.visible() then
                        cmp.select_next_item(select_opts)
                    elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                        fallback()
                    else
                        cmp.complete()
                    end
                end, { 'i', 's' }),

                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item(select_opts)
                    else
                        fallback()
                    end
                end, { 'i', 's' }),
            }),

            sources = cmp.config.sources({
                { name = "path" },
                { name = "nvim_lsp_signature_help" },
                { name = "nvim_lsp",               keyword_lenght = 1 },
                { name = "luasnip",                keyword_lenght = 2 },
                { name = "buffer",                 keyword_lenght = 3 },
            }),

            window = {
                documentation = cmp.config.window.bordered()
            },

            formatting = {
                expandable_indicator = true,
                fields = { "menu", "abbr", "kind" },
                format = lspkind.cmp_format({
                    mode = 'symbol_text',
                    maxwidth = 50,
                    ellipsis_char = '...',
                    show_labelDetails = true,
                    before = function(entry, vim_item)
                        return vim_item
                    end
                })
            }

        })
        cmp.setup.cmdline('/', {
            sources = cmp.config.sources({
                { name = 'nvim_lsp_document_symbol' }
            }, {
                { name = 'buffer' }
            })
        })
        cmp.setup.cmdline(':', {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources({
                { name = 'path' }
            }, {
                {
                    name = 'cmdline',
                    option = {
                        ignore_cmds = { 'Man', '!' }
                    }
                }
            })
        })
    end,

}
