return {
    'nvim-telescope/telescope.nvim',

    dependencies = { 'nvim-lua/plenary.nvim' },

    opts = {
        pickers = {
            colorscheme = {
                enable_preview = true
            },
        },

        defaults = {
            -- winblend = 30,

            layout_config = {
                prompt_position = 'top'
            },

            sorting_strategy = 'ascending'
        }
    }
}
