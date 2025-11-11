return {
    "nvim-telescope/telescope-file-browser.nvim",

    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim"
    },

    config = function()
        local telescope = require("telescope")

        telescope.setup({
            extensions = {
                file_browser = {
                    -- theme = 'ivy',

                    -- Disables netrw and use telescope-file-browser in its place
                    -- hijack_netrw = true,
                }
            }
        })

        telescope.load_extension("file_browser")
    end
}
