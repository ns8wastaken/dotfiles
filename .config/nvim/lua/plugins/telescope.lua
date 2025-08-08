local M = {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {}
}

local layout_strats = require('telescope.pickers.layout_strategies')

layout_strats.horizontal_merged = function(picker, max_columns, max_lines, layout_config)
    local layout = layout_strats.horizontal(picker, max_columns, max_lines, layout_config)

    layout.prompt.title = ''
    -- layout.prompt.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
    layout.prompt.borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

    layout.results.title = ''
    -- layout.results.borderchars = { '─', '│', '─', '│', '├', '┤', '┘', '└' }
    layout.results.borderchars = { '─', '│', '─', '│', '├', '┤', '╯', '╰' }
    layout.results.line = layout.results.line - 1
    layout.results.height = layout.results.height + 1

    -- layout.preview.title = ''
    -- layout.preview.borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' }
    -- layout.preview.borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }

    return layout
end

local actions = require('telescope.actions')

M.opts = {
    pickers = {
        colorscheme = {
            enable_preview = true
        },
    },

    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close
            }
        },

        layout_strategy = 'horizontal_merged',

        sorting_strategy = 'ascending',

        layout_config = {
            prompt_position = 'top',
            -- width = { padding = 0 },
            -- height = { padding = 0 },
            -- preview_width = 0.5
        }
    }
}

return M
