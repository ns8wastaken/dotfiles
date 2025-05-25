return {
    'hrsh7th/nvim-cmp',

    dependencies = { 'hrsh7th/cmp-nvim-lsp' },

    config = function()
        local cmp = require('cmp')

        cmp.setup({
            preselect = cmp.PreselectMode.Item,

            completion = {
                completeopt = 'menu,menuone,noinsert',
            },

            window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered()
            },

            mapping = cmp.mapping.preset.insert({
                ['<Tab>']   = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-y>']   = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete()
            }),

            sources = { { name = 'nvim_lsp' } }
        })
    end
}
