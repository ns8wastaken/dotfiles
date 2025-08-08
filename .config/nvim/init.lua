-- Enable syntax highlighting and filetype detection
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

require('filetypes')
require('options')
require('globals')

require('config.lazy') -- Load plugins or something

vim.g.load_colorscheme()

vim.notify = require('notify')

local ll_themes = {
    default = require('lualine_themes.default'),
    bubbles = require('lualine_themes.bubble'),
    slanted = require('lualine_themes.slanted')
}
require('lualine').setup(ll_themes.slanted)
require('lualine').setup({
    refresh = {
        statusline = 250,
        tabline = 250,
        winbar = 250,
        refresh_time = 16 -- ~60 fps
    }
})
-- require('lualine').setup({ options = { theme = 'gruvbox-material' } })

require('keymaps.telescope')
require('keymaps.vim-easy-align')
require('mappings') -- Default stuff but fancy keybinds
require('lsp')
require('autocmds')
