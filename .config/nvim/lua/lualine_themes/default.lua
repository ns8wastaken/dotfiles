local diagnostics_with_symbols = require('lualine_themes.diagnostics_symbols')

return {
    options = {
        icons_enabled = true,
        theme = 'wombat',
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = ''},
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        always_divide_middle = true,
        always_show_tabline = true,
        globalstatus = false,
        refresh = { statusline = 100, tabline = 100, winbar = 100, }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' , 'diff', diagnostics_with_symbols },
        lualine_c = {
            {
                'filename',
                path = 1  -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_x = { 'encoding' , 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = { diagnostics_with_symbols },
        lualine_b = {},
        lualine_c = {
            {
                'filename',
                path = 1  -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
        },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    }
}
