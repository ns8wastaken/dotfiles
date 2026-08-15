local M = {}

M.config = {}

---@param opts? SimpleDarkSettingsOverride
function M.setup(opts)
    -- Store the user's opts globally so the colorscheme can find them later
    M.config = opts or {}
end

---@param opts? SimpleDarkSettingsOverride
function M.load(opts)
    -- Use provided opts if present, otherwise fall back to the stored M.config
    local current_opts = opts or M.config
    local config = require("simple-dark.settings").with(current_opts)

    vim.api.nvim_command("hi clear")
    if vim.fn.exists("syntax_on") == 1 then
        vim.api.nvim_command("syntax reset")
    end

    vim.o.background = "dark"
    vim.o.termguicolors = true
    vim.g.colors_name = "simple-dark"

    local files = vim.api.nvim_get_runtime_file("lua/simple-dark/highlights/*.lua", true)

    for _, path in ipairs(files) do
        local hl_func = dofile(path)

        if type(hl_func) == "function" then
            local highlights = hl_func(config.palette)
            for name, props in pairs(highlights) do
                vim.api.nvim_set_hl(0, name, props)
            end
        end
    end

    for name, props in pairs(config.overrides) do
        vim.api.nvim_set_hl(0, name, props)
    end
end

return M
