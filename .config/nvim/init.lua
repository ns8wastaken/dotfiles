-- Enable syntax highlighting and filetype detection
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

require('options')
require('globals')

require('config.lazy') -- Load plugins or something

vim.g.load_colorscheme()

vim.notify = require('notify')

local ll_themes = {
    default = require('lualine_themes.default'),
    bubbles = require('lualine_themes.bubble'),
}
require('lualine').setup(ll_themes.default)
-- require('lualine').setup({ options = { theme = 'gruvbox-material' } })

require('keymaps.telescope')
require('keymaps.vim-easy-align')
require('mappings') -- Default stuff but fancy keybinds
require('lsp')
require('autocmds')
