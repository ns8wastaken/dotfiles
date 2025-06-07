return {
    'nvim-treesitter/nvim-treesitter',

    run = ':TSUpdate',

    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'vim', 'vimdoc',
                'javascript', 'typescript', 'html', 'css',
                'python',
                'c', 'cpp',
                'markdown', 'yaml', 'toml'
            },

            highlight = {
                enable = true -- Enable syntax highlighting
            },

            indent = {
                enable = true -- Enable smart indentation
            }
        })
    end
}
