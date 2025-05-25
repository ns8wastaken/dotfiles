return {
    'nvim-telescope/telescope.nvim',

    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
        defaults = {
            winblend = 30,

            layout_config = {
                prompt_position = 'top'
            },

            sorting_strategy = 'ascending'
        }
    }
}
