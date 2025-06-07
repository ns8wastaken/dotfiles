local map_set = vim.keymap.set

local telescope = require('telescope');
map_set('n', '<Leader>fb', telescope.extensions.file_browser.file_browser, keymap_opts)

telescope_builtin = require('telescope.builtin')
map_set('n', '<Leader>ff', telescope_builtin.find_files,  keymap_opts)
map_set('n', '<leader>fg', telescope_builtin.live_grep,   keymap_opts)
map_set('n', '<Leader>km', telescope_builtin.keymaps,     keymap_opts)
map_set('n', '<Leader>cs', telescope_builtin.colorscheme, keymap_opts)
