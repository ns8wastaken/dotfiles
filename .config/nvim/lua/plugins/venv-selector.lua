return {
    "linux-cultist/venv-selector.nvim",

    dependencies = {
        "neovim/nvim-lspconfig",
        "nvim-telescope/telescope.nvim"
    },

    branch = "regexp", -- This is the regexp branch, use this for the new version

    keys = {
        { "<Leader>v", "<cmd>VenvSelect<cr>" }
    },

    opts = {
        search = {
            find_code_venvs = {
                command = "fd 'python$' ~/code/ --no-ignore --color never"
            }
        }
    }
}
