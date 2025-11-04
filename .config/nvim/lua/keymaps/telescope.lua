local map_set = vim.keymap.set

local telescope = require('telescope');
map_set('n', '<Leader>fb', function()
    telescope.extensions.file_browser.file_browser({
        grouped = true,
        hidden = true
    })
end, vim.g.keymap_opts)

local telescope_builtin = require('telescope.builtin')
map_set('n', '<Leader>ff', telescope_builtin.find_files,  vim.g.keymap_opts)
map_set('n', '<leader>fg', telescope_builtin.live_grep,   vim.g.keymap_opts)
map_set('n', '<Leader>km', telescope_builtin.keymaps,     vim.g.keymap_opts)
map_set('n', '<Leader>cs', telescope_builtin.colorscheme, vim.g.keymap_opts)
