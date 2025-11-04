-- Enable syntax highlighting and filetype detection
vim.cmd('syntax on')
vim.cmd('filetype plugin indent on')

require('filetypes')
require('options')
require('globals')

require('config.lazy') -- Load plugins or something

vim.g.load_colorscheme()

vim.notify = require('notify')

local theme_path = vim.fn.stdpath('config') .. '/lua/lualine_themes/'
local ll_themes = {}

-- Load the lualine themes
for _, file in ipairs(vim.split(vim.fn.globpath(theme_path, '*.lua'), '\n')) do
    local filename = vim.fn.fnamemodify(file, ':t')
    if filename ~= "diagnostics_symbols.lua" then
        local name = filename:sub(1, -5)
        ll_themes[name] = require('lualine_themes.' .. name)
    end
end

require('lualine').setup(ll_themes.better_bubble)
require('lualine').setup({
    refresh = {
        -- statusline = 250,
        -- tabline = 250,
        -- winbar = 250,
        refresh_time = 16 -- ~60 fps
    }
})
-- require('lualine').setup({ options = { theme = 'gruvbox-material' } })

require('keymaps.telescope')
require('keymaps.vim-easy-align')
require('mappings') -- Default stuff but fancy keybinds
require('lsp')
require('autocmds')
