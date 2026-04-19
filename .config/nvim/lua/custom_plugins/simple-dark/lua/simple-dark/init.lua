local M = {}

-- Setup opts (override defaults)
---@param opts? SimpleDarkSettingsOverride
---@return SimpleDarkSettings
function M.setup(opts)
    return require("simple-dark.settings").with(opts)
end

---@param opts? SimpleDarkSettingsOverride
function M.load(opts)
    local config = M.setup(opts)

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
