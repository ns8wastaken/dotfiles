return {
    "linux-cultist/venv-selector.nvim",

    dependencies = {
        "neovim/nvim-lspconfig",
        -- "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
        "nvim-telescope/telescope.nvim"
    },

    branch = "regexp", -- This is the regexp branch, use this for the new version

    keys = {
        { ",v", "<cmd>VenvSelect<cr>" }
    },

    opts = {
        search = {
            find_code_venvs = {
                command = "fd 'python$' ~/code/ --no-ignore"
            }
        }
    }
}
