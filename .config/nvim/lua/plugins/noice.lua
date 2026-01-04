return {
    "folke/noice.nvim",

    event = "VeryLazy",

    enabled = false,

    dependencies = {
        "MunifTanjim/nui.nvim",
        "rcarriga/nvim-notify"
    },

    opts = {
        -- cmdline = {
        --     view = "cmdline"
        -- },

        -- Show stuff in notifications
        routes = {
            -- { view = "notify",         filter = { event = "msg_showmode" } },
            { view = "split", filter = { cmdline = "^(:lua)" } },
            { view = "cmdline_output", filter = { cmdline = "^:" } }
        },

        lsp = {
            -- Override markdown rendering so that **cmp** and other plugins use **Treesitter**
            override = {
                ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                ["vim.lsp.util.stylize_markdown"] = true,
                ["cmp.entry.get_documentation"] = true -- requires hrsh7th/nvim-cmp
            }
        },

        views = {
            -- Rounded cmp borders
            hover = {
                border = {
                    style = "rounded"
                },
                position = { row = 2, col = 2 }
            },

            cmdline_output = {
                format = "details",
                view = "notify",
            },

            cmdline_popup = {
                position = {
                    row = 5,
                    col = "50%"
                },
                size = {
                    width = 60,
                    height = "auto"
                }
            },

            mini = {
                timeout = 10000
            },

            popupmenu = {
                relative = "editor",
                position = {
                    row = 5 + 3,
                    col = "50%"
                },
                size = {
                    width = 60,
                    height = 10
                },
                border = {
                    -- style = "rounded",
                    padding = { 0, 1 }
                },
                win_options = {
                    winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" }
                }
            }
        }
    }
}
