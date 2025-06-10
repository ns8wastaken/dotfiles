return {
    'j-hui/fidget.nvim',

    opts = {
        notification = {
            view = {
                group_separator = '---------------------------'
            },
            window = {
                normal_hl = "Float",
                winblend = 0,      -- Opacity = (255 - value)
                border = 'rounded'
            }
        }
    }
}
