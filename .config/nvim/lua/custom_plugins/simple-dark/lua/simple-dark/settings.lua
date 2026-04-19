---@class SimpleDarkSettings
---@field palette   SimpleDarkPaletteOverride
---@field overrides table<string, table>

---@class SimpleDarkSettingsOverride
---@field palette?   SimpleDarkPaletteOverride
---@field overrides? table<string, table>

local M = {}

---@param opts? SimpleDarkSettingsOverride
---@return SimpleDarkSettings
function M.with(opts)
    opts = opts or {}

    -- Overwrite palette
    local palette = require("simple-dark.palette").with(opts.palette)

    return {
        palette = palette,
        overrides = opts.overrides or {},
    }
end

return M
