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

-- Load the lualine themes
-- for _, file in ipairs(vim.split(vim.fn.globpath(theme_path, "*.lua"), '\n')) do
--     local filename = vim.fn.fnamemodify(file, ":t")
--     if filename ~= "diagnostics_symbols.lua" then
--         local name = filename:sub(1, -5)
--         ll_themes[name] = require("lualine_themes." .. name)
--     end
-- end

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
