return {
    "xiyaowong/transparent.nvim",

    lazy = false,

    opts = {
        groups = {
            -- "Comment", "Constant", "Special", "Identifier",
            -- "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
            -- "Conditional", "Repeat", "Operator", "Structure", "NonText",

            "Normal", "NormalNC", "NormalFloat", "FloatBorder",
            "MsgArea",
            "LineNr", "CursorLineNr", "EndOfBuffer", "SignColumn",
            "VertSplit", "WinSeparator",
            "CursorLine", "StatusLine", "StatusLineNC"
        },

        -- additional groups that should be cleared
        extra_groups = {
            "ModeMsg", "ErrorMsg", -- notification message body
            "LspInlayHint"
        },

        -- groups you don't want to clear
        exclude_groups = {},

        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
    },

    config = function()
        local transparent = require("transparent")
        transparent.clear_prefix("Telescope")
        transparent.clear_prefix("Notify")
        transparent.clear_prefix("Grug")
    end
}
