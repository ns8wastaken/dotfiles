return {
    'nvim-treesitter/nvim-treesitter',

    run = ':TSUpdate',

    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {
                'c', 'cpp',
                'javascript', 'typescript', 'html', 'css',
                'vim', 'vimdoc',
                'python',
                'markdown', 'yaml', 'toml'
            },

            highlight = {
                enable = true, -- Enable syntax highlighting
            },

            indent = {
                enable = true, -- Enable smart indentation
            }
        })
    end
}
