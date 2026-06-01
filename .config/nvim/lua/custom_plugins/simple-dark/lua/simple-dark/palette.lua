---@class SimpleDarkPalette
---@field bg      string
---@field fg      string
---@field fg_dim  string
---@field keyword string
---@field type    string
---@field string  string
---@field number  string
---@field boolean string
---@field error   string
---@field warn    string
---@field hint    string
---@field info    string

---@class SimpleDarkPaletteOverride
---@field bg?      string
---@field fg?      string
---@field fg_dim?  string
---@field keyword? string
---@field type?    string
---@field string?  string
---@field number?  string
---@field boolean? string
---@field error?   string
---@field warn?    string
---@field hint?    string
---@field info?    string

local M = {}

-- Some colors
-- #1e1e1e
-- #dddddd
-- #aaaaaa
-- #decd09
-- #ffeb3b
-- #f44336
-- #7a9e7a
-- #c4956a
-- #7a9ab5
-- #f290de
-- #d387c0
-- #d8fa3c

---@type SimpleDarkPalette
M.palette = {
    bg      = "#1e1e1e",
    fg      = "#dddddd",
    fg_dim  = "#aaaaaa",
    keyword = "#decd09",
    type    = "#7a9e7a",
    string  = "#dddddd",
    number  = "#dddddd",
    boolean = "#d387c0",

    -- Diagnostics
    error   = "#f44336",
    warn    = "#ffeb3b",
    hint    = "#aaaaaa",
    info    = "#dddddd",
}

---@param palette_override? SimpleDarkPaletteOverride
---@return SimpleDarkPalette
function M.with(palette_override)
    return vim.tbl_extend("force", M.palette, palette_override or {})
end

return M
