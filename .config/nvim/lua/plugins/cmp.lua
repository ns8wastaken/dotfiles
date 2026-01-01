return {
    "hrsh7th/nvim-cmp",

    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "onsails/lspkind.nvim"
    },

    config = function()
        local cmp = require("cmp")

        cmp.setup({
            preselect = cmp.PreselectMode.Item,

            experimental = {
                ghost_text = true
            },

            completion = {
                completeopt = "menu,menuone,noinsert"
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },

            mapping = cmp.mapping.preset.insert({
                ["<Tab>"]   = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<C-y>"]   = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete()
            }),

            formatting = {
                format = require("lspkind").cmp_format({
                    mode = "symbol_text",
                    maxwidth = 100,

                    ellipsis_char = "...",

                    symbol_map = {
                        Text = "󰉿",
                        Method = "󰆧",
                        Function = "󰊕",
                        Constructor = "",
                        Field = "󰜢",
                        Variable = "󰀫",
                        Class = "󰠱",
                        Interface = "",
                        Module = "",
                        Property = "󰜢",
                        Unit = "󰑭",
                        Value = "󰎠",
                        Enum = "",
                        Keyword = "󰌋",
                        Snippet = "",
                        Color = "󰏘",
                        File = "󰈙",
                        Reference = "󰈇",
                        Folder = "󰉋",
                        EnumMember = "",
                        Constant = "󰏿",
                        Struct = "󰙅",
                        Event = "",
                        Operator = "󰆕",
                        TypeParameter = ""
                    }
                })
            },

            sources = {
                { name = "nvim_lsp" },
                { name = "luasnip" }
            }
        })
    end
}
