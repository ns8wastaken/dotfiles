local themes = require("themes")

return {
    "neovim/nvim-lspconfig",
    "ntpeters/vim-better-whitespace",
    "nvim-lualine/lualine.nvim",
    "preservim/nerdcommenter",
    { "rcarriga/nvim-notify", opts = { background_colour = "#000000" } },
    "mg979/vim-visual-multi",
    { "echasnovski/mini.surround", opts = {} },
    "johmsalas/text-case.nvim",
    "matze/vim-move",
    "junegunn/vim-easy-align",
    { "nvim-tree/nvim-web-devicons", opts = {} },
    { "folke/todo-comments.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    "MagicDuck/grug-far.nvim",

    themes
}
