local textcase = require("textcase")

local map = function(mode, bind, func, desc)
    vim.keymap.set(mode, bind, func, {
        noremap = true,
        silent = true,
        desc = desc
    })
end

local prefix = "ga"
local prefix_ops = "ge"

local cases = {
    { desc = "UPPER CASE",    func = "to_upper_case",    key = "u", lsp = "U" },
    { desc = "cower case",    func = "to_lower_case",    key = "l", lsp = "L" },
    { desc = "snake_case",    func = "to_snake_case",    key = "s", lsp = "S" },
    { desc = "dash-case",     func = "to_dash_case",     key = "d", lsp = "D" },
    { desc = "CONSTANT_CASE", func = "to_constant_case", key = "n", lsp = "N" },
    { desc = "dot.case",      func = "to_dot_case",      key = ".", lsp = ">" },
    { desc = "comma,case",    func = "to_comma_case",    key = ",", lsp = "<" },
    { desc = "Phrase case",   func = "to_phrase_case",   key = "a", lsp = "A" },
    { desc = "camelCase",     func = "to_camel_case",    key = "c", lsp = "C" },
    { desc = "PascalCase",    func = "to_pascal_case",   key = "p", lsp = "P" },
    { desc = "Title Case",    func = "to_title_case",    key = "t", lsp = "T" },
    { desc = "path/case",     func = "to_path_case",     key = "f", lsp = "F" }
}

local map_case = function(mode, case)
    -- Normal mappings (ga + special/upper key)
    map(mode, prefix .. case.key, function()
        textcase.current_word(case.func)
    end, "Convert to: " .. case.desc)

    -- LSP rename mappings (ga + special/upper key)
    map(mode, prefix .. case.lsp, function()
        textcase.lsp_rename(case.func)
    end, "LSP Rename: " .. case.desc)

    -- Operator mappings (ge + key)
    map(mode, prefix_ops .. case.key, function()
        textcase.operator(case.func)
    end, "Operator: " .. case.desc)
end

for _, c in ipairs(cases) do
    map_case({ 'n', 'v' }, c)
end

map({ 'n', 'v' }, "ga.", "<cmd>TextCaseOpenTelescope<CR>")
