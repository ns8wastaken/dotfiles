return {
    "ej-shafran/compile-mode.nvim",

    dependencies = {
        "nvim-lua/plenary.nvim",
        -- For ANSI escape codes coloring
        { "m00qek/baleia.nvim" },
    },

    keys = {
        { "<Leader>cc", "<cmd>Compile<cr>",        desc = "Compile" },
        { "<Leader>R", "<cmd>Recompile<cr>",       desc = "Recompile" },
        { "<Leader>cn", "<cmd>NextError<cr>",      desc = "Next compile error" },
        { "<Leader>cp", "<cmd>PrevError<cr>",      desc = "Prev compile error" },
        { "<Leader>cq", "<cmd>QuickfixErrors<cr>", desc = "Send errors to quickfix" },
    },

    config = function()
        vim.g.compile_mode = {
            -- if you use something like `nvim-cmp` or `blink.cmp` for completion,
            -- set this to fix tab completion in command mode:
            -- input_word_completion = true,

            -- to add ANSI escape code support, add:
            baleia_setup = true,

            -- to make `:Compile` replace special characters (e.g. `%`) in
            -- the command (and behave more like `:!`), add:
            -- bang_expansion = true,
        }
    end
}
