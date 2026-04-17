return {
    "nvim-treesitter/nvim-treesitter",

    build = ":TSUpdate",

    main = "nvim-treesitter",

    init = function()
        vim.api.nvim_create_autocmd('FileType', {
            callback = function()
                -- Enable treesitter highlighting and disable regex syntax
                pcall(vim.treesitter.start)
                -- Enable treesitter-based indentation
                vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
            end,
        })

        local ensureInstalled = {
            "vim", "vimdoc",
            "javascript", "typescript", "html", "css",
            "python",
            "c", "cpp",
            "rust",
            "markdown", "yaml", "toml"
        }
        local alreadyInstalled = require("nvim-treesitter.config").get_installed()
        local parsersToInstall = vim.iter(ensureInstalled)
            :filter(function(parser)
                return not vim.tbl_contains(alreadyInstalled, parser)
            end)
            :totable()
        require("nvim-treesitter").install(parsersToInstall)
    end,
}
