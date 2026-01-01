return {
    -- Lush for extended compatibility or something
    "rktjmp/lush.nvim",

    { "rebelot/kanagawa.nvim",         name = "kanagawa" },
    { "scottmckendry/cyberdream.nvim", name = "cyberdream" },
    { "blazkowolf/gruber-darker.nvim", name = "gruber-darker" },
    { "sainnhe/gruvbox-material",      name = "gruvbox-material" },
    { "navarasu/onedark.nvim",         name = "onedark" },
    { "projekt0n/github-nvim-theme",   name = "github" },
    { "catppuccin/nvim",               name = "catppuccin" },
    { "daschw/leaf.nvim",              name = "leaf" },
    {
        "kartikp10/noctis.nvim",
        dependencies = { "rktjmp/lush.nvim" },
        name = "noctis"
    }
}
