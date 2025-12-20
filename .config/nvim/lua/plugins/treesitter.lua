return {
    "nvim-treesitter/nvim-treesitter",
    branch = 'master',

    build = ":TSUpdate",

    main = "nvim-treesitter.configs",

    opts = {
        ensure_installed = {
            "vim", "vimdoc",
            "javascript", "typescript", "html", "css",
            "python",
            "c", "cpp",
            "markdown", "yaml", "toml"
        },

        auto_install = true,

        highlight = {
            enable = true -- Enable syntax highlighting
        },

        indent = {
            enable = true -- Enable smart indentation
        }
    }
}
