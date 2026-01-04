return {
    "xiyaowong/transparent.nvim",

    lazy = false,

    opts = {
        groups = {
            -- "Comment", "Constant", "Special", "Identifier",
            -- "Statement", "PreProc", "Type", "Underlined", "Todo", "String", "Function",
            -- "Conditional", "Repeat", "Operator", "Structure", "NonText",

            "Normal", "NormalNC", "NormalFloat", "FloatBorder",
            "MsgArea", "ModeMsg", "ErrorMsg",
            "LineNr", "CursorLineNr", "EndOfBuffer", "SignColumn",
            "VertSplit", "WinSeparator",
            "CursorLine", "StatusLine", "StatusLineNC"
        },

        -- additional groups that should be cleared
        extra_groups = {
            "LazyNormal",
            "LspInlayHint",
            "BlinkCmpMenu", "BlinkCmpMenuBorder", "BlinkCmpLabelDetail", "BlinkCmpLabelDescription"
        },

        -- groups you don't want to clear
        exclude_groups = {},

        -- function: code to be executed after highlight groups are cleared
        -- Also the user event "TransparentClear" will be triggered
        on_clear = function() end,
    },

    config = function(_, opts)
        local transparent = require("transparent")

        transparent.setup(opts)

        transparent.clear_prefix("Telescope")
        transparent.clear_prefix("Notify")
        transparent.clear_prefix("Grug")

        vim.g.transparent_groups = vim.list_extend(
            vim.g.transparent_groups or {},
            opts.extra_groups
        )
    end
}
