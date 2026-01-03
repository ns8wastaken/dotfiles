-- Enable syntax highlighting and filetype detection
vim.cmd("syntax on")
vim.cmd("filetype plugin indent on")

require("options")

require("config.globals")
require("config.lazy") -- Load plugins or something
require("config.autocmds")
require("config.filetypes")
require("config.keymaps")
vim.g.require_dir("config.keymaps")

vim.g.load_colorscheme()

vim.notify = require("notify")

local ll_themes = vim.g.require_dir_table(
    "lualine_themes",
    { diagnostics_symbols = true }
)

require("lualine").setup(ll_themes.better_bubble)
require("lualine").setup({
    refresh = {
        -- statusline = 250,
        -- tabline = 250,
        -- winbar = 250,
        refresh_time = 16 -- ~60 fps
    },

    -- options = { theme = 'gruvbox-material' }
})

require("lsp")
