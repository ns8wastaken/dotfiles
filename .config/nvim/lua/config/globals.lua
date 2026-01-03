-- Custom ternary function because lua doesn't have ternary operators :(
vim.g.ternary = function(condition, val_true, val_false)
    if condition then
        return val_true
    else
        return val_false
    end
end

local colorscheme_file = vim.fn.stdpath("config") .. "/colorscheme.txt"

vim.g.save_colorscheme = function()
    local f = io.open(colorscheme_file, "w")

    if f then
        f:write(vim.g.colors_name)
        f:close()
    end
end

vim.g.load_colorscheme = function()
    local f = io.open(colorscheme_file, 'r')

    if f then
        local name = f:read("*l")
        f:close()
        if name and #name > 0 then
            vim.cmd("colorscheme " .. name)
        end
    else
        -- Fallback colorscheme
        vim.cmd("colorscheme desert")
    end
end

vim.g.require_dir = function(module_dir)
    local lua_root = vim.fn.stdpath("config") .. "/lua/"
    local fs_dir = module_dir:gsub("%.", "/")
    local path = lua_root .. fs_dir

    for _, file in ipairs(vim.fn.globpath(path, "*.lua", false, true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")
        require(module_dir .. "." .. name)
    end
end

---@param module_dir string
---@param ignore? table<string, true> -- set of module names to ignore
---@return table<string, any>?
vim.g.require_dir_table = function(module_dir, ignore)
    local modules = {}

    if module_dir == nil then
        return nil
    end

    local _ignore = ignore or {}

    local lua_root = vim.fn.stdpath("config") .. "/lua/"
    local fs_dir = module_dir:gsub("%.", "/")
    local path = lua_root .. fs_dir

    for _, file in ipairs(vim.fn.globpath(path, "*.lua", false, true)) do
        local name = vim.fn.fnamemodify(file, ":t:r")

        if not _ignore[name] then
            modules[name] = require(module_dir .. "." .. name)
        end
    end

    return modules
end

vim.g.keymap_opts = { noremap = true, silent = true }

-- Make floating window borders rounded
vim.o.winborder = "rounded"

-- Set OS
local sysname = vim.loop.os_uname().sysname
vim.g.is_windows = sysname == "Windows_NT"
vim.g.is_linux   = sysname == "Linux"
vim.g.is_mac     = sysname == "Darwin"

vim.o.shell = vim.g.ternary(vim.g.is_windows, "powershell -NoLogo", "fish")

-- Set the <Leader> char
vim.g.mapleader = ','

-- Gruvbox theme settings ('soft', 'medium', 'hard')
vim.g.gruvbox_material_background = "medium"
vim.g.gruvbox_material_foreground = "medium"


-- Neovide

-- Railgun particle effect on cursor jump
vim.g.neovide_cursor_vfx_mode = ""
vim.g.neovide_cursor_vfx_particle_density = 3.0
vim.g.neovide_cursor_vfx_particle_phase = 2.5
vim.g.neovide_cursor_vfx_opacity = 200.0

-- vim.g.neovide_cursor_animation_length = 0.075
vim.g.neovide_cursor_animation_length = 0

vim.g.neovide_scroll_animation_length = 0

if vim.g.is_linux then
    vim.g.neovide_opacity = 0.825
end
